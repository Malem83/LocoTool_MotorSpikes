outname='Database_17232'
%bin size (in s)
bin=0.01
%maximal latency
maxlat=0.05
maxlat=maxlat/bin;
%time window in sec to compute motor unit density
tw_pre=0.5;
tw_post=1.5;
Time=[];
tmbin=(tw_pre+tw_post)/bin;
for i=1:tmbin
   Time(i,1)=-tw_pre+(i-1)*bin; 
end 
%transform tw in bins;
tw_pre=tw_pre/bin
tw_post=tw_post/bin
%time window for a false interruption
tw=0.05;
%transform in bin
tw=tw/bin;
%check the directory, count nb of file
datalist=dir;
nbfile=length(datalist);
nbelem=0;
MotorSynth=[];

   

%read directory. How many file do we have? create a database.
for a=1:nbfile
    if datalist(a).isdir == 0    
        if length(datalist(a).name)== 39
        b=datalist(a).name(10:13);
        c=datalist(a).name(36:39);
        if b == 'rest' & c == '.mat'
            nbelem=nbelem+1;
            MotorSynth(nbelem).nucleus=datalist(a).name(1:3);
            MotorSynth(nbelem).ID=datalist(a).name(4:8);
            MotorSynth(nbelem).time=datalist(a).name(15:17);
            MotorSynth(nbelem).intensity=datalist(a).name(22:23);
            MotorSynth(nbelem).duration=datalist(a).name(28:30);
            MotorSynth(nbelem).frequency=datalist(a).name(33:35);
        end
        end
    end    
end



nbbin=0;

%store data in a new structure
for b=1:nbelem
    %set the name and load file #b
    tempname=strcat(MotorSynth(b).nucleus,MotorSynth(b).ID, '_rest_', MotorSynth(b).time, '_int', MotorSynth(b).intensity, '_dur', MotorSynth(b).duration, '_f', MotorSynth(b).frequency, '.mat');
    load(tempname);
    %extract stim datase
    cnt=1;
    if MotorSynth(b).frequency=='sin'
       for i=1:2:length(stim.times)
           MotorSynth(b).stim(cnt,1)=stim.times(i,1);
           cnt=cnt+1;
       end
    else
        %to expand code; 1 train will be considered as 1 single stime
        str2num(MotorSynth(b).frequency)
    end    
    %create an histogram to represent firing
    nbbin=floor(max(LTA.times(:,1))/bin)+1;
    MotorSynth(b).LTA_hst=zeros([nbbin, 1]);
    for k=1:length(LTA_units.times(:,1))
        val=floor(LTA_units.times(k)/bin)+1;
        MotorSynth(b).LTA_hst(val, 1)=MotorSynth(b).LTA_hst(val, 1)+1;
    end 
    MotorSynth(b).LGL_hst=zeros([nbbin, 1]);
    for k=1:length(LGL_units.times(:,1))
        val=floor(LGL_units.times(k)/bin)+1;
        MotorSynth(b).LGL_hst(val, 1)=MotorSynth(b).LGL_hst(val, 1)+1;
    end 
    MotorSynth(b).RTA_hst=zeros([nbbin, 1]);
    for k=1:length(RTA_units.times(:,1))
        val=floor(RTA_units.times(k)/bin)+1;
        MotorSynth(b).RTA_hst(val, 1)=MotorSynth(b).RTA_hst(val, 1)+1;
    end 
    MotorSynth(b).RGL_hst=zeros([nbbin, 1]);
    for k=1:length(RGL_units.times(:,1))
        val=floor(RGL_units.times(k)/bin)+1;
        MotorSynth(b).RGL_hst(val, 1)=MotorSynth(b).RGL_hst(val, 1)+1;
    end 
end


%Measurements for LTA
for b=1:nbelem
    pos=0;
    thr=0;
    for m=1:length(MotorSynth(b).stim)
        pos=floor(MotorSynth(b).stim(m,1)/bin)+1;
        MotorSynth(b).LTAtrig(:,m)=MotorSynth(b).LTA_hst((pos-tw_pre):(pos+tw_post), 1);
        MotorSynth(b).LTAmax(m,1)=max(MotorSynth(b).LTA_hst(pos:(pos+maxlat), 1));
        MotorSynth(b).LTAbsl(m,1)=mean(MotorSynth(b).LTA_hst((pos-tw_pre):(pos-1), 1));
        MotorSynth(b).LTAbsl(m,2)=std(MotorSynth(b).LTA_hst((pos-tw_pre):(pos-1), 1));
        ONthr=MotorSynth(b).LTAbsl(m,1)+2*MotorSynth(b).LTAbsl(m,2);
        OFFthr=MotorSynth(b).LTAbsl(m,1)+(MotorSynth(b).LTAmax(m,1)-MotorSynth(b).LTAbsl(m,1))/2;
        
        ISTHERERESP=max(MotorSynth(b).LTA_hst(pos:(pos+maxlat), 1));
        if ISTHERERESP>ONthr
        %reset all parameters
        pnt1=0;
        pnt2=0;
        cntx=0;
        cntj=0;
        j=pos;
        while cntx==0
            %looking for the onset
            if cntj==0
                %the onset has been found
                if MotorSynth(b).LTA_hst(j,1)>ONthr
                    cntj=1;
                    pnt1=j;
                    if MotorSynth(b).LTA_hst(j,1)==MotorSynth(b).LTAmax(m,1)
                    %this is the peak, right at the onset of the response    
                    cntj=2;
                    end
                end
            %now we are looking for the peak of the burst
            elseif cntj==1
                if MotorSynth(b).LTA_hst(j,1)==MotorSynth(b).LTAmax(m,1)
                    cntj=2;
                end
            %now we are looking for the termination
            else
                %we crossed below threshold
                if MotorSynth(b).LTA_hst(j,1)<OFFthr
                    %we stay below threshold for the defined time window
                    if MotorSynth(b).LTA_hst(j+tw,1)<OFFthr
                        pnt2=j;
                        cntx=1;
                    end
                end
            end
            j=j+1;
            %burst is longer than the recording
            if j==pos+tw_post-3
               cntx=1;
               pnt2=pos+tw_post-3;
            end
        end
        MotorSynth(b).LTAdur(m,1)=(pnt2-pnt1)*bin;
        
        %computing nb of motor units in the time window
        MotorSynth(b).LTAMUnb(m,1)=sum(MotorSynth(b).LTA_hst(pnt1:pnt2,1))-(pnt2-pnt1)*MotorSynth(b).LTAbsl(m,1);
    else
    MotorSynth(b).LTAdur(m,1)=0;
    MotorSynth(b).LTAMUnb(m,1)=0;
    end
    end    
end

%Measurements for LGL
for b=1:nbelem
    pos=0;
    thr=0;
    for m=1:length(MotorSynth(b).stim)
        pos=floor(MotorSynth(b).stim(m,1)/bin)+1;
        MotorSynth(b).LGLtrig(:,m)=MotorSynth(b).LGL_hst((pos-tw_pre):(pos+tw_post), 1);
        MotorSynth(b).LGLmax(m,1)=max(MotorSynth(b).LGL_hst(pos:(pos+maxlat), 1));
        MotorSynth(b).LGLbsl(m,1)=mean(MotorSynth(b).LGL_hst((pos-tw_pre):(pos-1), 1));
        MotorSynth(b).LGLbsl(m,2)=std(MotorSynth(b).LGL_hst((pos-tw_pre):(pos-1), 1));
        ONthr=MotorSynth(b).LGLbsl(m,1)+2*MotorSynth(b).LGLbsl(m,2);
        OFFthr=MotorSynth(b).LGLbsl(m,1)+(MotorSynth(b).LGLmax(m,1)-MotorSynth(b).LGLbsl(m,1))/2;
        
        ISTHERERESP=max(MotorSynth(b).LGL_hst(pos:(pos+maxlat), 1));
        if ISTHERERESP>ONthr
        %reset all parameters
        pnt1=0;
        pnt2=0;
        cntx=0;
        cntj=0;
        j=pos;
        while cntx==0
            %looking for the onset
            if cntj==0
                %the onset has been found
                if MotorSynth(b).LGL_hst(j,1)>ONthr
                    cntj=1;
                    pnt1=j;
                    if MotorSynth(b).LGL_hst(j,1)==MotorSynth(b).LGLmax(m,1)
                    %this is the peak, right at the onset of the response    
                    cntj=2;
                    end
                end
            %now we are looking for the peak of the burst
            elseif cntj==1
                if MotorSynth(b).LGL_hst(j,1)==MotorSynth(b).LGLmax(m,1)
                    cntj=2;
                end
            %now we are looking for the termination
            else
                %we crossed below threshold
                if MotorSynth(b).LGL_hst(j,1)<OFFthr
                    %we stay below threshold for the defined time window
                    if MotorSynth(b).LGL_hst(j+tw,1)<OFFthr
                        pnt2=j;
                        cntx=1;
                    end
                end
            end
            j=j+1;
            %burst is longer than the recording
            if j==pos+tw_post-3
               cntx=1;
               pnt2=pos+tw_post-3;
            end
        end
        MotorSynth(b).LGLdur(m,1)=(pnt2-pnt1)*bin;
        
        %computing nb of motor units in the time window
        MotorSynth(b).LGLMUnb(m,1)=sum(MotorSynth(b).LGL_hst(pnt1:pnt2,1))-(pnt2-pnt1)*MotorSynth(b).LGLbsl(m,1);
    else
    MotorSynth(b).LGLdur(m,1)=0;
    MotorSynth(b).LGLMUnb(m,1)=0;
    end
    end
end

%Measurements for RTA
for b=1:nbelem
    pos=0;
    thr=0;
    for m=1:length(MotorSynth(b).stim)
        pos=floor(MotorSynth(b).stim(m,1)/bin)+1;
        MotorSynth(b).RTAtrig(:,m)=MotorSynth(b).RTA_hst((pos-tw_pre):(pos+tw_post), 1);
        MotorSynth(b).RTAmax(m,1)=max(MotorSynth(b).RTA_hst(pos:(pos+maxlat), 1));
        MotorSynth(b).RTAbsl(m,1)=mean(MotorSynth(b).RTA_hst((pos-tw_pre):(pos-1), 1));
        MotorSynth(b).RTAbsl(m,2)=std(MotorSynth(b).RTA_hst((pos-tw_pre):(pos-1), 1));
        ONthr=MotorSynth(b).RTAbsl(m,1)+2*MotorSynth(b).RTAbsl(m,2);
        OFFthr=MotorSynth(b).RTAbsl(m,1)+(MotorSynth(b).RTAmax(m,1)-MotorSynth(b).RTAbsl(m,1))/2;
        
        ISTHERERESP=max(MotorSynth(b).RTA_hst(pos:(pos+maxlat), 1));
        if ISTHERERESP>ONthr
        %reset all parameters
        pnt1=0;
        pnt2=0;
        cntx=0;
        cntj=0;
        j=pos;
        while cntx==0
            %looking for the onset
            if cntj==0
                %the onset has been found
                if MotorSynth(b).RTA_hst(j,1)>ONthr
                    cntj=1;
                    pnt1=j;
                    if MotorSynth(b).RTA_hst(j,1)==MotorSynth(b).RTAmax(m,1)
                    %this is the peak, right at the onset of the response    
                    cntj=2;
                    end
                end
            %now we are looking for the peak of the burst
            elseif cntj==1
                if MotorSynth(b).RTA_hst(j,1)==MotorSynth(b).RTAmax(m,1)
                    cntj=2;
                end
            %now we are looking for the termination
            else
                %we crossed below threshold
                if MotorSynth(b).RTA_hst(j,1)<OFFthr
                    %we stay below threshold for the defined time window
                    if MotorSynth(b).RTA_hst(j+tw,1)<OFFthr
                        pnt2=j;
                        cntx=1;
                    end
                end
            end
            j=j+1;
            %burst is longer than the recording
            if j==pos+tw_post-3
               cntx=1;
               pnt2=pos+tw_post-3;
            end
        end
        MotorSynth(b).RTAdur(m,1)=(pnt2-pnt1)*bin;
        
        %computing nb of motor units in the time window
        MotorSynth(b).RTAMUnb(m,1)=sum(MotorSynth(b).RTA_hst(pnt1:pnt2,1))-(pnt2-pnt1)*MotorSynth(b).RTAbsl(m,1);
    else
    MotorSynth(b).RTAdur(m,1)=0;
    MotorSynth(b).RTAMUnb(m,1)=0;
    end
    end
end

%Measurements for RGL
for b=1:nbelem
    pos=0;
    thr=0;
    for m=1:length(MotorSynth(b).stim)
        pos=floor(MotorSynth(b).stim(m,1)/bin)+1;
        MotorSynth(b).RGLtrig(:,m)=MotorSynth(b).RGL_hst((pos-tw_pre):(pos+tw_post), 1);
        MotorSynth(b).RGLmax(m,1)=max(MotorSynth(b).RGL_hst(pos:(pos+maxlat), 1));
        MotorSynth(b).RGLbsl(m,1)=mean(MotorSynth(b).RGL_hst((pos-tw_pre):(pos-1), 1));
        MotorSynth(b).RGLbsl(m,2)=std(MotorSynth(b).RGL_hst((pos-tw_pre):(pos-1), 1));
        ONthr=MotorSynth(b).RGLbsl(m,1)+2*MotorSynth(b).RGLbsl(m,2);
        OFFthr=MotorSynth(b).RGLbsl(m,1)+(MotorSynth(b).RGLmax(m,1)-MotorSynth(b).RGLbsl(m,1))/2;
        
        ISTHERERESP=max(MotorSynth(b).RGL_hst(pos:(pos+maxlat), 1));
        if ISTHERERESP>ONthr
        %reset all parameters
        pnt1=0;
        pnt2=0;
        cntx=0;
        cntj=0;
        j=pos;
        while cntx==0
            %looking for the onset
            if cntj==0
                %the onset has been found
                if MotorSynth(b).RGL_hst(j,1)>ONthr
                    cntj=1;
                    pnt1=j;
                    if MotorSynth(b).RGL_hst(j,1)==MotorSynth(b).RGLmax(m,1)
                    %this is the peak, right at the onset of the response    
                    cntj=2;
                    end
                end
            %now we are looking for the peak of the burst
            elseif cntj==1
                if MotorSynth(b).RGL_hst(j,1)==MotorSynth(b).RGLmax(m,1)
                    cntj=2;
                end
            %now we are looking for the termination
            else
                %we crossed below threshold
                if MotorSynth(b).RGL_hst(j,1)<OFFthr
                    %we stay below threshold for the defined time window
                    if MotorSynth(b).RGL_hst(j+tw,1)<OFFthr
                        pnt2=j;
                        cntx=1;
                    end
                end
            end
            j=j+1;
            %burst is longer than the recording
            if j==pos+tw_post-3
               cntx=1;
               pnt2=pos+tw_post-3;
            end
        end
        MotorSynth(b).RGLdur(m,1)=(pnt2-pnt1)*bin;
        
        %computing nb of motor units in the time window
        MotorSynth(b).RGLMUnb(m,1)=sum(MotorSynth(b).RGL_hst(pnt1:pnt2,1))-(pnt2-pnt1)*MotorSynth(b).RGLbsl(m,1);
    else
    MotorSynth(b).RGLdur(m,1)=0;
    MotorSynth(b).RGLMUnb(m,1)=0;
    end
    end
end
%save data
save(outname, 'MotorSynth', 'Time')

clear all
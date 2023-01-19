function LocoAnalysis2b(inputname, timepoint, timewin)
%last update on November 29, 2021 

%inputname='Gi10852';
inputname2=strcat(inputname, '_stimtb.mat');
load(inputname2)

%desired time precision in ms
precision2=10
MUprecision=precision2/1000;
nbbin=floor((timewin)/MUprecision)
%time window for response evaluation in ms
twin=50;
twin=twin/precision2;

%extract value for control period
d=0;
for c=1:length(LocoSynth);
   if  LocoSynth(c).time==timepoint
        d=c
   end    
end   

if d==0
    disp('CTL data is missing; end script')
    return
else    
    temp=[];
    STIM_DATA_MU=[];
    tempname=strcat(LocoSynth(d).nucleus, LocoSynth(d).ID, '_', LocoSynth(d).time, '_loco_int', LocoSynth(d).intensity, '_dur', LocoSynth(d).duration, '.mat');
    load(tempname);

    
    %make timebase for graph
    time=[];
    for t=-nbbin:(nbbin-1)
        cnt=t+nbbin+1;
        time(cnt,1)=t*MUprecision;
    end    
    Fig1=figure
    
    %triggering stim for RTA
    subplot(4,2,1)
    xlabel('Pre-stim MU')
    ylabel('nb of MU')
    title('RTA MU')
    hold all
    tempMUA=abs(LocoSynth(d).RTAunit);
    
    for j=1:length(LocoSynth(d).cycstim)
        STIM_DATA_MU(j).time=LocoSynth(d).cycstim(j,1);
        cnt=0;
        cnt2=1;
        for t=-nbbin:(nbbin-1)
            cnt=t+nbbin+1;
            curpos=(LocoSynth(d).cycstim(j,1)+(t*MUprecision));
            cond=1;
            cnt3=1;
            temp=[];
            
            if cnt2==length(tempMUA(:,1))
                  %break the loop
                   cond=0; 
            end  
            
            while cond==1
               if tempMUA(cnt2,1)<curpos
                   %increment timer
                   cnt2=cnt2+1;
               elseif tempMUA(cnt2,1)>=curpos && tempMUA(cnt2,1)<curpos+MUprecision
                   %store data in the bin
                   temp(cnt3,:)=tempMUA(cnt2,:);
                   cnt3=cnt3+1;
                   cnt2=cnt2+1;
               elseif tempMUA(cnt2,1)>=curpos+MUprecision
                   %break the loop
                   cond=0;  
               end    
               
               if cnt2==length(tempMUA(:,1))
                  %break the loop
                   cond=0; 
                end  
            end    
            %store data in histograms (col 1 = density, col 2 = amplitude)
            if isempty(temp)==0
                temp2(cnt,1)=length(temp(:,1));
                temp2(cnt,2)=mean(temp(:,2));
            else
                temp2(cnt,1)=0;
                temp2(cnt,2)=0;
            end    
        end   
        STIM_DATA_MU(j).mudRTA=temp2(:,1);
        STIM_DATA_MU(j).muaRTA=temp2(:,2);
        RTA_MUD_ALL(j,2:(2*nbbin+1))=temp2(:,1);
        RTA_MUA_ALL(j,2:(2*nbbin+1))=temp2(:,2);
        STIM_DATA_MU(j).mudRTAPre=sum(temp2((nbbin-twin):nbbin, 1));
        STIM_DATA_MU(j).muaRTAPre=max(temp2((nbbin-twin):nbbin, 2));
        STIM_DATA_MU(j).mudRTAPost=sum(temp2(nbbin:(nbbin+twin), 1));
        STIM_DATA_MU(j).muaRTAPost=max(temp2(nbbin:(nbbin+twin), 2));
        STIM_DATA_MU(j).mudRTAresp=STIM_DATA_MU(j).mudRTAPost-STIM_DATA_MU(j).mudRTAPre;
        STIM_DATA_MU(j).muaRTAresp=STIM_DATA_MU(j).muaRTAPost-STIM_DATA_MU(j).muaRTAPre;
        RTA_MUD_ALL(j,1)=STIM_DATA_MU(j).mudRTAresp;
        RTA_MUA_ALL(j,1)=STIM_DATA_MU(j).muaRTAresp;
        scatter(STIM_DATA_MU(j).mudRTAPre, STIM_DATA_MU(j).mudRTAresp, 'ok')
    end    
    RTA_MUD_ALL_SORTED=sortrows(RTA_MUD_ALL);
    RTA_MUA_ALL_SORTED=sortrows(RTA_MUA_ALL);
    subplot(4,2,2)
    imagesc('XData', time, 'CData', RTA_MUD_ALL_SORTED(:,2:(2*nbbin+1)))
    xlabel('time')
    ylabel('stim#')
    
    %triggering stim for RGL
    subplot(4,2,3)
    xlabel('Pre-stim MU')
    ylabel('nb of MU')
    title('RGL MU')
    hold all
    tempMUA=abs(LocoSynth(d).RGLunit);
    
    for j=1:length(LocoSynth(d).cycstim)
        cnt=0;
        cnt2=1;
        for t=-nbbin:(nbbin-1)
            cnt=t+nbbin+1;
            curpos=(LocoSynth(d).cycstim(j,1)+(t*MUprecision));
            cond=1;
            cnt3=1;
            temp=[];
            
            if cnt2==length(tempMUA(:,1))
                  %break the loop
                   cond=0; 
            end  
            
            while cond==1
               if tempMUA(cnt2,1)<curpos
                   %increment timer
                   cnt2=cnt2+1;
               elseif tempMUA(cnt2,1)>=curpos && tempMUA(cnt2,1)<curpos+MUprecision
                   %store data in the bin
                   temp(cnt3,:)=tempMUA(cnt2,:);
                   cnt3=cnt3+1;
                   cnt2=cnt2+1;
               elseif tempMUA(cnt2,1)>=curpos+MUprecision
                   %break the loop
                   cond=0;  
               end    
               
               if cnt2==length(tempMUA(:,1))
                  %break the loop
                   cond=0; 
               end  
            end    
            %store data in histograms (col 1 = density, col 2 = amplitude)
            if isempty(temp)==0
                temp2(cnt,1)=length(temp(:,1));
                temp2(cnt,2)=mean(temp(:,2));
            else
                temp2(cnt,1)=0;
                temp2(cnt,2)=0;
            end    
        end   
        STIM_DATA_MU(j).mudRGL=temp2(:,1);
        STIM_DATA_MU(j).muaRGL=temp2(:,2);
        RGL_MUD_ALL(j,2:(2*nbbin+1))=temp2(:,1);
        RGL_MUA_ALL(j,2:(2*nbbin+1))=temp2(:,2);
        STIM_DATA_MU(j).mudRGLPre=sum(temp2((nbbin-twin):nbbin, 1));
        STIM_DATA_MU(j).muaRGLPre=max(temp2((nbbin-twin):nbbin, 2));
        STIM_DATA_MU(j).mudRGLPost=sum(temp2(nbbin:(nbbin+twin), 1));
        STIM_DATA_MU(j).muaRGLPost=max(temp2(nbbin:(nbbin+twin), 2));
        STIM_DATA_MU(j).mudRGLresp=STIM_DATA_MU(j).mudRGLPost-STIM_DATA_MU(j).mudRGLPre;
        STIM_DATA_MU(j).muaRGLresp=STIM_DATA_MU(j).muaRGLPost-STIM_DATA_MU(j).muaRGLPre;
        RGL_MUD_ALL(j,1)=STIM_DATA_MU(j).mudRGLresp;
        RGL_MUA_ALL(j,1)=STIM_DATA_MU(j).muaRGLresp;
        scatter(STIM_DATA_MU(j).mudRGLPre, STIM_DATA_MU(j).mudRGLresp, 'ok')
    end    
    RGL_MUD_ALL_SORTED=sortrows(RGL_MUD_ALL);
    RGL_MUA_ALL_SORTED=sortrows(RGL_MUA_ALL);
    subplot(4,2,4)
    imagesc('XData', time, 'CData', RGL_MUD_ALL_SORTED(:,2:(2*nbbin+1)))
    
    %triggering stim for LTA
    subplot(4,2,5)
    xlabel('Pre-stim MU')
    ylabel('nb of MU')
    title('LTA MU')
    hold all
    tempMUA=abs(LocoSynth(d).LTAunit);
    
    for j=1:length(LocoSynth(d).cycstim)
        cnt=0;
        cnt2=1;
        for t=-nbbin:(nbbin-1)
            cnt=t+nbbin+1;
            curpos=(LocoSynth(d).cycstim(j,1)+(t*MUprecision));
            cond=1;
            cnt3=1;
            temp=[];
            
            if cnt2==length(tempMUA(:,1))
                  %break the loop
                   cond=0; 
            end  
            
            while cond==1
               if tempMUA(cnt2,1)<curpos
                   %increment timer
                   cnt2=cnt2+1;
               elseif tempMUA(cnt2,1)>=curpos && tempMUA(cnt2,1)<curpos+MUprecision
                   %store data in the bin
                   temp(cnt3,:)=tempMUA(cnt2,:);
                   cnt3=cnt3+1;
                   cnt2=cnt2+1;
               elseif tempMUA(cnt2,1)>=curpos+MUprecision
                   %break the loop
                   cond=0;  
               end    
               
               if cnt2==length(tempMUA(:,1))
                  %break the loop
                   cond=0; 
                end  
            end    
            %store data in histograms (col 1 = density, col 2 = amplitude)
            if isempty(temp)==0
                temp2(cnt,1)=length(temp(:,1));
                temp2(cnt,2)=mean(temp(:,2));
            else
                temp2(cnt,1)=0;
                temp2(cnt,2)=0;
            end    
        end   
        STIM_DATA_MU(j).mudLTA=temp2(:,1);
        STIM_DATA_MU(j).muaLTA=temp2(:,2);
        LTA_MUD_ALL(j,2:(2*nbbin+1))=temp2(:,1);
        LTA_MUA_ALL(j,2:(2*nbbin+1))=temp2(:,2);
        STIM_DATA_MU(j).mudLTAPre=sum(temp2((nbbin-twin):nbbin, 1));
        STIM_DATA_MU(j).muaLTAPre=max(temp2((nbbin-twin):nbbin, 2));
        STIM_DATA_MU(j).mudLTAPost=sum(temp2(nbbin:(nbbin+twin), 1));
        STIM_DATA_MU(j).muaLTAPost=max(temp2(nbbin:(nbbin+twin), 2));
        STIM_DATA_MU(j).mudLTAresp=STIM_DATA_MU(j).mudLTAPost-STIM_DATA_MU(j).mudLTAPre;
        STIM_DATA_MU(j).muaLTAresp=STIM_DATA_MU(j).muaLTAPost-STIM_DATA_MU(j).muaLTAPre;
        LTA_MUD_ALL(j,1)=STIM_DATA_MU(j).mudLTAresp;
        LTA_MUA_ALL(j,1)=STIM_DATA_MU(j).muaLTAresp;
        scatter(STIM_DATA_MU(j).mudLTAPre, STIM_DATA_MU(j).mudLTAresp, 'ok')
    end    
    LTA_MUD_ALL_SORTED=sortrows(LTA_MUD_ALL);
    LTA_MUA_ALL_SORTED=sortrows(LTA_MUA_ALL);
    subplot(4,2,6)
    imagesc('XData', time, 'CData', LTA_MUD_ALL_SORTED(:,2:(2*nbbin+1)))
    
    %triggering stim for LGL
    subplot(4,2,7)
    xlabel('Pre-stim MU')
    ylabel('nb of MU')
    title('LGL MU')
    hold all
    tempMUA=abs(LocoSynth(d).LGLunit);
    
    for j=1:length(LocoSynth(d).cycstim)
        cnt=0;
        cnt2=1;
        for t=-nbbin:(nbbin-1)
            cnt=t+nbbin+1;
            curpos=(LocoSynth(d).cycstim(j,1)+(t*MUprecision));
            cond=1;
            cnt3=1;
            temp=[];
            if cnt2==length(tempMUA(:,1))
                  %break the loop
                   cond=0; 
            end  
            
            while cond==1
               if tempMUA(cnt2,1)<curpos
                   %increment timer
                   cnt2=cnt2+1;
               elseif tempMUA(cnt2,1)>=curpos && tempMUA(cnt2,1)<curpos+MUprecision
                   %store data in the bin
                   temp(cnt3,:)=tempMUA(cnt2,:);
                   cnt3=cnt3+1;
                   cnt2=cnt2+1;
               elseif tempMUA(cnt2,1)>=curpos+MUprecision
                   %break the loop
                   cond=0;  
               end    
               
               if cnt2==length(tempMUA(:,1))
                  %break the loop
                   cond=0; 
                end  
            end    
            %store data in histograms (col 1 = density, col 2 = amplitude)
            if isempty(temp)==0
                temp2(cnt,1)=length(temp(:,1));
                temp2(cnt,2)=mean(temp(:,2));
            else
                temp2(cnt,1)=0;
                temp2(cnt,2)=0;
            end    
        end   
        STIM_DATA_MU(j).mudLGL=temp2(:,1);
        STIM_DATA_MU(j).muaLGL=temp2(:,2);
        LGL_MUD_ALL(j,2:(2*nbbin+1))=temp2(:,1);
        LGL_MUA_ALL(j,2:(2*nbbin+1))=temp2(:,2);
        STIM_DATA_MU(j).mudLGLPre=sum(temp2((nbbin-twin):nbbin, 1));
        STIM_DATA_MU(j).muaLGLPre=max(temp2((nbbin-twin):nbbin, 2));
        STIM_DATA_MU(j).mudLGLPost=sum(temp2(nbbin:(nbbin+twin), 1));
        STIM_DATA_MU(j).muaLGLPost=max(temp2(nbbin:(nbbin+twin), 2));
        STIM_DATA_MU(j).mudLGLresp=STIM_DATA_MU(j).mudLGLPost-STIM_DATA_MU(j).mudLGLPre;
        STIM_DATA_MU(j).muaLGLresp=STIM_DATA_MU(j).muaLGLPost-STIM_DATA_MU(j).muaLGLPre;
        LGL_MUD_ALL(j,1)=STIM_DATA_MU(j).mudLGLresp;
        LGL_MUA_ALL(j,1)=STIM_DATA_MU(j).muaLGLresp;
        scatter(STIM_DATA_MU(j).mudLGLPre, STIM_DATA_MU(j).mudLGLresp, 'ok')
    end    
    LGL_MUD_ALL_SORTED=sortrows(LGL_MUD_ALL);
    LGL_MUA_ALL_SORTED=sortrows(LGL_MUA_ALL);
    subplot(4,2,8)
    imagesc('XData', time, 'CData', LGL_MUD_ALL_SORTED(:,2:(2*nbbin+1)))
end    


outname2=strcat(inputname, '_', timepoint, '_trigMU.mat');
save(outname2, 'STIM_DATA_MU',...
       'RTA_MUD_ALL', 'RTA_MUA_ALL', 'RTA_MUD_ALL_SORTED', 'RTA_MUA_ALL_SORTED',...
       'RGL_MUD_ALL', 'RGL_MUA_ALL', 'RGL_MUD_ALL_SORTED', 'RGL_MUA_ALL_SORTED',...
       'LTA_MUD_ALL', 'LTA_MUA_ALL', 'LTA_MUD_ALL_SORTED', 'LTA_MUA_ALL_SORTED',...
       'LGL_MUD_ALL', 'LGL_MUA_ALL', 'LGL_MUD_ALL_SORTED', 'LGL_MUA_ALL_SORTED')
   
 
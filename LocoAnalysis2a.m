function LocoAnalysis2a(inputname, timepoint, timewin)
%inputname='Gi10852';
inputname2=strcat(inputname, '_stimtb.mat');
load(inputname2)
%desired time precision in ms
precision2=10
precision=precision2/1000;
nbbin=floor((timewin)/precision)
%time window for response evaluation in ms
twin=50;
twin=floor(twin/precision2);

%extract value for control period
d=0;
for c=1:length(LocoSynth);
   if  LocoSynth(c).time==timepoint
        d=c
   end    
end   

if d==0
    disp('data is missing; end script')
    return
else    
    temp=[];
    STIM_DATA_Z=[];
    tempname=strcat(LocoSynth(d).nucleus, LocoSynth(d).ID, '_', LocoSynth(d).time, '_loco_int', LocoSynth(d).intensity, '_dur', LocoSynth(d).duration, '.mat');
    load(tempname);
    resolution=round(precision/(RTA.interval))
    
    %make timebase for graph
    time=[];
    for t=-nbbin:(nbbin-1)
        cnt=t+nbbin+1;
        time(cnt,1)=t*precision;
    end    
    Fig1=figure
    
    %triggering stim for RTA
    subplot(4,2,1)
    xlabel('Pre-stim Z')
    ylabel('Z Response')
    title('RTA z-score')
    hold all
    for j=1:length(LocoSynth(d).cycstim)
        STIM_DATA_Z(j).time=LocoSynth(d).cycstim(j,1);
        stmtb=floor((LocoSynth(d).cycstim(j,1)-timewin)/RTA.interval);
        cnt=0;
        for t=-nbbin:(nbbin-1)
            cnt=t+nbbin+1;
            curpos=floor((LocoSynth(d).cycstim(j,1)+(t*precision))/RTA.interval);
            temp(cnt,1)=mean(RTA.values(curpos:curpos+resolution));
        end   
        temp=abs(temp);    
        temp=smooth(temp,10); 
        temp=(temp-mean(temp))/std(temp);
        STIM_DATA_Z(j).zRTA=temp;
        RTA_ALL(j,2:(2*nbbin+1))=temp;
        STIM_DATA_Z(j).zRTAPre=sum(temp((nbbin-twin):nbbin));
        STIM_DATA_Z(j).zRTAPost=sum(temp(nbbin:(nbbin+twin)));
        STIM_DATA_Z(j).zRTAresp=STIM_DATA_Z(j).zRTAPost-STIM_DATA_Z(j).zRTAPre;
        RTA_ALL(j,1)=STIM_DATA_Z(j).zRTAresp;
        scatter(STIM_DATA_Z(j).zRTAPre, STIM_DATA_Z(j).zRTAresp, 'ok')
    end    
    RTA_ALL_SORTED=sortrows(RTA_ALL);
    subplot(4,2,2)
    imagesc('XData', time, 'CData', RTA_ALL_SORTED(:,2:(2*nbbin+1)))
    xlabel('time')
    ylabel('stim#')
    
    %triggering stim for RGL
    subplot(4,2,3)
    xlabel('Pre-stim Z')
    ylabel('Z Response')
    title('RGL z-score')
    hold all
    for j=1:length(LocoSynth(d).cycstim)
        STIM_DATA_Z(j).time=LocoSynth(d).cycstim(j,1);
        stmtb=floor((LocoSynth(d).cycstim(j,1)-timewin)/RGL.interval);
        cnt=0;
        for t=-nbbin:(nbbin-1)
            cnt=t+nbbin+1;
            curpos=floor((LocoSynth(d).cycstim(j,1)+(t*precision))/RGL.interval);
            temp(cnt,1)=mean(RGL.values(curpos:curpos+resolution));
        end   
        temp=abs(temp);    
        temp=smooth(temp,10); 
        temp=(temp-mean(temp))/std(temp);
        STIM_DATA_Z(j).zRGL=temp;
        RGL_ALL(j,2:(2*nbbin+1))=temp;
        STIM_DATA_Z(j).zRGLPre=sum(temp((nbbin-twin):nbbin));
        STIM_DATA_Z(j).zRGLPost=sum(temp(nbbin:(nbbin+twin)));
        STIM_DATA_Z(j).zRGLresp=STIM_DATA_Z(j).zRGLPost-STIM_DATA_Z(j).zRGLPre;
        RGL_ALL(j,1)=STIM_DATA_Z(j).zRGLresp;
        scatter(STIM_DATA_Z(j).zRGLPre, STIM_DATA_Z(j).zRGLresp, 'ok')
    end    
    RGL_ALL_SORTED=sortrows(RGL_ALL);
    subplot(4,2,4)
    imagesc('XData', time, 'CData', RGL_ALL_SORTED(:,2:(2*nbbin+1)))
    
    
    %triggering stim for LTA
    subplot(4,2,5)
    xlabel('Pre-stim Z')
    ylabel('Z Response')
    title('LTA z-score')
    hold all
    for j=1:length(LocoSynth(d).cycstim)
        STIM_DATA_Z(j).time=LocoSynth(d).cycstim(j,1);
        stmtb=floor((LocoSynth(d).cycstim(j,1)-timewin)/LTA.interval);
        cnt=0;
        for t=-nbbin:(nbbin-1)
            cnt=t+nbbin+1;
            curpos=floor((LocoSynth(d).cycstim(j,1)+(t*precision))/LTA.interval);
            temp(cnt,1)=mean(LTA.values(curpos:curpos+resolution));
        end   
        temp=abs(temp);    
        temp=smooth(temp,10); 
        temp=(temp-mean(temp))/std(temp);
        STIM_DATA_Z(j).zLTA=temp;
        LTA_ALL(j,2:(2*nbbin+1))=temp;
        STIM_DATA_Z(j).zLTAPre=sum(temp((nbbin-twin):nbbin));
        STIM_DATA_Z(j).zLTAPost=sum(temp(nbbin:(nbbin+twin)));
        STIM_DATA_Z(j).zLTAresp=STIM_DATA_Z(j).zLTAPost-STIM_DATA_Z(j).zLTAPre;
        LTA_ALL(j,1)=STIM_DATA_Z(j).zLTAresp;
        scatter(STIM_DATA_Z(j).zLTAPre, STIM_DATA_Z(j).zLTAresp, 'ok')
    end    
    LTA_ALL_SORTED=sortrows(LTA_ALL);
    subplot(4,2,6)
    imagesc('XData', time, 'CData', LTA_ALL_SORTED(:,2:(2*nbbin+1)))
    
    %triggering stim for LGL
    subplot(4,2,7)
    xlabel('Pre-stim Z')
    ylabel('Z Response')
    title('LGL z-score')
    hold all
    for j=1:length(LocoSynth(d).cycstim)
        STIM_DATA_Z(j).time=LocoSynth(d).cycstim(j,1);
        stmtb=floor((LocoSynth(d).cycstim(j,1)-timewin)/LGL.interval);
        cnt=0;
        for t=-nbbin:(nbbin-1)
            cnt=t+nbbin+1;
            curpos=floor((LocoSynth(d).cycstim(j,1)+(t*precision))/LGL.interval);
            temp(cnt,1)=mean(LGL.values(curpos:curpos+resolution));
        end   
        temp=abs(temp);    
        temp=smooth(temp,10); 
        temp=(temp-mean(temp))/std(temp);
        STIM_DATA_Z(j).zLGL=temp;
        LGL_ALL(j,2:(2*nbbin+1))=temp;
        STIM_DATA_Z(j).zLGLPre=sum(temp((nbbin-twin):nbbin));
        STIM_DATA_Z(j).zLGLPost=sum(temp(nbbin:(nbbin+twin)));
        STIM_DATA_Z(j).zLGLresp=STIM_DATA_Z(j).zLGLPost-STIM_DATA_Z(j).zLGLPre;
        LGL_ALL(j,1)=STIM_DATA_Z(j).zLGLresp;
        scatter(STIM_DATA_Z(j).zLGLPre, STIM_DATA_Z(j).zLGLresp, 'ok')
    end    
    LGL_ALL_SORTED=sortrows(LGL_ALL);
    subplot(4,2,8)
    imagesc('XData', time, 'CData', LGL_ALL_SORTED(:,2:(2*nbbin+1)))
end    


outname2=strcat(inputname, '_', timepoint, '_trigZ.mat');
save(outname2, 'STIM_DATA_Z', 'RTA_ALL', 'RTA_ALL_SORTED', ...
        'RGL_ALL', 'RGL_ALL_SORTED', 'LTA_ALL', 'LTA_ALL_SORTED', ...
        'LGL_ALL', 'LGL_ALL_SORTED')
inputname='Gi17547';
timepoint='wk7';
%detect stops(no=0, yes=1)
stopdetect=1;
inputname2=strcat(inputname, '_stimtb.mat');
load(inputname2)
%time resolution for z-score analysis (+/- in sec)
timeres=1

%extract value for control period
d=0;
for c=1:length(LocoSynth);
   if  LocoSynth(c).time==timepoint;
        d=c
   end    
end   

if d==0
    disp('data is missing; end script')
    return
else    
    temp=[];
    STIM_DATA=[];
    tempname=strcat(LocoSynth(d).nucleus, LocoSynth(d).ID, '_', LocoSynth(d).time, '_loco_int', LocoSynth(d).intensity, '_dur', LocoSynth(d).duration, '.mat');
    load(tempname);
    twin=round(2*timeres/(RTA.interval))-1;
    nbbin=2*(1/RTA.interval);
    
    %make timebase for graph
    val=-timeres;
    time=[];
    for t=1:nbbin
    time(t,1)=val;
    val=val+RTA.interval;
    end    
    
    %triggering stim for RTA
    for j=1:length(LocoSynth(d).cycstim)
        STIM_DATA(j).time=LocoSynth(d).cycstim(j,1);
        stmtb=floor((LocoSynth(d).cycstim(j,1)-timeres)/RTA.interval);
        temp=RTA.values(stmtb:stmtb+twin);
        temp=abs(temp);         
        temp=smooth(temp, 100);
        temp=(temp-mean(temp))/std(temp);
        STIM_DATA(j).zRTA=temp;
        RTA_ALL(j,:)=temp;
    end    
    %triggering stim for RGL
    for j=1:length(LocoSynth(d).cycstim)
        STIM_DATA(j).time=LocoSynth(d).cycstim(j,1);
        stmtb=floor((LocoSynth(d).cycstim(j,1)-timeres)/RGL.interval);
        temp=RGL.values(stmtb:stmtb+twin);
        temp=abs(temp);         
        temp=smooth(temp, 100);
        temp=(temp-mean(temp))/std(temp);
        STIM_DATA(j).zRGL=temp;
        RGL_ALL(j,:)=temp;
    end
    %triggering stim for LTA
    for j=1:length(LocoSynth(d).cycstim)
        STIM_DATA(j).time=LocoSynth(d).cycstim(j,1);
        stmtb=floor((LocoSynth(d).cycstim(j,1)-timeres)/LTA.interval);
        temp=LTA.values(stmtb:stmtb+twin);
        temp=abs(temp);         
        temp=smooth(temp, 100);
        temp=(temp-mean(temp))/std(temp);
        STIM_DATA(j).zLTA=temp;
        LTA_ALL(j,:)=temp;
    end   
    %triggering stim for LGL
    for j=1:length(LocoSynth(d).cycstim)
        STIM_DATA(j).time=LocoSynth(d).cycstim(j,1);
        stmtb=floor((LocoSynth(d).cycstim(j,1)-timeres)/LGL.interval);
        temp=LGL.values(stmtb:stmtb+twin);
        temp=abs(temp);         
        temp=smooth(temp, 100);
        temp=(temp-mean(temp))/std(temp);
        STIM_DATA(j).zLGL=temp;
        RGL_ALL(j,:)=temp;
    end   
end    

LocoAnalysis2a(inputname, timepoint, timeres)
LocoAnalysis2b(inputname, timepoint, timeres)
LocoAnalysis2c(inputname, timepoint, stopdetect)
clear all
dblist=dir('*_data_*.mat')
minrelaxdur=0.03; %minimal duration of the relaxed/silent phase
twin=1; %timewindow in second
BurstTiming_CTL=[];
BurstTiming_WK7=[];


%temporary
for k=1:length(dblist)
load(dblist(k).name)


%%EXTRACTING DATA
%stim timebase
sttemp=[];
c_st=1;
for s=1:50:length(stim.times(:,1))
    sttemp(c_st,1)=stim.times(s,1);
    c_st=c_st+1;
end    


%initialize counters and limits
on_max=length(onburst.times);
off_max=length(offburst.times);
c_brst=1;
c_off=1;

temp=[];
temppk=peak.times(:,1);
tempon=onburst.times(:,1);
tempon(:,2)=1;
tempoff=offburst.times(:,1);
tempoff(:,2)=2;
temp=cat(1,tempon, tempoff);
temp=sortrows(temp);

cnt=1;
cond1=0;
act=[]; %actual event
for i=1:length(temp(:,1))
    if cond1==0 %first condition, we must start with a burst onset (val=1)
        if temp(i,2)==1
            cond1=1;
            act=1;
        elseif temp(i,2)==2
            temp(i,:)=NaN;
        end
    else
        %get rid of consecutive on or off events (false start/stop)
        if temp(i,2)==act
            temp(i,:)=NaN;
        else
            act=temp(i,2);
        end
    end
end    

%remove all false start/stop
for i=length(temp(:,1)):-1:1
    if isnan(temp(i,1))==1
        temp(i,:)=[];
    end
end

%remove too short relaxed phase
for i=length(temp(:,1))-1:-2:3
    if temp(i,1)-temp(i-1,1)<minrelaxdur
        temp(i,:)=[];
        temp(i-1,:)=[];
    end
end


kcnt=floor((k+1)/2);

if dblist(k).name(12:14)=='ctl'     
    BurstTiming_CTL(kcnt).ID=dblist(k).name(1:5);
    BurstTiming_CTL(kcnt).STIM=sttemp;
    BurstTiming_CTL(kcnt).PEAK=temppk;
     for j=1:length(temp(:,1))
        cnt=floor((j+1)/2);
        switch temp(j,2)
            case 1
            BurstTiming_CTL(kcnt).ON(cnt,1)=temp(j,1);
            case 2
            BurstTiming_CTL(kcnt).OFF(cnt,1)=temp(j,1);   
        end       
    end
elseif dblist(k).name(12:14)=='wk7'   
    BurstTiming_WK7(kcnt).ID=dblist(k).name(1:5);
    BurstTiming_WK7(kcnt).STIM=sttemp;
    BurstTiming_WK7(kcnt).PEAK=temppk;
    for j=1:length(temp(:,1))
        cnt=floor((j+1)/2);
        switch temp(j,2)
            case 1
            BurstTiming_WK7(kcnt).ON(cnt,1)=temp(j,1);
            case 2
            BurstTiming_WK7(kcnt).OFF(cnt,1)=temp(j,1); 
        end       
    end
end
end

outname='burstdata.mat';
save(outname, 'BurstTiming_CTL', 'BurstTiming_WK7', 'dblist')

%% triggering data
twin=1; %+/- time window around stim
time0=0; %to exclude burst evoked by photostim

DATA_CTL=[];
for k=1:length(BurstTiming_CTL)
    cur=k*2-1;
    load(dblist(cur).name)
    precision=flexor.interval;
    DATA_CTL(k).PREBURST=[];
    DATA_CTL(k).STIMBURST=[];
    for i=1:length(BurstTiming_CTL(k).STIM(:,1))
        tmp_pre=[];
        tmp_stim=[];
        cnt0=1;
        cnt1=1;
        for j=1:length(BurstTiming_CTL(k).PEAK(:,1))-1
            %time to stim
            val=BurstTiming_CTL(k).PEAK(j,1)-BurstTiming_CTL(k).STIM(i,1);
            if val >= -twin & val < time0
                if j>1 %rare instance when the first burst is triggered within the time window of the first stim   
                tmp_pre(cnt0,1)=val;
                tmp_pre(cnt0,2)=(BurstTiming_CTL(k).PEAK(j+1,1)-BurstTiming_CTL(k).PEAK(j,1));
                tme=round(BurstTiming_CTL(k).PEAK(j,1)/precision);
                tmp_pre(cnt0,3)=flexor.values(tme, 1);
                tmp_pre(cnt0,4)=i;
                cnt0=cnt0+1;
                end
            elseif val >= time0 & val < twin
                if j>1 %rare instance when the first burst is triggered within the time window of the first stim
                tmp_stim(cnt1,1)=val;    
                tmp_stim(cnt1,2)=(BurstTiming_CTL(k).PEAK(j+1,1)-BurstTiming_CTL(k).PEAK(j,1));    
                tme=round(BurstTiming_CTL(k).PEAK(j,1)/precision);
                tmp_stim(cnt1,3)=flexor.values(tme, 1);
                tmp_stim(cnt1,4)=i;
                cnt1=cnt1+1;
                end
            end    
        end  
        %store temporary data for stats and figure
        %step cycle pre-stim
        if isempty(tmp_pre)==0
            DATA_CTL(k).PREBURST=cat(1,DATA_CTL(k).PREBURST, tmp_pre);
        end
        %step cycle post-stim
        if isempty(tmp_stim)==0
            DATA_CTL(k).STIMBURST=cat(1,DATA_CTL(k).STIMBURST, tmp_stim);
        end
    end    
end    
    

DATA_WK7=[];
for k=1:length(BurstTiming_WK7)
    cur=k*2;
    load(dblist(cur).name)
    precision=flexor.interval;
    DATA_WK7(k).PREBURST=[];
    DATA_WK7(k).STIMBURST=[];
    for i=1:length(BurstTiming_WK7(k).STIM(:,1))
        tmp_pre=[];
        tmp_stim=[];
        cnt0=1;
        cnt1=1;
        for j=1:length(BurstTiming_WK7(k).PEAK(:,1))-1
            %time to stim
            val=BurstTiming_WK7(k).PEAK(j,1)-BurstTiming_WK7(k).STIM(i,1);
            if val >= -twin & val < time0
                if j>1 %rare instance when the first burst is triggered within the time window of the first stim   
                tmp_pre(cnt0,1)=val;
                tmp_pre(cnt0,2)=(BurstTiming_WK7(k).PEAK(j+1,1)-BurstTiming_WK7(k).PEAK(j,1));
                tme=round(BurstTiming_WK7(k).PEAK(j,1)/precision);
                tmp_pre(cnt0,3)=max(flexor.values(tme, 1));
                tmp_pre(cnt0,4)=i;
                cnt0=cnt0+1;
                end
            elseif val >= time0 & val < twin
                if j>1 %rare instance when the first burst is triggered within the time window of the first stim
                tmp_stim(cnt1,1)=val;    
                tmp_stim(cnt1,2)=(BurstTiming_WK7(k).PEAK(j+1,1)-BurstTiming_WK7(k).PEAK(j,1));    
                tme=round(BurstTiming_WK7(k).PEAK(j,1)/precision);
                tmp_stim(cnt1,3)=max(flexor.values(tme, 1));
                tmp_stim(cnt1,4)=i;
                cnt1=cnt1+1;
                end
            end    
        end  
        %store temporary data for stats and figure
        %step cycle pre-stim
        if isempty(tmp_pre)==0
            DATA_WK7(k).PREBURST=cat(1,DATA_WK7(k).PREBURST, tmp_pre);
        end
        %step cycle post-stim
        if isempty(tmp_stim)==0
            DATA_WK7(k).STIMBURST=cat(1,DATA_WK7(k).STIMBURST, tmp_stim);
        end
    end    
end    

  

outname='train_data.mat';
save(outname, 'DATA_CTL', 'DATA_WK7', 'dblist')
clear all


%% stats
load('train_data.mat')
PROCESS_CTL=[];
PROCESS_WK7=[];
STATS_CTL=[];
STATS_WK7=[];

for i=1:length(DATA_CTL)
PROCESS_CTL(i).ID=dblist(2*i).name(1:5);
last0=length(DATA_CTL(i).PREBURST(:,4));
last1=length(DATA_CTL(i).STIMBURST(:,4));
nbtrial0=DATA_CTL(i).PREBURST(last0,4);
nbtrial1=DATA_CTL(i).STIMBURST(last1,4);
nbtrial=max(nbtrial0,nbtrial1);
temp0=zeros(nbtrial, 1);
temp1=zeros(nbtrial, 1);
tmp0_dur=zeros(nbtrial, 1);
tmp1_dur=zeros(nbtrial, 1);
tmp0_amp=zeros(nbtrial, 1);
tmp1_amp=zeros(nbtrial, 1);
%temp0 stores the number of steps before stimulation
trial=1;
    for j=1:last0
        if DATA_CTL(i).PREBURST(j,4)==trial
           temp0(trial,1)=temp0(trial,1)+1;
        else
            trial=trial+1;
            temp0(trial,1)=temp0(trial,1)+1;            
        end    
        tmp0_dur(trial,1)=tmp0_dur(trial,1)+DATA_CTL(i).PREBURST(j,2);
        tmp0_amp(trial,1)=tmp0_amp(trial,1)+DATA_CTL(i).PREBURST(j,3);
    end    

PROCESS_CTL(i).NBSTEP(:,1)=temp0;
PROCESS_CTL(i).BURSTINT(:,1)=tmp0_dur./temp0;
PROCESS_CTL(i).BURSTAMP(:,1)=tmp0_amp./temp0;
%temp1 stores the number of steps after stimulation
trial=1;
    for j=1:last1
        if DATA_CTL(i).STIMBURST(j,4)==trial
           temp1(trial,1)=temp1(trial,1)+1;          
        else
            trial=trial+1;
            temp1(trial,1)=temp1(trial,1)+1;
        end        
        tmp1_dur(trial,1)=tmp1_dur(trial,1)+DATA_CTL(i).STIMBURST(j,2);
        tmp1_amp(trial,1)=tmp1_amp(trial,1)+DATA_CTL(i).STIMBURST(j,3);
    end        
PROCESS_CTL(i).NBSTEP(:,2)=temp1;
PROCESS_CTL(i).BURSTINT(:,2)=tmp1_dur./temp1;
PROCESS_CTL(i).BURSTAMP(:,2)=tmp1_amp./temp1;
PROCESS_CTL(i).NBSTEP_PRE=mean(temp0);
PROCESS_CTL(i).NBSTEP_POST=mean(temp1);
p=signrank(PROCESS_CTL(i).NBSTEP(:,1),PROCESS_CTL(i).NBSTEP(:,2));
PROCESS_CTL(i).NBSTEP_PVAL=p;
PROCESS_CTL(i).BURSTINT_PRE=mean(PROCESS_CTL(i).BURSTINT(:,1), 'omitnan');
PROCESS_CTL(i).BURSTINT_POST=mean(PROCESS_CTL(i).BURSTINT(:,2), 'omitnan');
p=signrank(PROCESS_CTL(i).BURSTINT(:,1),PROCESS_CTL(i).BURSTINT(:,2));
PROCESS_CTL(i).BURSTINT_PVAL=p;
PROCESS_CTL(i).BURSTAMP_PRE=mean(PROCESS_CTL(i).BURSTAMP(:,1), 'omitnan');
PROCESS_CTL(i).BURSTAMP_POST=mean(PROCESS_CTL(i).BURSTAMP(:,2), 'omitnan');
PROCESS_CTL(i).ratio=PROCESS_CTL(i).BURSTAMP_POST/PROCESS_CTL(i).BURSTAMP_PRE;
p=signrank(PROCESS_CTL(i).BURSTAMP(:,1),PROCESS_CTL(i).BURSTAMP(:,2));
PROCESS_CTL(i).BURSTAMP_PVAL=p;
%PROCESS_CTL(i).IBD_PRE=mean(DATA_CTL(i).PREBURST(:,2));
%PROCESS_CTL(i).IBD_POST=mean(DATA_CTL(i).STIMBURST(:,2));
%p=ranksum(DATA_CTL(i).PREBURST(:,2),DATA_CTL(i).STIMBURST(:,2));
%PROCESS_CTL(i).IBD_PVAL=p;
%PROCESS_CTL(i).IBD_KSPRE=kstest(DATA_CTL(i).PREBURST(:,2));
%PROCESS_CTL(i).IBD_KSPOST=kstest(DATA_CTL(i).STIMBURST(:,2));
end    

for i=1:length(DATA_WK7)
PROCESS_WK7(i).ID=dblist(2*i).name(1:5);
last0=length(DATA_WK7(i).PREBURST(:,4));
last1=length(DATA_WK7(i).STIMBURST(:,4));
nbtrial0=DATA_WK7(i).PREBURST(last0,4);
nbtrial1=DATA_WK7(i).STIMBURST(last1,4);
nbtrial=max(nbtrial0,nbtrial1);
temp0=zeros(nbtrial, 1);
temp1=zeros(nbtrial, 1);
tmp0_dur=zeros(nbtrial, 1);
tmp1_dur=zeros(nbtrial, 1);
tmp0_amp=zeros(nbtrial, 1);
tmp1_amp=zeros(nbtrial, 1);
%temp0 stores the number of steps before stimulation
trial=1;
    for j=1:last0
        if DATA_WK7(i).PREBURST(j,4)==trial
           temp0(trial,1)=temp0(trial,1)+1;
        else
            trial=trial+1;
            temp0(trial,1)=temp0(trial,1)+1;            
        end    
        tmp0_dur(trial,1)=tmp0_dur(trial,1)+DATA_WK7(i).PREBURST(j,2);
        tmp0_amp(trial,1)=tmp0_amp(trial,1)+DATA_WK7(i).PREBURST(j,3);
    end    

PROCESS_WK7(i).NBSTEP(:,1)=temp0;
PROCESS_WK7(i).BURSTINT(:,1)=tmp0_dur./temp0;
PROCESS_WK7(i).BURSTAMP(:,1)=tmp0_amp./temp0;
%temp1 stores the number of steps after stimulation
trial=1;
    for j=1:last1
        if DATA_WK7(i).STIMBURST(j,4)==trial
           temp1(trial,1)=temp1(trial,1)+1;          
        else
            trial=trial+1;
            temp1(trial,1)=temp1(trial,1)+1;
        end        
        tmp1_dur(trial,1)=tmp1_dur(trial,1)+DATA_WK7(i).STIMBURST(j,2);
        tmp1_amp(trial,1)=tmp1_amp(trial,1)+DATA_WK7(i).STIMBURST(j,3);
    end        
PROCESS_WK7(i).NBSTEP(:,2)=temp1;
PROCESS_WK7(i).BURSTINT(:,2)=tmp1_dur./temp1;
PROCESS_WK7(i).BURSTAMP(:,2)=tmp1_amp./temp1;
PROCESS_WK7(i).NBSTEP_PRE=mean(temp0);
PROCESS_WK7(i).NBSTEP_POST=mean(temp1);
p=signrank(PROCESS_WK7(i).NBSTEP(:,1),PROCESS_WK7(i).NBSTEP(:,2));
PROCESS_WK7(i).NBSTEP_PVAL=p;
PROCESS_WK7(i).BURSTINT_PRE=mean(PROCESS_WK7(i).BURSTINT(:,1), 'omitnan');
PROCESS_WK7(i).BURSTINT_POST=mean(PROCESS_WK7(i).BURSTINT(:,2), 'omitnan');
p=signrank(PROCESS_WK7(i).BURSTINT(:,1),PROCESS_WK7(i).BURSTINT(:,2));
PROCESS_WK7(i).BURSTINT_PVAL=p;
PROCESS_WK7(i).BURSTAMP_PRE=mean(PROCESS_WK7(i).BURSTAMP(:,1), 'omitnan');
PROCESS_WK7(i).BURSTAMP_POST=mean(PROCESS_WK7(i).BURSTAMP(:,2), 'omitnan');
PROCESS_WK7(i).ratio=PROCESS_WK7(i).BURSTAMP_POST/PROCESS_WK7(i).BURSTAMP_PRE;
p=signrank(PROCESS_WK7(i).BURSTAMP(:,1),PROCESS_WK7(i).BURSTAMP(:,2));
PROCESS_WK7(i).BURSTAMP_PVAL=p;
%PROCESS_WK7(i).IBD_PRE=mean(DATA_WK7(i).PREBURST(:,2));
%PROCESS_WK7(i).IBD_POST=mean(DATA_WK7(i).STIMBURST(:,2));
%p=ranksum(DATA_WK7(i).PREBURST(:,2),DATA_WK7(i).STIMBURST(:,2));
%PROCESS_WK7(i).IBD_PVAL=p;
%PROCESS_WK7(i).IBD_KSPRE=kstest(DATA_WK7(i).PREBURST(:,2));
%PROCESS_WK7(i).IBD_KSPOST=kstest(DATA_WK7(i).STIMBURST(:,2));

%final data
STATS_CTL(i).ID=PROCESS_CTL(i).ID;
STATS_CTL(i).pre=PROCESS_CTL(i).BURSTAMP_PRE;
STATS_CTL(i).post=PROCESS_CTL(i).BURSTAMP_POST;
STATS_CTL(i).ratio=PROCESS_CTL(i).ratio;
STATS_CTL(i).pval=PROCESS_CTL(i).BURSTAMP_PVAL;
STATS_WK7(i).ID=PROCESS_WK7(i).ID;
STATS_WK7(i).pre=PROCESS_WK7(i).BURSTAMP_PRE;
STATS_WK7(i).post=PROCESS_WK7(i).BURSTAMP_POST;
STATS_WK7(i).ratio=PROCESS_WK7(i).ratio;
STATS_WK7(i).pval=PROCESS_WK7(i).BURSTAMP_PVAL;
end    


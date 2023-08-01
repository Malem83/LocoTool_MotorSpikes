dblist=dir('*_data_*.mat')
minrelaxdur=0.03; %minimal duration of the relaxed/silent phase_MU
twin=0.5; %timewindow in second
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

kcnt=floor((k+1)/2);

if dblist(k).name(12:14)=='ctl'     
    BurstTiming_CTL(kcnt).ID=dblist(k).name(1:5);
    BurstTiming_CTL(kcnt).STIM=sttemp;
elseif dblist(k).name(12:14)=='wk7'   
    BurstTiming_WK7(kcnt).ID=dblist(k).name(1:5);
    BurstTiming_WK7(kcnt).STIM=sttemp;
end
end



DATA_CTL=[];
for k=1:length(BurstTiming_CTL)
    cur=k*2-1;
    load(dblist(cur).name)
    precision=extensor.interval;
    twin2=round(twin/extensor.interval);
    DATA_CTL(k).INTAMP=[];
    tmp=[];
    cnt=1;
    for i=1:length(BurstTiming_CTL(k).STIM(:,1))
        tme=round(BurstTiming_CTL(k).STIM(i,1)/precision);
        tmp(cnt,1)=sum(extensor.values(tme-twin2:tme, 1));
        tmp(cnt,2)=sum(extensor.values(tme:tme+twin2, 1));        
        cnt=cnt+1;
    end    
    DATA_CTL(k).INTAMP=tmp;
end    
    
DATA_WK7=[];
for k=1:length(BurstTiming_WK7)
    cur=k*2;
    load(dblist(cur).name)
    precision=extensor.interval;
    twin2=round(twin/extensor.interval);
    DATA_WK7(k).INTAMP=[];
    tmp=[];
    cnt=1;
    for i=1:length(BurstTiming_WK7(k).STIM(:,1))
        tme=round(BurstTiming_WK7(k).STIM(i,1)/precision);
        tmp(cnt,1)=sum(extensor.values(tme-twin2:tme, 1));
        tmp(cnt,2)=sum(extensor.values(tme:tme+twin2, 1));
        cnt=cnt+1;
    end    
     DATA_WK7(k).INTAMP=tmp;
end    



outname='burstdata.mat';
save(outname, 'BurstTiming_CTL', 'BurstTiming_WK7', 'DATA_CTL', 'DATA_WK7', 'dblist')

clear all
%% stats
load('burstdata.mat')

STATS_CTL=[];
STATS_WK7=[];

for i=1:length(DATA_CTL)
    STATS_CTL(i).ID=dblist(2*i).name(1:5);
    [h1,p1]=kstest(DATA_CTL(i).INTAMP(:,1));
    [h2,p2]=kstest(DATA_CTL(i).INTAMP(:,2));
    STATS_CTL(i).pre=mean(DATA_CTL(i).INTAMP(:,1));
    STATS_CTL(i).stim=mean(DATA_CTL(i).INTAMP(:,2));
    STATS_CTL(i).ratio=mean(DATA_CTL(i).INTAMP(:,2))/mean(DATA_CTL(i).INTAMP(:,1));
    if p1==0 && p2==0
        STATS_CTL(i).test='ttest';
        [h,p]=ttest(DATA_CTL(i).INTAMP(:,1),DATA_CTL(i).INTAMP(:,2));
        STATS_CTL(i).pval=p;
    else    
        STATS_CTL(i).test='Wilc';
        p=signrank(DATA_CTL(i).INTAMP(:,1),DATA_CTL(i).INTAMP(:,2));
        STATS_CTL(i).pval=p;
    end

end

for i=1:length(DATA_WK7)
    STATS_WK7(i).ID=dblist(2*i).name(1:5);
    [h1,p1]=kstest(DATA_WK7(i).INTAMP(:,1));
    [h2,p2]=kstest(DATA_WK7(i).INTAMP(:,2));
    STATS_WK7(i).pre=mean(DATA_WK7(i).INTAMP(:,1));
    STATS_WK7(i).stim=mean(DATA_WK7(i).INTAMP(:,2));
    STATS_WK7(i).ratio=mean(DATA_WK7(i).INTAMP(:,2))/mean(DATA_WK7(i).INTAMP(:,1));
    if p1==0 && p2==0
        STATS_WK7(i).test='ttest';
        [h,p]=ttest(DATA_WK7(i).INTAMP(:,1),DATA_WK7(i).INTAMP(:,2));
        STATS_WK7(i).pval=p;
    else    
        STATS_WK7(i).test='Wilc';
        p=signrank(DATA_WK7(i).INTAMP(:,1),DATA_WK7(i).INTAMP(:,2));
        STATS_WK7(i).pval=p;
    end
    
end





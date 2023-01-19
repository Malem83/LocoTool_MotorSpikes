function LocoAnalysis2c(inputname, timepoint, STOPDETECT)
%Last modification November 29, 2021

%inputname='Gi10852';
inputname2=strcat(inputname, '_', timepoint, '_trigZ.mat');
inputname3=strcat(inputname, '_', timepoint, '_trigMU.mat');
load(inputname2)
load(inputname3)

%threshold in terms of motor unit density to skip phase detection of a stim
%threshold is for pre-stimulation baseline
%if below threshold, script will not try to find bursts after stim (wrong z-value)
THR_LTA=20;
THR_RTA=20;
NBBIN=length(STIM_DATA_MU(1).mudLTA);
CENTR=NBBIN/2;


if timepoint=='wk1'
%threshold to burst onset (z-value)
ON_RTA=0.5;
ON_RGL=0.5;
ON_LTA=0.5;
ON_LGL=0.5;
%threshold to burst offset (z-value)
OFF_RTA=0;
OFF_RGL=0;
OFF_LTA=0;
OFF_LGL=0;
%duration threshold (in nb bins)
DURON_RTA=3;
DUROFF_RTA=5;
DURON_RGL=3;
DUROFF_RGL=5;
DURON_LTA=3;
DUROFF_LTA=5;
DURON_LGL=3;
DUROFF_LGL=5;    
else    
%threshold to burst onset (z-value)
ON_RTA=0.25;
ON_RGL=0.25;
ON_LTA=0.25;
ON_LGL=0.25;
%threshold to burst offset (z-value)
OFF_RTA=0;
OFF_RGL=0;
OFF_LTA=0;
OFF_LGL=0;
%duration threshold (in nb bins)
DURON_RTA=3;
DUROFF_RTA=5;
DURON_RGL=3;
DUROFF_RGL=5;
DURON_LTA=3;
DUROFF_LTA=5;
DURON_LGL=3;
DUROFF_LGL=5;
end

%adjust bin size threshold to code structure
DURON_RTA=DURON_RTA-1;
DUROFF_RTA=DUROFF_RTA-1;
DURON_RGL=DURON_RGL-1;
DUROFF_RGL=DUROFF_RGL-1;
DURON_LTA=DURON_LTA-1;
DUROFF_LTA=DUROFF_LTA-1;
DURON_LGL=DURON_LGL-1;
DUROFF_LGL=DUROFF_LGL-1;


%LTA
BURST_LTA=[];
for h=1:length(STIM_DATA_Z)
LTA_Z=STIM_DATA_Z(h).zLTA(:,1);
BURST_LTA=[];
CNT=1;
BRSTN=1; 
ONTIM=0;
OFFTIM=0;


if STOPDETECT==1 
LTA_BSL=sum(STIM_DATA_MU(h).mudLTA(1:CENTR,1));
    if LTA_BSL>=THR_LTA   
        DRAGCOND=0;
    else
        DRAGCOND=1;
    end
else
    DRAGCOND=0;
end

if DRAGCOND==0
%beginning of the triggered histogram
if LTA_Z(CNT,1)<=ON_LTA
    %relaxed state
    COND=0;
    CNT=CNT+1;
else
    %already bursting, looking for the first end of burst
    COND=1;
    CNT=CNT+1;
    BURST_LTA(BRSTN,1)=NaN;
    BIN_ON=0;
    %looking for the end of the burst
    INIT=1;
    while INIT==1
    if LTA_Z(CNT,1)>OFF_LTA
        %still activated
        CNT=CNT+1;
        BIN_ON=0;
    elseif LTA_Z(CNT,1)<=OFF_LTA && BIN_ON==0
        %cross below the threshold
        OFFTIM=CNT;
        CNT=CNT+1;
        BIN_ON=1;
    elseif LTA_Z(CNT,1)<=OFF_LTA && BIN_ON>0 && BIN_ON<DUROFF_LTA 
        %has already cross below threshold and stays below it
        BIN_ON=BIN_ON+1;
        CNT=CNT+1;
    elseif LTA_Z(CNT,1)<=OFF_LTA && BIN_ON==DUROFF_LTA 
        INIT=0;
        BURST_LTA(BRSTN,2)=OFFTIM;
        CNT=CNT+1;
        BIN_ON=0;
        BRSTN=2;
        COND=0;
    end
    end
end

BIN_ON=0;

for i=CNT:length(LTA_Z)
    %at initialization of this loop, we are in a relaxed state
    if COND==0
        %relaxed state, we are looking for onset of burst
        if LTA_Z(i,1)<=ON_LTA
            %still relaxed
            BIN_ON=0;
        elseif LTA_Z(i,1)>ON_LTA && BIN_ON==0
            %crosses above threshold
            ONTIM=i;
            BIN_ON=1;
        elseif LTA_Z(i,1)>ON_LTA && BIN_ON>0 && BIN_ON<DURON_LTA 
            %stays above threshold
            BIN_ON=BIN_ON+1;
        elseif LTA_Z(i,1)>ON_LTA && BIN_ON==DURON_LTA 
            COND=1;
            BURST_LTA(BRSTN,1)=ONTIM;
            BIN_ON=0;
        end
    elseif COND==1
        %activated state 
        if LTA_Z(i,1)>OFF_LTA
            %still activated
            BIN_ON=0;
        elseif LTA_Z(i,1)<=OFF_LTA && BIN_ON==0
            %cross below the threshold
            OFFTIM=i;
            BIN_ON=1;
        elseif LTA_Z(i,1)<=OFF_LTA && BIN_ON>0 && BIN_ON<DUROFF_LTA 
            %has already cross below threshold
            BIN_ON=BIN_ON+1;
        elseif LTA_Z(i,1)<=OFF_LTA && BIN_ON==DUROFF_LTA
            COND=0;
            BURST_LTA(BRSTN,2)=OFFTIM;
            BIN_ON=0;
            BRSTN=BRSTN+1;
        end
    end   
end

%ending with a burst?
if COND==1
    BURST_LTA(BRSTN,2)=NaN;
end   

if BRSTN>1
    STIM_DATA_Z(h).LTAon=BURST_LTA(:,1);
    STIM_DATA_Z(h).LTAoff=BURST_LTA(:,2);
else
    STIM_DATA_Z(h).LTAon=NaN;
    STIM_DATA_Z(h).LTAoff=NaN;
end  

else
    STIM_DATA_Z(h).LTAon=NaN;
    STIM_DATA_Z(h).LTAoff=NaN;
end
end

STIMLEN=length(STIM_DATA_Z(1).zRTA(:,1));
STIMCENTER=STIMLEN/2;

TEMP=[];
LTA_STIM=[];

%determine the phase
for i=1:length(STIM_DATA_Z)
    TEMP=STIM_DATA_Z(i).LTAon-STIMCENTER;
    if length(TEMP)==1 
        if isnan(TEMP(1))==1  
            LTA_STIM(i,1)=2;  
        elseif TEMP(1)>0
            LTA_STIM(i,1)=2;
        else    
            LTA_STIM(i,1)=3; 
        end 
    elseif length(TEMP)==2  
        if TEMP(1)<0 & TEMP(2)<=0
            LTA_STIM(i,1)=3;  
        elseif TEMP(1)>=0 & TEMP(2)>0
            LTA_STIM(i,1)=2;     
        elseif TEMP(1)>=0 & TEMP(2)>0
            LTA_STIM(i,1)=2;  
        else    
            STEPDUR=TEMP(2)-TEMP(1);
            LTA_STIM(i,1)=-TEMP(1)/STEPDUR; 
        end 
    elseif length(TEMP)>2 
        last=length(TEMP);
        SET=0;
        for j=1:last
            if SET==0
            if TEMP(j)<=0 && j==last
                LTA_STIM(i,1)=3;
            elseif TEMP(j)<=0 && TEMP(j+1)>0
                STEPDUR=TEMP(j+1)-TEMP(j);
                LTA_STIM(i,1)=-TEMP(j)/STEPDUR;
                SET=1;
            else
                LTA_STIM(i,1)=NaN;
            end
            end
        end
    end   
    LTA_STIM(i,2)=STIM_DATA_Z(i).zLTAPre;
    LTA_STIM(i,3)=STIM_DATA_Z(i).zLTAresp;
    LTA_STIM(i,4)=STIM_DATA_MU(i).mudLTAPre;
    LTA_STIM(i,5)=STIM_DATA_MU(i).mudLTAresp;
    LTA_STIM(i,6)=STIM_DATA_MU(i).muaLTAPre;
    LTA_STIM(i,7)=STIM_DATA_MU(i).muaLTAresp;
end
Fig1=figure
subplot(2,3,1)
scatter(LTA_STIM(:,1), LTA_STIM(:,2))
xlim([0 1])
title('LTA Z prestim')
ylabel('Z-score')
xlabel('phase')
subplot(2,3,4)
scatter(LTA_STIM(:,1), LTA_STIM(:,3))
xlim([0 1])
title('LTA Z response')
ylabel('Z-score')
xlabel('phase')
subplot(2,3,2)
scatter(LTA_STIM(:,1), LTA_STIM(:,4))
xlim([0 1])
title('LTA nb MU prestim')
ylabel('MU nb')
xlabel('phase')
subplot(2,3,5)
scatter(LTA_STIM(:,1), LTA_STIM(:,5))
xlim([0 1])
title('LTA nb MU response')
ylabel('MU nb')
xlabel('phase')
subplot(2,3,3)
scatter(LTA_STIM(:,1), LTA_STIM(:,6))
xlim([0 1])
title('LTA MUA prestim')
ylabel('spike amplitude')
xlabel('phase')
subplot(2,3,6)
scatter(LTA_STIM(:,1), LTA_STIM(:,7))
xlim([0 1])
title('LTA MUA response')
ylabel('spike amplitude')
xlabel('phase')

%LGL
BURST_LGL=[];
for h=1:length(STIM_DATA_Z)
LGL_Z=STIM_DATA_Z(h).zLGL(:,1);
BURST_LGL=[];
CNT=1;
BRSTN=1; 
ONTIM=0;
OFFTIM=0;

%beginning of the triggered histogram
if LGL_Z(CNT,1)<=ON_LGL
    %relaxed state
    COND=0;
    CNT=CNT+1;
else
    %already bursting, looking for the first end of burst
    COND=1;
    CNT=CNT+1;
    BURST_LGL(BRSTN,1)=NaN;
    BIN_ON=0;
    %looking for the end of the burst
    INIT=1;
    while INIT==1
    if LGL_Z(CNT,1)>OFF_LGL
        %still activated
        CNT=CNT+1;
        BIN_ON=0;
    elseif LGL_Z(CNT,1)<=OFF_LGL && BIN_ON==0
        %cross below the threshold
        OFFTIM=CNT;
        CNT=CNT+1;
        BIN_ON=1;
    elseif LGL_Z(CNT,1)<=OFF_LGL && BIN_ON>0 && BIN_ON<DUROFF_LGL 
        %has already cross below threshold
        BIN_ON=BIN_ON+1;
        CNT=CNT+1;
    elseif LGL_Z(CNT,1)<=OFF_LGL && BIN_ON==DUROFF_LGL 
        INIT=0;
        BURST_LGL(BRSTN,2)=OFFTIM;
        CNT=CNT+1;
        BIN_ON=0;
        BRSTN=2;
        COND=0;
    end
    end
end

BIN_ON=0;

for i=CNT:length(LGL_Z)
    %at initialization of this loop, we are in a relaxed state
    if COND==0
        %relaxed state, we are looking for onset of burst
        if LGL_Z(i,1)<=ON_LGL
            %still relaxed
            BIN_ON=0;
        elseif LGL_Z(i,1)>ON_LGL && BIN_ON==0
            %crosses above threshold
            ONTIM=i;
            BIN_ON=1;
        elseif LGL_Z(i,1)>ON_LGL && BIN_ON>0 && BIN_ON<DURON_LGL 
            %stays above threshold
            BIN_ON=BIN_ON+1;
        elseif LGL_Z(i,1)>ON_LGL && BIN_ON==DURON_LGL 
            COND=1;
            BURST_LGL(BRSTN,1)=ONTIM;
            BIN_ON=0;
        end
    elseif COND==1
        %activated state 
        if LGL_Z(i,1)>OFF_LGL
            %still activated
            BIN_ON=0;
        elseif LGL_Z(i,1)<=OFF_LGL && BIN_ON==0
            %cross below the threshold
            OFFTIM=i;
            BIN_ON=1;
        elseif LGL_Z(i,1)<=OFF_LGL && BIN_ON>0 && BIN_ON<DUROFF_LGL 
            %has already cross below threshold
            BIN_ON=BIN_ON+1;
        elseif LGL_Z(i,1)<=OFF_LGL && BIN_ON==DUROFF_LGL
            COND=0;
            BURST_LGL(BRSTN,2)=OFFTIM;
            BIN_ON=0;
            BRSTN=BRSTN+1;
        end
    end   
end

%ending with a burst?
if COND==1
    BURST_LGL(BRSTN,2)=NaN;
end   

if BRSTN>1
    STIM_DATA_Z(h).LGLon=BURST_LGL(:,1);
    STIM_DATA_Z(h).LGLoff=BURST_LGL(:,2);
else
    STIM_DATA_Z(h).LGLon=NaN;
    STIM_DATA_Z(h).LGLoff=NaN;
end    
end 

STIMLEN=length(STIM_DATA_Z(1).zRTA(:,1));
STIMCENTER=STIMLEN/2;

TEMP=[];
LGL_STIM=[];

%determine the phase
for i=1:length(STIM_DATA_Z)
    TEMP=STIM_DATA_Z(i).LGLon-STIMCENTER;
    if length(TEMP)==1 
        if isnan(TEMP(1))==1  
            LGL_STIM(i,1)=2;  
        elseif TEMP(1)>0
            LGL_STIM(i,1)=2;
        else    
            LGL_STIM(i,1)=3; 
        end 
    elseif length(TEMP)==2  
        if TEMP(1)<0 & TEMP(2)<=0
            LGL_STIM(i,1)=3;  
        elseif TEMP(1)>=0 & TEMP(2)>0
            LGL_STIM(i,1)=2;  
        else    
            STEPDUR=TEMP(2)-TEMP(1);
            LGL_STIM(i,1)=-TEMP(1)/STEPDUR; 
        end 
    elseif length(TEMP)>2 
        last=length(TEMP);
        SET=0;
        for j=1:last
            if SET==0
            if TEMP(j)<=0 && j==last
                LGL_STIM(i,1)=3;
            elseif TEMP(j)<=0 && TEMP(j+1)>0
                STEPDUR=TEMP(j+1)-TEMP(j);
                LGL_STIM(i,1)=-TEMP(j)/STEPDUR;
                SET=1;
            else
                LGL_STIM(i,1)=NaN;
            end
            end
        end
    end   
    LGL_STIM(i,2)=STIM_DATA_Z(i).zLGLPre;
    LGL_STIM(i,3)=STIM_DATA_Z(i).zLGLresp;
    LGL_STIM(i,4)=STIM_DATA_MU(i).mudLGLPre;
    LGL_STIM(i,5)=STIM_DATA_MU(i).mudLGLresp;
    LGL_STIM(i,6)=STIM_DATA_MU(i).muaLGLPre;
    LGL_STIM(i,7)=STIM_DATA_MU(i).muaLGLresp;
end
Fig2=figure
subplot(2,3,1)
scatter(LTA_STIM(:,1), LGL_STIM(:,2))
xlim([0 1])
title('LGL Z prestim')
ylabel('Z-score')
xlabel('phase LTA')
subplot(2,3,4)
scatter(LTA_STIM(:,1), LGL_STIM(:,3))
xlim([0 1])
title('LGL Z response')
ylabel('Z-score')
xlabel('phase LTA')
subplot(2,3,2)
scatter(LTA_STIM(:,1), LGL_STIM(:,4))
xlim([0 1])
title('LGL nb MU prestim')
ylabel('MU nb')
xlabel('phase')
subplot(2,3,5)
scatter(LTA_STIM(:,1), LGL_STIM(:,5))
xlim([0 1])
title('LGL nb MU response')
ylabel('MU nb')
xlabel('phase LTA')
subplot(2,3,3)
scatter(LTA_STIM(:,1), LGL_STIM(:,6))
xlim([0 1])
title('LGL MUA prestim')
ylabel('spike amplitude')
xlabel('phase')
subplot(2,3,6)
scatter(LTA_STIM(:,1), LGL_STIM(:,7))
xlim([0 1])
title('LGL MUA response')
ylabel('spike amplitude')
xlabel('phase')

%RTA
BURST_RTA=[];
for h=1:length(STIM_DATA_Z)
RTA_Z=STIM_DATA_Z(h).zRTA(:,1);
BURST_RTA=[];
CNT=1;
BRSTN=1; 
ONTIM=0;
OFFTIM=0;

if STOPDETECT==1 
RTA_BSL=sum(STIM_DATA_MU(h).mudRTA(1:CENTR,1));
    if RTA_BSL>=THR_RTA   
        DRAGCOND=0;
    else
        DRAGCOND=1;
    end
else
    DRAGCOND=0;
end

if DRAGCOND==0
%beginning of the triggered histogram
if RTA_Z(CNT,1)<=ON_RTA
    %relaxed state
    COND=0;
    CNT=CNT+1;
else
    %already bursting, looking for the first end of burst
    COND=1;
    CNT=CNT+1;
    BURST_RTA(BRSTN,1)=NaN;
    BIN_ON=0;
    %looking for the end of the burst
    INIT=1;
    while INIT==1
    if RTA_Z(CNT,1)>OFF_RTA
        %still activated
        CNT=CNT+1;
        BIN_ON=0;
    elseif RTA_Z(CNT,1)<=OFF_RTA && BIN_ON==0
        %cross below the threshold
        OFFTIM=CNT;
        CNT=CNT+1;
        BIN_ON=1;
    elseif RTA_Z(CNT,1)<=OFF_RTA && BIN_ON>0 && BIN_ON<DUROFF_RTA 
        %has already cross below threshold
        BIN_ON=BIN_ON+1;
        CNT=CNT+1;
    elseif RTA_Z(CNT,1)<=OFF_RTA && BIN_ON==DUROFF_RTA 
        INIT=0;
        BURST_RTA(BRSTN,2)=OFFTIM;
        CNT=CNT+1;
        BIN_ON=0;
        BRSTN=2;
        COND=0;
    end
    end
end

BIN_ON=0;

for i=CNT:length(RTA_Z)
    %at initialization of this loop, we are in a relaxed state
    if COND==0
        %relaxed state, we are looking for onset of burst
        if RTA_Z(i,1)<=ON_RTA
            %still relaxed
            BIN_ON=0;
        elseif RTA_Z(i,1)>ON_RTA && BIN_ON==0
            %crosses above threshold
            ONTIM=i;
            BIN_ON=1;
        elseif RTA_Z(i,1)>ON_RTA && BIN_ON>0 && BIN_ON<DURON_RTA 
            %stays above threshold
            BIN_ON=BIN_ON+1;
        elseif RTA_Z(i,1)>ON_RTA && BIN_ON==DURON_RTA 
            COND=1;
            BURST_RTA(BRSTN,1)=ONTIM;
            BIN_ON=0;
        end
    elseif COND==1
        %activated state 
        if RTA_Z(i,1)>OFF_RTA
            %still activated
            BIN_ON=0;
        elseif RTA_Z(i,1)<=OFF_RTA && BIN_ON==0
            %cross below the threshold
            OFFTIM=i;
            BIN_ON=1;
        elseif RTA_Z(i,1)<=OFF_RTA && BIN_ON>0 && BIN_ON<DUROFF_RTA 
            %has already cross below threshold
            BIN_ON=BIN_ON+1;
        elseif RTA_Z(i,1)<=OFF_RTA && BIN_ON==DUROFF_RTA
            COND=0;
            BURST_RTA(BRSTN,2)=OFFTIM;
            BIN_ON=0;
            BRSTN=BRSTN+1;
        end
    end   
end

%ending with a burst?
if COND==1
    BURST_RTA(BRSTN,2)=NaN;
end   

if BRSTN>1
    STIM_DATA_Z(h).RTAon=BURST_RTA(:,1);
    STIM_DATA_Z(h).RTAoff=BURST_RTA(:,2);
else
    STIM_DATA_Z(h).RTAon=NaN;
    STIM_DATA_Z(h).RTAoff=NaN;
end  

else
    STIM_DATA_Z(h).RTAon=NaN;
    STIM_DATA_Z(h).RTAoff=NaN;
end
end 

STIMLEN=length(STIM_DATA_Z(1).zRTA(:,1));
STIMCENTER=STIMLEN/2;

TEMP=[];
RTA_STIM=[];

%determine the phase
for i=1:length(STIM_DATA_Z)
    TEMP=STIM_DATA_Z(i).RTAon-STIMCENTER;
    if length(TEMP)==1 
        if isnan(TEMP(1))==1  
            RTA_STIM(i,1)=2;  
        elseif TEMP(1)>0
            RTA_STIM(i,1)=2;
        else    
            RTA_STIM(i,1)=3; 
        end 
    elseif length(TEMP)==2  
        if TEMP(1)<0 & TEMP(2)<=0
            RTA_STIM(i,1)=3;  
        elseif TEMP(1)>=0 & TEMP(2)>0
            RTA_STIM(i,1)=2;  
        else    
            STEPDUR=TEMP(2)-TEMP(1);
            RTA_STIM(i,1)=-TEMP(1)/STEPDUR; 
        end   
    elseif length(TEMP)>2 
        last=length(TEMP);
        SET=0;
        for j=1:last
            if SET==0
            if TEMP(j)<=0 && j==last
                RTA_STIM(i,1)=3;
            elseif TEMP(j)<=0 && TEMP(j+1)>0
                STEPDUR=TEMP(j+1)-TEMP(j);
                RTA_STIM(i,1)=-TEMP(j)/STEPDUR;
                SET=1;
            else
                RTA_STIM(i,1)=NaN;
            end
            end
        end
    end   
    RTA_STIM(i,2)=STIM_DATA_Z(i).zRTAPre;
    RTA_STIM(i,3)=STIM_DATA_Z(i).zRTAresp;
    RTA_STIM(i,4)=STIM_DATA_MU(i).mudRTAPre;
    RTA_STIM(i,5)=STIM_DATA_MU(i).mudRTAresp;
    RTA_STIM(i,6)=STIM_DATA_MU(i).muaRTAPre;
    RTA_STIM(i,7)=STIM_DATA_MU(i).muaRTAresp;
end
Fig3=figure
subplot(2,3,1)
scatter(RTA_STIM(:,1), RTA_STIM(:,2))
xlim([0 1])
title('RTA Z prestim')
ylabel('Z-score')
xlabel('phase')
subplot(2,3,4)
scatter(RTA_STIM(:,1), RTA_STIM(:,3))
xlim([0 1])
title('RTA Z response')
ylabel('Z-score')
xlabel('phase')
subplot(2,3,2)
scatter(RTA_STIM(:,1), RTA_STIM(:,4))
xlim([0 1])
title('RTA nb MU prestim')
ylabel('MU nb')
xlabel('phase')
subplot(2,3,5)
scatter(RTA_STIM(:,1), RTA_STIM(:,5))
xlim([0 1])
title('RTA nb MU response')
ylabel('MU nb')
xlabel('phase')
subplot(2,3,3)
scatter(RTA_STIM(:,1), RTA_STIM(:,6))
xlim([0 1])
title('RTA MUA prestim')
ylabel('spike amplitude')
xlabel('phase')
subplot(2,3,6)
scatter(RTA_STIM(:,1), RTA_STIM(:,7))
xlim([0 1])
title('RTA MUA response')
ylabel('spike amplitude')
xlabel('phase')

%RGL
BURST_RGL=[];
for h=1:length(STIM_DATA_Z)
RGL_Z=STIM_DATA_Z(h).zRGL(:,1);
BURST_RGL=[];
CNT=1;
BRSTN=1; 
ONTIM=0;
OFFTIM=0;

%beginning of the triggered histogram
if RGL_Z(CNT,1)<=ON_RGL
    %relaxed state
    COND=0;
    CNT=CNT+1;
else
    %already bursting, looking for the first end of burst
    COND=1;
    CNT=CNT+1;
    BURST_RGL(BRSTN,1)=NaN;
    BIN_ON=0;
    %looking for the end of the burst
    INIT=1;
    while INIT==1
    if RGL_Z(CNT,1)>OFF_RGL
        %still activated
        CNT=CNT+1;
        BIN_ON=0;
    elseif RGL_Z(CNT,1)<=OFF_RGL && BIN_ON==0
        %cross below the threshold
        OFFTIM=CNT;
        CNT=CNT+1;
        BIN_ON=1;
    elseif RGL_Z(CNT,1)<=OFF_RGL && BIN_ON>0 && BIN_ON<DUROFF_RGL 
        %has already cross below threshold
        BIN_ON=BIN_ON+1;
        CNT=CNT+1;
    elseif RGL_Z(CNT,1)<=OFF_RGL && BIN_ON==DUROFF_RGL 
        INIT=0;
        BURST_RGL(BRSTN,2)=OFFTIM;
        CNT=CNT+1;
        BIN_ON=0;
        BRSTN=2;
        COND=0;
    end
    end
end

BIN_ON=0;

for i=CNT:length(RGL_Z)
    %at initialization of this loop, we are in a relaxed state
    if COND==0
        %relaxed state, we are looking for onset of burst
        if RGL_Z(i,1)<=ON_RGL
            %still relaxed
            BIN_ON=0;
        elseif RGL_Z(i,1)>ON_RGL && BIN_ON==0
            %crosses above threshold
            ONTIM=i;
            BIN_ON=1;
        elseif RGL_Z(i,1)>ON_RGL && BIN_ON>0 && BIN_ON<DURON_RGL 
            %stays above threshold
            BIN_ON=BIN_ON+1;
        elseif RGL_Z(i,1)>ON_RGL && BIN_ON==DURON_RGL 
            COND=1;
            BURST_RGL(BRSTN,1)=ONTIM;
            BIN_ON=0;
        end
    elseif COND==1
        %activated state 
        if RGL_Z(i,1)>OFF_RGL
            %still activated
            BIN_ON=0;
        elseif RGL_Z(i,1)<=OFF_RGL && BIN_ON==0
            %cross below the threshold
            OFFTIM=i;
            BIN_ON=1;
        elseif RGL_Z(i,1)<=OFF_RGL && BIN_ON>0 && BIN_ON<DUROFF_RGL 
            %has already cross below threshold
            BIN_ON=BIN_ON+1;
        elseif RGL_Z(i,1)<=OFF_RGL && BIN_ON==DUROFF_RGL
            COND=0;
            BURST_RGL(BRSTN,2)=OFFTIM;
            BIN_ON=0;
            BRSTN=BRSTN+1;
        end
    end   
end

%ending with a burst?
if COND==1
    BURST_RGL(BRSTN,2)=NaN;
end   

if BRSTN>1
    STIM_DATA_Z(h).RGLon=BURST_RGL(:,1);
    STIM_DATA_Z(h).RGLoff=BURST_RGL(:,2);
else
    STIM_DATA_Z(h).RGLon=NaN;
    STIM_DATA_Z(h).RGLoff=NaN;
end    
end 

STIMLEN=length(STIM_DATA_Z(1).zRGL(:,1));
STIMCENTER=STIMLEN/2;

TEMP=[];
RGL_STIM=[];

%determine the phase
for i=1:length(STIM_DATA_Z)
    TEMP=STIM_DATA_Z(i).RGLon-STIMCENTER;
    if length(TEMP)==1 
        if isnan(TEMP(1))==1  
            RGL_STIM(i,1)=2;  
        elseif TEMP(1)>0
            RGL_STIM(i,1)=2;
        else    
            RGL_STIM(i,1)=3; 
        end 
    elseif length(TEMP)==2  
        if TEMP(1)<0 & TEMP(2)<=0
            RGL_STIM(i,1)=3;  
        elseif TEMP(1)>=0 & TEMP(2)>0
            RGL_STIM(i,1)=2;  
        else    
            STEPDUR=TEMP(2)-TEMP(1);
            RGL_STIM(i,1)=-TEMP(1)/STEPDUR; 
        end 
    elseif length(TEMP)>2 
        last=length(TEMP);
        SET=0;
        for j=1:last
            if SET==0
            if TEMP(j)<=0 && j==last
                RGL_STIM(i,1)=3;
            elseif TEMP(j)<=0 && TEMP(j+1)>0
                STEPDUR=TEMP(j+1)-TEMP(j);
                RGL_STIM(i,1)=-TEMP(j)/STEPDUR;
                SET=1;
            else
                RGL_STIM(i,1)=NaN;
            end
            end
        end
    end   
    RGL_STIM(i,2)=STIM_DATA_Z(i).zRGLPre;
    RGL_STIM(i,3)=STIM_DATA_Z(i).zRGLresp;
    RGL_STIM(i,4)=STIM_DATA_MU(i).mudRGLPre;
    RGL_STIM(i,5)=STIM_DATA_MU(i).mudRGLresp;
    RGL_STIM(i,6)=STIM_DATA_MU(i).muaRGLPre;
    RGL_STIM(i,7)=STIM_DATA_MU(i).muaRGLresp;
end
Fig2=figure
subplot(2,3,1)
scatter(RTA_STIM(:,1), RGL_STIM(:,2))
xlim([0 1])
title('RGL Z prestim')
ylabel('Z-score')
xlabel('RTA phase')
subplot(2,3,4)
scatter(RTA_STIM(:,1), RGL_STIM(:,3))
xlim([0 1])
title('RGL Z response')
ylabel('Z-score')
xlabel('RTA phase')
subplot(2,3,2)
scatter(RTA_STIM(:,1), RGL_STIM(:,4))
xlim([0 1])
title('RGL nb MU prestim')
ylabel('MU nb')
xlabel('RTA phase')
subplot(2,3,5)
scatter(RTA_STIM(:,1), RGL_STIM(:,5))
xlim([0 1])
title('RGL nb MU response')
ylabel('MU nb')
xlabel('RTA phase')
subplot(2,3,3)
scatter(RTA_STIM(:,1), RGL_STIM(:,6))
xlim([0 1])
title('RGL MUA prestim')
ylabel('spike amplitude')
xlabel('RTA phase')
subplot(2,3,6)
scatter(RTA_STIM(:,1), RGL_STIM(:,7))
xlim([0 1])
title('RGL MUA response')
ylabel('spike amplitude')
xlabel('RTA phase')


outname2=strcat(inputname, '_',timepoint, '_resp.mat');
save(outname2, 'STIM_DATA_Z', 'LTA_STIM', 'LGL_STIM', 'RTA_STIM', 'RGL_STIM')
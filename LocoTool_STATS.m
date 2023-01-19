ID='Gi17547'
fname=dir('*_resp.mat');

timepoint=[];
LOCO=[];
STOP=[];
RESET=[];

for i=1:length(fname)
    tempname=fname(i).name;
    load(tempname)
    cur=fname(i).name(9:11);
    switch cur
        case 'ctl'
            timepoint=0;
        case 'wk1'   
            timepoint=1;
        case 'wk3'
            timepoint=3;
        case 'wk7'
            timepoint=7;
    end

    %LEFT SIDE
    CNT1=0;
    CNT2=0;
    CNT3=0;

    for j=1:length(STIM_DATA_Z)
        if isnan(LTA_STIM(j,1))==0
            if LTA_STIM(j,1)>=0 & LTA_STIM(j,1)<=1
            CNT1=CNT1+1;
            LOCO(i).LEFT(CNT1,1)=timepoint;
            LOCO(i).LEFT(CNT1,2)=STIM_DATA_Z(j).time;
            LOCO(i).LEFT(CNT1,3)=LTA_STIM(j,1);
            LOCO(i).LEFT(CNT1,4)=LTA_STIM(j,2);
            LOCO(i).LEFT(CNT1,5)=LTA_STIM(j,4);
            LOCO(i).LEFT(CNT1,6)=LTA_STIM(j,5);
            LOCO(i).LEFT(CNT1,7)=LTA_STIM(j,7);
            LOCO(i).LEFT(CNT1,8)=LGL_STIM(j,2);
            LOCO(i).LEFT(CNT1,9)=LGL_STIM(j,4);
            LOCO(i).LEFT(CNT1,10)=LGL_STIM(j,5);
            LOCO(i).LEFT(CNT1,11)=LGL_STIM(j,7);
            LOCO(i).LEFT(CNT1,12)=floor(LTA_STIM(j,1)/0.1);
            elseif LTA_STIM(j,1)==2
            CNT2=CNT2+1;
            STOP(i).LEFT(CNT2,1)=timepoint;
            STOP(i).LEFT(CNT2,2)=STIM_DATA_Z(j).time;
            STOP(i).LEFT(CNT2,3)=LTA_STIM(j,1);
            STOP(i).LEFT(CNT2,4)=LTA_STIM(j,2);
            STOP(i).LEFT(CNT2,5)=LTA_STIM(j,4);
            STOP(i).LEFT(CNT2,6)=LTA_STIM(j,5);
            STOP(i).LEFT(CNT2,7)=LTA_STIM(j,7);
            STOP(i).LEFT(CNT2,8)=LGL_STIM(j,2);
            STOP(i).LEFT(CNT2,9)=LGL_STIM(j,4);
            STOP(i).LEFT(CNT2,10)=LGL_STIM(j,5);
            STOP(i).LEFT(CNT2,11)=LGL_STIM(j,7);
            elseif LTA_STIM(j,1)==3
            CNT3=CNT3+1;
            RESET(i).LEFT(CNT3,1)=timepoint;
            RESET(i).LEFT(CNT3,2)=STIM_DATA_Z(j).time;
            RESET(i).LEFT(CNT3,3)=LTA_STIM(j,1);
            RESET(i).LEFT(CNT3,4)=LTA_STIM(j,2);
            RESET(i).LEFT(CNT3,5)=LTA_STIM(j,4);
            RESET(i).LEFT(CNT3,6)=LTA_STIM(j,5);
            RESET(i).LEFT(CNT3,7)=LTA_STIM(j,7);
            RESET(i).LEFT(CNT3,8)=LGL_STIM(j,2);
            RESET(i).LEFT(CNT3,9)=LGL_STIM(j,4);
            RESET(i).LEFT(CNT3,10)=LGL_STIM(j,5);
            RESET(i).LEFT(CNT3,11)=LGL_STIM(j,7);
            end
        end
    end

    %RIGHT SIDE
    CNT1=0;
    CNT2=0;
    CNT3=0;

    for j=1:length(STIM_DATA_Z)
        if isnan(RTA_STIM(j,1))==0
            if RTA_STIM(j,1)>=0 & RTA_STIM(j,1)<=1
            CNT1=CNT1+1;
            LOCO(i).RIGHT(CNT1,1)=timepoint;
            LOCO(i).RIGHT(CNT1,2)=STIM_DATA_Z(j).time;
            LOCO(i).RIGHT(CNT1,3)=RTA_STIM(j,1);
            LOCO(i).RIGHT(CNT1,4)=RTA_STIM(j,2);
            LOCO(i).RIGHT(CNT1,5)=RTA_STIM(j,4);
            LOCO(i).RIGHT(CNT1,6)=RTA_STIM(j,5);
            LOCO(i).RIGHT(CNT1,7)=RTA_STIM(j,7);
            LOCO(i).RIGHT(CNT1,8)=RGL_STIM(j,2);
            LOCO(i).RIGHT(CNT1,9)=RGL_STIM(j,4);
            LOCO(i).RIGHT(CNT1,10)=RGL_STIM(j,5);
            LOCO(i).RIGHT(CNT1,11)=RGL_STIM(j,7);
            LOCO(i).RIGHT(CNT1,12)=floor(RTA_STIM(j,1)/0.1);
            elseif RTA_STIM(j,1)==2
            CNT2=CNT2+1;
            STOP(i).RIGHT(CNT2,1)=timepoint;
            STOP(i).RIGHT(CNT2,2)=STIM_DATA_Z(j).time;
            STOP(i).RIGHT(CNT2,3)=RTA_STIM(j,1);
            STOP(i).RIGHT(CNT2,4)=RTA_STIM(j,2);
            STOP(i).RIGHT(CNT2,5)=RTA_STIM(j,4);
            STOP(i).RIGHT(CNT2,6)=RTA_STIM(j,5);
            STOP(i).RIGHT(CNT2,7)=RTA_STIM(j,7);
            STOP(i).RIGHT(CNT2,8)=RGL_STIM(j,2);
            STOP(i).RIGHT(CNT2,9)=RGL_STIM(j,4);
            STOP(i).RIGHT(CNT2,10)=RGL_STIM(j,5);
            STOP(i).RIGHT(CNT2,11)=RGL_STIM(j,7);
            elseif RTA_STIM(j,1)==3
            CNT3=CNT3+1;
            RESET(i).RIGHT(CNT3,1)=timepoint;
            RESET(i).RIGHT(CNT3,2)=STIM_DATA_Z(j).time;
            RESET(i).RIGHT(CNT3,3)=RTA_STIM(j,1);
            RESET(i).RIGHT(CNT3,4)=RTA_STIM(j,2);
            RESET(i).RIGHT(CNT3,5)=RTA_STIM(j,4);
            RESET(i).RIGHT(CNT3,6)=RTA_STIM(j,5);
            RESET(i).RIGHT(CNT3,7)=RTA_STIM(j,7);
            RESET(i).RIGHT(CNT3,8)=RGL_STIM(j,2);
            RESET(i).RIGHT(CNT3,9)=RGL_STIM(j,4);
            RESET(i).RIGHT(CNT3,10)=RGL_STIM(j,5);
            RESET(i).RIGHT(CNT3,11)=RGL_STIM(j,7);
            end
        end
    end
end    

%use to select phase boundaries for LTA
Fig1A=figure;
subplot(4,2,1)
boxplot(LOCO(1).LEFT(:,5),LOCO(1).LEFT(:,12))
title('LTA MSD baseline pre-SCI')
subplot(4,2,2)
boxplot(LOCO(1).LEFT(:,9),LOCO(1).LEFT(:,12))
title('LGL MSD baseline pre-SCI')
subplot(4,2,3)
boxplot(LOCO(2).LEFT(:,5),LOCO(2).LEFT(:,12))
title('LTA MSD baseline week 1')
subplot(4,2,4)
boxplot(LOCO(2).LEFT(:,9),LOCO(2).LEFT(:,12))
title('LGL MSD baseline week 1')
subplot(4,2,5)
boxplot(LOCO(3).LEFT(:,5),LOCO(3).LEFT(:,12))
title('LTA MSD baseline week 3')
subplot(4,2,6)
boxplot(LOCO(3).LEFT(:,9),LOCO(3).LEFT(:,12))
title('LGL MSD baseline week 3')
subplot(4,2,7)
boxplot(LOCO(4).LEFT(:,5),LOCO(4).LEFT(:,12))
title('LTA MSD baseline week 7')
subplot(4,2,8)
boxplot(LOCO(4).LEFT(:,9),LOCO(4).LEFT(:,12))
title('LGL MSD baseline week 7')

str='move window and resize, then press ENTER'
pause

prompt = {'Pre-SCI - lo','Pre-SCI - hi', 'Week 1 - lo','Week 1 - hi', ...
    'Week 3 - lo','Week 3 - hi','Week 7 - lo','Week 7 - hi',};
dlgtitle = 'Phase boundaries';
dims = [1 20];
definput = {'0.4','0.8','0.4','0.8','0.4','0.8','0.4','0.8'};
phaseth = inputdlg(prompt,dlgtitle,dims,definput)

outname2=strcat('Fig1A_', ID, '_backgroundLTA.pdf');
saveas(Fig1A, outname2)
close all

temp=cell2mat(phaseth);
temp2=str2num(temp);
boundary_L=zeros([4 2]);
boundary_L(1,1)=(temp2(1));
boundary_L(1,2)=(temp2(2));
boundary_L(2,1)=(temp2(3));
boundary_L(2,2)=(temp2(4));
boundary_L(3,1)=(temp2(5));
boundary_L(3,2)=(temp2(6));
boundary_L(4,1)=(temp2(7));
boundary_L(4,2)=(temp2(8));

%use to select phase boundaries for RTA
Fig1B=figure;
subplot(4,2,1)
boxplot(LOCO(1).RIGHT(:,5),LOCO(1).RIGHT(:,12))
title('RTA MSD baseline pre-SCI')
subplot(4,2,2)
boxplot(LOCO(1).RIGHT(:,9),LOCO(1).RIGHT(:,12))
title('RGL MSD baseline pre-SCI')
subplot(4,2,3)
boxplot(LOCO(2).RIGHT(:,5),LOCO(2).RIGHT(:,12))
title('RTA MSD baseline week 1')
subplot(4,2,4)
boxplot(LOCO(2).RIGHT(:,9),LOCO(2).RIGHT(:,12))
title('RGL MSD baseline week 1')
subplot(4,2,5)
boxplot(LOCO(3).RIGHT(:,5),LOCO(3).RIGHT(:,12))
title('RTA MSD baseline week 3')
subplot(4,2,6)
boxplot(LOCO(3).RIGHT(:,9),LOCO(3).RIGHT(:,12))
title('RGL MSD baseline week 3')
subplot(4,2,7)
boxplot(LOCO(4).RIGHT(:,5),LOCO(4).RIGHT(:,12))
title('RTA MSD baseline week 7')
subplot(4,2,8)
boxplot(LOCO(4).RIGHT(:,9),LOCO(4).RIGHT(:,12))
title('RGL MSD baseline week 7')

str='move window and resize, then press ENTER'
pause

prompt = {'Pre-SCI - lo','Pre-SCI - hi', 'Week 1 - lo','Week 1 - hi', ...
    'Week 3 - lo','Week 3 - hi','Week 7 - lo','Week 7 - hi',};
dlgtitle = 'Phase boundaries';
dims = [1 20];
definput = {'0.4','0.8','0.4','0.8','0.4','0.8','0.4','0.8'};
phaseth = inputdlg(prompt,dlgtitle,dims,definput)

outname2=strcat('Fig1B_', ID, '_backgroundRTA.pdf');
saveas(Fig1B, outname2)
close all

temp=cell2mat(phaseth);
temp2=str2num(temp);
boundary_R=zeros([4 2]);
boundary_R(1,1)=(temp2(1));
boundary_R(1,2)=(temp2(2));
boundary_R(2,1)=(temp2(3));
boundary_R(2,2)=(temp2(4));
boundary_R(3,1)=(temp2(5));
boundary_R(3,2)=(temp2(6));
boundary_R(4,1)=(temp2(7));
boundary_R(4,2)=(temp2(8));

%split right side
SWING_LEFT.EXC=[];
SWING_LEFT.INH=[];
SWING_LEFT.FAIL=[];
SWING_LEFT.PROP=zeros([4 3])
STANCE_LEFT.EXC=[];
STANCE_LEFT.INH=[];
STANCE_LEFT.FAIL=[];
STANCE_LEFT.PROP=zeros([4 3])
PRESW_LEFT.EXC=[];
PRESW_LEFT.INH=[];
PRESW_LEFT.FAIL=[];
PRESW_LEFT.PROP=zeros([4 3])

TEMP=[]

for i=1:length(LOCO)
    for j=1:length(LOCO(i).LEFT(:,1))        
        phase=LOCO(i).LEFT(j,3);
        TEMP=LOCO(i).LEFT(j,1:11);
        if phase<boundary_R(i,1)
            if LOCO(i).LEFT(j,6)==0
            SWING_LEFT.FAIL=cat(1,SWING_LEFT.FAIL,TEMP);   
            SWING_LEFT.PROP(i,1)=SWING_LEFT.PROP(i,1)+1;
            elseif LOCO(i).LEFT(j,6)>0
            SWING_LEFT.EXC=cat(1,SWING_LEFT.EXC,TEMP);
            SWING_LEFT.PROP(i,2)=SWING_LEFT.PROP(i,2)+1;
            elseif LOCO(i).LEFT(j,6)<0
            SWING_LEFT.INH=cat(1,SWING_LEFT.INH,TEMP);
            SWING_LEFT.PROP(i,3)=SWING_LEFT.PROP(i,3)+1;            
            end
        elseif phase>=boundary_R(i,1) & phase<=boundary_R(i,2)   
            if LOCO(i).LEFT(j,6)==0
            STANCE_LEFT.FAIL=cat(1,STANCE_LEFT.FAIL,TEMP);   
            STANCE_LEFT.PROP(i,1)=STANCE_LEFT.PROP(i,1)+1;
            elseif LOCO(i).LEFT(j,6)>0
            STANCE_LEFT.EXC=cat(1,STANCE_LEFT.EXC,TEMP);
            STANCE_LEFT.PROP(i,2)=STANCE_LEFT.PROP(i,2)+1;
            elseif LOCO(i).LEFT(j,6)<0
            STANCE_LEFT.INH=cat(1,STANCE_LEFT.INH,TEMP);
            STANCE_LEFT.PROP(i,3)=STANCE_LEFT.PROP(i,3)+1;            
            end 
        elseif phase>=boundary_R(i,2)  
            if LOCO(i).LEFT(j,6)==0
            PRESW_LEFT.FAIL=cat(1,PRESW_LEFT.FAIL,TEMP);   
            PRESW_LEFT.PROP(i,1)=PRESW_LEFT.PROP(i,1)+1;
            elseif LOCO(i).LEFT(j,6)>0
            PRESW_LEFT.EXC=cat(1,PRESW_LEFT.EXC,TEMP);
            PRESW_LEFT.PROP(i,2)=PRESW_LEFT.PROP(i,2)+1;
            elseif LOCO(i).LEFT(j,6)<0
            PRESW_LEFT.INH=cat(1,PRESW_LEFT.INH,TEMP);
            PRESW_LEFT.PROP(i,3)=PRESW_LEFT.PROP(i,3)+1;            
            end
        end    
    end 
end    

Fig2A=figure;
subplot(3,3,1)
bar(SWING_LEFT.PROP, 'stacked')
title('LEFT side during Swing')
ylabel('nb stim per response types')
legend('fail', 'EXC','INH')
subplot(3,3,2)
boxplot(SWING_LEFT.EXC(:,6),SWING_LEFT.EXC(:,1))
title('LTA EXC resp during Swing')
subplot(3,3,3)
boxplot(SWING_LEFT.EXC(:,7),SWING_LEFT.EXC(:,1))
title('LTA EXC  resp during Swing')
subplot(3,3,4)
bar(STANCE_LEFT.PROP, 'stacked')
title('LEFT side during stance')
ylabel('nb stim')
subplot(3,3,5)
boxplot(STANCE_LEFT.EXC(:,6),STANCE_LEFT.EXC(:,1))
title('LTA EXC resp during stance')
subplot(3,3,6)
boxplot(STANCE_LEFT.EXC(:,7),STANCE_LEFT.EXC(:,1))
title('LTA exc  resp during stance')
subplot(3,3,7)
bar(PRESW_LEFT.PROP, 'stacked')
title('LEFT side before swing')
ylabel('nb stim')
subplot(3,3,8)
boxplot(PRESW_LEFT.EXC(:,6),PRESW_LEFT.EXC(:,1))
title('LTA EXC resp before swing')
subplot(3,3,9)
boxplot(PRESW_LEFT.EXC(:,7),PRESW_LEFT.EXC(:,1))
title('LTA amp  resp before swing')

%split right side
SWING_RIGHT.EXC=[];
SWING_RIGHT.INH=[];
SWING_RIGHT.FAIL=[];
SWING_RIGHT.PROP=zeros([4 3])
STANCE_RIGHT.EXC=[];
STANCE_RIGHT.INH=[];
STANCE_RIGHT.FAIL=[];
STANCE_RIGHT.PROP=zeros([4 3])
PRESW_RIGHT.EXC=[];
PRESW_RIGHT.INH=[];
PRESW_RIGHT.FAIL=[];
PRESW_RIGHT.PROP=zeros([4 3])

TEMP=[]

for i=1:length(LOCO)
    for j=1:length(LOCO(i).RIGHT(:,1))        
        phase=LOCO(i).RIGHT(j,3);
        TEMP=LOCO(i).RIGHT(j,1:11);
        if phase<boundary_R(i,1)
            if LOCO(i).RIGHT(j,6)==0
            SWING_RIGHT.FAIL=cat(1,SWING_RIGHT.FAIL,TEMP);   
            SWING_RIGHT.PROP(i,1)=SWING_RIGHT.PROP(i,1)+1;
            elseif LOCO(i).RIGHT(j,6)>0
            SWING_RIGHT.EXC=cat(1,SWING_RIGHT.EXC,TEMP);
            SWING_RIGHT.PROP(i,2)=SWING_RIGHT.PROP(i,2)+1;
            elseif LOCO(i).RIGHT(j,6)<0
            SWING_RIGHT.INH=cat(1,SWING_RIGHT.INH,TEMP);
            SWING_RIGHT.PROP(i,3)=SWING_RIGHT.PROP(i,3)+1;            
            end
        elseif phase>=boundary_R(i,1) & phase<=boundary_R(i,2)   
            if LOCO(i).RIGHT(j,6)==0
            STANCE_RIGHT.FAIL=cat(1,STANCE_RIGHT.FAIL,TEMP);   
            STANCE_RIGHT.PROP(i,1)=STANCE_RIGHT.PROP(i,1)+1;
            elseif LOCO(i).RIGHT(j,6)>0
            STANCE_RIGHT.EXC=cat(1,STANCE_RIGHT.EXC,TEMP);
            STANCE_RIGHT.PROP(i,2)=STANCE_RIGHT.PROP(i,2)+1;
            elseif LOCO(i).RIGHT(j,6)<0
            STANCE_RIGHT.INH=cat(1,STANCE_RIGHT.INH,TEMP);
            STANCE_RIGHT.PROP(i,3)=STANCE_RIGHT.PROP(i,3)+1;            
            end 
        elseif phase>=boundary_R(i,2)  
            if LOCO(i).RIGHT(j,6)==0
            PRESW_RIGHT.FAIL=cat(1,PRESW_RIGHT.FAIL,TEMP);   
            PRESW_RIGHT.PROP(i,1)=PRESW_RIGHT.PROP(i,1)+1;
            elseif LOCO(i).RIGHT(j,6)>0
            PRESW_RIGHT.EXC=cat(1,PRESW_RIGHT.EXC,TEMP);
            PRESW_RIGHT.PROP(i,2)=PRESW_RIGHT.PROP(i,2)+1;
            elseif LOCO(i).RIGHT(j,6)<0
            PRESW_RIGHT.INH=cat(1,PRESW_RIGHT.INH,TEMP);
            PRESW_RIGHT.PROP(i,3)=PRESW_RIGHT.PROP(i,3)+1;            
            end
        end    
    end 
end    

Fig2B=figure;
subplot(3,3,1)
bar(SWING_RIGHT.PROP, 'stacked')
title('RIGHT side during Swing')
ylabel('nb stim per response types')
legend('fail', 'EXC','INH')
subplot(3,3,2)
boxplot(SWING_RIGHT.EXC(:,6),SWING_RIGHT.EXC(:,1))
title('RTA EXC resp during Swing')
subplot(3,3,3)
boxplot(SWING_RIGHT.EXC(:,7),SWING_RIGHT.EXC(:,1))
title('RTA EXC AMP resp during Swing')
subplot(3,3,4)
bar(STANCE_RIGHT.PROP, 'stacked')
title('RIGHT side during stance')
ylabel('nb stim')
subplot(3,3,5)
boxplot(STANCE_RIGHT.EXC(:,6),STANCE_RIGHT.EXC(:,1))
title('RTA EXC resp during stance')
subplot(3,3,6)
boxplot(STANCE_RIGHT.EXC(:,7),STANCE_RIGHT.EXC(:,1))
title('RTA EXC AMP  resp during stance')
subplot(3,3,7)
bar(PRESW_RIGHT.PROP, 'stacked')
title('RIGHT side before swing')
ylabel('nb stim')
subplot(3,3,8)
boxplot(PRESW_RIGHT.EXC(:,6),PRESW_RIGHT.EXC(:,1))
title('RTA EXC resp before swing')
subplot(3,3,9)
boxplot(PRESW_RIGHT.EXC(:,7),PRESW_RIGHT.EXC(:,1))
title('RTA EXC AMP resp before swing')

str='Press Enter to save figures'
pause

outname1=strcat('Fig2A_', ID, '_MUDRESP_LTA.pdf');
saveas(Fig2A, outname1)
outname2=strcat('Fig2B_', ID, '_MUDRESP_RTA.pdf');
saveas(Fig2B, outname2)
close all

%STOP ON LEFT SIDE
STOP_LEFT.EXC=[];
STOP_LEFT.INH=[];
STOP_LEFT.FAIL=[];
STOP_LEFT.PROP=zeros([4 3])

for i=1:length(STOP)
    if isempty(STOP(i).LEFT)==0
    for j=1:length(STOP(i).LEFT(:,1))           
        TEMP=STOP(i).LEFT(j,1:11);
        if STOP(i).LEFT(j,6)==0
            STOP_LEFT.FAIL=cat(1,STOP_LEFT.FAIL,TEMP);   
            STOP_LEFT.PROP(i,1)=STOP_LEFT.PROP(i,1)+1;
        elseif STOP(i).LEFT(j,6)>0
            STOP_LEFT.EXC=cat(1,STOP_LEFT.EXC,TEMP);
            STOP_LEFT.PROP(i,2)=STOP_LEFT.PROP(i,2)+1;
        elseif STOP(i).LEFT(j,6)<0
            STOP_LEFT.INH=cat(1,STOP_LEFT.INH,TEMP);
            STOP_LEFT.PROP(i,3)=STOP_LEFT.PROP(i,3)+1;            
        end  
    end 
    end
end 

Fig3=figure;
subplot(2,3,1)
bar(STOP_LEFT.PROP, 'stacked')
title('LEFT response during STOP')
ylabel('nb stim')
legend('fail', 'EXC','INH')
subplot(2,3,2)
boxplot(STOP_LEFT.EXC(:,6), STOP_LEFT.EXC(:,1))
title('LTA MSD response during STOP')
subplot(2,3,3)
boxplot(STOP_LEFT.EXC(:,10), STOP_LEFT.EXC(:,1))
title('LGL MSD response during STOP')

%STOP ON RIGHT SIDE
STOP_RIGHT.EXC=[];
STOP_RIGHT.INH=[];
STOP_RIGHT.FAIL=[];
STOP_RIGHT.PROP=zeros([4 3])

for i=1:length(STOP)
    if isempty(STOP(i).RIGHT)==0
    for j=1:length(STOP(i).RIGHT(:,1))           
        TEMP=STOP(i).RIGHT(j,1:11);
        if STOP(i).RIGHT(j,6)==0
            STOP_RIGHT.FAIL=cat(1,STOP_RIGHT.FAIL,TEMP);   
            STOP_RIGHT.PROP(i,1)=STOP_RIGHT.PROP(i,1)+1;
        elseif STOP(i).RIGHT(j,6)>0
            STOP_RIGHT.EXC=cat(1,STOP_RIGHT.EXC,TEMP);
            STOP_RIGHT.PROP(i,2)=STOP_RIGHT.PROP(i,2)+1;
        elseif STOP(i).RIGHT(j,6)<0
            STOP_RIGHT.INH=cat(1,STOP_RIGHT.INH,TEMP);
            STOP_RIGHT.PROP(i,3)=STOP_RIGHT.PROP(i,3)+1;            
        end  
    end 
    end
end 

subplot(2,3,4)
bar(STOP_RIGHT.PROP, 'stacked')
ylabel('nb stim')
title('RIGHT response during STOP')
subplot(2,3,5)
boxplot(STOP_RIGHT.EXC(:,6), STOP_RIGHT.EXC(:,1))
title('RTA MSD response during STOP')
subplot(2,3,6)
boxplot(STOP_RIGHT.EXC(:,10), STOP_RIGHT.EXC(:,1))
title('RGL MSD response during STOP')

%RESET ON LEFT SIDE
RESET_LEFT.EXC=[];
RESET_LEFT.INH=[];
RESET_LEFT.FAIL=[];
RESET_LEFT.PROP=zeros([4 3])

for i=1:length(RESET)
    if isempty(RESET(i).LEFT)==0
    for j=1:length(RESET(i).LEFT(:,1))        
        TEMP=RESET(i).LEFT(j,1:11);
        if RESET(i).LEFT(j,6)==0
            RESET_LEFT.FAIL=cat(1,RESET_LEFT.FAIL,TEMP);   
            RESET_LEFT.PROP(i,1)=RESET_LEFT.PROP(i,1)+1;
        elseif RESET(i).LEFT(j,6)>0
            RESET_LEFT.EXC=cat(1,RESET_LEFT.EXC,TEMP);
            RESET_LEFT.PROP(i,2)=RESET_LEFT.PROP(i,2)+1;
        elseif RESET(i).LEFT(j,6)<0
            RESET_LEFT.INH=cat(1,RESET_LEFT.INH,TEMP);
            RESET_LEFT.PROP(i,3)=RESET_LEFT.PROP(i,3)+1;            
        end  
    end 
    end
end 

Fig4=figure;
subplot(2,3,1)
bar(RESET_LEFT.PROP, 'stacked')
title('LEFT resp during RESET')
ylabel('nb stim')
legend('fail', 'EXC','INH')
subplot(2,3,2)
boxplot(RESET_LEFT.EXC(:,6), RESET_LEFT.EXC(:,1))
title('LTA MSD response during RESET')
subplot(2,3,3)
boxplot(RESET_LEFT.EXC(:,10), RESET_LEFT.EXC(:,1))
title('LGL MSD response during RESET')

%RESET ON RIGHT SIDE
RESET_RIGHT.EXC=[];
RESET_RIGHT.INH=[];
RESET_RIGHT.FAIL=[];
RESET_RIGHT.PROP=zeros([4 3])

for i=1:length(RESET)
    if isempty(RESET(i).RIGHT)==0
    for j=1:length(RESET(i).RIGHT(:,1))        
        TEMP=RESET(i).RIGHT(j,1:11);
        if RESET(i).RIGHT(j,6)==0
            RESET_RIGHT.FAIL=cat(1,RESET_RIGHT.FAIL,TEMP);   
            RESET_RIGHT.PROP(i,1)=RESET_RIGHT.PROP(i,1)+1;
        elseif RESET(i).RIGHT(j,6)>0
            RESET_RIGHT.EXC=cat(1,RESET_RIGHT.EXC,TEMP);
            RESET_RIGHT.PROP(i,2)=RESET_RIGHT.PROP(i,2)+1;
        elseif RESET(i).RIGHT(j,6)<0
            RESET_RIGHT.INH=cat(1,RESET_RIGHT.INH,TEMP);
            RESET_RIGHT.PROP(i,3)=RESET_RIGHT.PROP(i,3)+1;            
        end  
    end 
    end
end 

subplot(2,3,4)
bar(RESET_RIGHT.PROP, 'stacked')
title('RIGHT resp during RESET')
ylabel('nb stim')
subplot(2,3,5)
boxplot(RESET_RIGHT.EXC(:,6), RESET_RIGHT.EXC(:,1))
title('RTA MSD response during RESET')
subplot(2,3,6)
boxplot(RESET_RIGHT.EXC(:,10), RESET_RIGHT.EXC(:,1))
title('RGL MSD response during RESET')

str='Press Enter to save figures'
pause

outname1=strcat('Fig3_', ID, '_STOP.pdf');
saveas(Fig3, outname1)
outname2=strcat('Fig4_', ID, '_RESET.pdf');
saveas(Fig4, outname2)
close all



outname=strcat('SortedData_', ID, '.mat');
save(outname, 'LOCO', 'RESET', 'STOP', 'boundary_L', 'boundary_R', ...
    'SWING_LEFT', 'STANCE_LEFT', 'PRESW_LEFT', ...
    'SWING_RIGHT', 'STANCE_RIGHT', 'PRESW_RIGHT',...
    'STOP_LEFT', 'RESET_LEFT','STOP_RIGHT', 'RESET_RIGHT')
clear all

disp('Data saved.')
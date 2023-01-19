%This script is to evaluate the MU density baseline level to eventually
%bypass burst detection
ID='Gi17231';

%pre-SCI
timepoint='ctl';
temp=strcat(ID, '_', timepoint, '_trigMU.mat');
load(temp)
LTA_BSL_CTL=[];
RTA_BSL_CTL=[];

NBBIN=length(STIM_DATA_MU(1).mudLTA);
CENTR=NBBIN/2;


for i=1:length(STIM_DATA_MU)
   LTA_BSL_CTL(i,1)=sum(STIM_DATA_MU(i).mudLTA(1:CENTR,1));
   LTA_BSL_CTL(i,2)=sum(STIM_DATA_MU(i).mudLTA(CENTR+1:NBBIN,1));
   RTA_BSL_CTL(i,1)=sum(STIM_DATA_MU(i).mudRTA(1:CENTR,1));
   RTA_BSL_CTL(i,2)=sum(STIM_DATA_MU(i).mudRTA(CENTR+1:NBBIN,1));
end   

%wk1
timepoint='wk1';
temp=strcat(ID, '_', timepoint, '_trigMU.mat');
load(temp)
LTA_BSL_WK1=[];
RTA_BSL_WK1=[];

NBBIN=length(STIM_DATA_MU(1).mudLTA);
CENTR=NBBIN/2;


for i=1:length(STIM_DATA_MU)
   LTA_BSL_WK1(i,1)=sum(STIM_DATA_MU(i).mudLTA(1:CENTR,1));
   LTA_BSL_WK1(i,2)=sum(STIM_DATA_MU(i).mudLTA(CENTR+1:NBBIN,1));
   RTA_BSL_WK1(i,1)=sum(STIM_DATA_MU(i).mudRTA(1:CENTR,1));
   RTA_BSL_WK1(i,2)=sum(STIM_DATA_MU(i).mudRTA(CENTR+1:NBBIN,1));
end  

%wk7
timepoint='wk7';
temp=strcat(ID, '_', timepoint, '_trigMU.mat');
load(temp)
LTA_BSL_WK7=[];
RTA_BSL_WK7=[];

NBBIN=length(STIM_DATA_MU(1).mudLTA);
CENTR=NBBIN/2;


for i=1:length(STIM_DATA_MU)
   LTA_BSL_WK7(i,1)=sum(STIM_DATA_MU(i).mudLTA(1:CENTR,1));
   LTA_BSL_WK7(i,2)=sum(STIM_DATA_MU(i).mudLTA(CENTR+1:NBBIN,1));
   RTA_BSL_WK7(i,1)=sum(STIM_DATA_MU(i).mudRTA(1:CENTR,1));
   RTA_BSL_WK7(i,2)=sum(STIM_DATA_MU(i).mudRTA(CENTR+1:NBBIN,1));
end   



subplot(4,2,1)
cdfplot(LTA_BSL_CTL(:,1))
hold all
cdfplot(LTA_BSL_WK1(:,1))
cdfplot(LTA_BSL_WK7(:,1))
title('LTA Pre-stim')
legend('ctl', 'wk1', 'wk7')

subplot(4,2,2)
cdfplot(RTA_BSL_CTL(:,1))
hold all
cdfplot(RTA_BSL_WK1(:,1))
cdfplot(RTA_BSL_WK7(:,1))
title('RTA Pre-stim')
legend('ctl', 'wk1', 'wk7')

subplot(4,2,3)
scatter(LTA_BSL_CTL(:,1), LTA_BSL_CTL(:,2))
hold all
scatter(LTA_BSL_WK1(:,1), LTA_BSL_WK1(:,2))
scatter(LTA_BSL_WK7(:,1), LTA_BSL_WK7(:,2))
xlabel('pre-stim')
ylabel('post-stim')
title(ID)

subplot(4,2,4)
scatter(RTA_BSL_CTL(:,1), RTA_BSL_CTL(:,2))
hold all
scatter(RTA_BSL_WK1(:,1), RTA_BSL_WK1(:,2))
scatter(RTA_BSL_WK7(:,1), RTA_BSL_WK7(:,2))
xlabel('pre-stim')
ylabel('post-stim')
title(ID)

subplot(4,2,5)
cdfplot(LTA_BSL_CTL(:,2))
hold all
cdfplot(LTA_BSL_WK1(:,2))
cdfplot(LTA_BSL_WK7(:,2))
title('Post-stim')

subplot(4,2,6)
cdfplot(RTA_BSL_CTL(:,2))
hold all
cdfplot(RTA_BSL_WK1(:,2))
cdfplot(RTA_BSL_WK7(:,2))
title('Post-stim')

LTA_BSL_AVG=[];
LTA_BSL_AVG(1,1)=mean(LTA_BSL_CTL(:,1));
LTA_BSL_AVG(2,1)=mean(LTA_BSL_WK1(:,1));
LTA_BSL_AVG(3,1)=mean(LTA_BSL_WK7(:,1));
LTA_BSL_AVG(1,2)=mean(LTA_BSL_CTL(:,2));
LTA_BSL_AVG(2,2)=mean(LTA_BSL_WK1(:,2));
LTA_BSL_AVG(3,2)=mean(LTA_BSL_WK7(:,2));

RTA_BSL_AVG=[];
RTA_BSL_AVG(1,1)=mean(RTA_BSL_CTL(:,1));
RTA_BSL_AVG(2,1)=mean(RTA_BSL_WK1(:,1));
RTA_BSL_AVG(3,1)=mean(RTA_BSL_WK7(:,1));
RTA_BSL_AVG(1,2)=mean(RTA_BSL_CTL(:,2));
RTA_BSL_AVG(2,2)=mean(RTA_BSL_WK1(:,2));
RTA_BSL_AVG(3,2)=mean(RTA_BSL_WK7(:,2));

subplot(4,2,7)
bar(LTA_BSL_AVG)
legend('pre', 'post')

subplot(4,2,8)
bar(RTA_BSL_AVG)

disp('LTA')
disp(strcat('Pre-SCI, pre=', num2str(LTA_BSL_AVG(1,1)), ',post=', num2str(LTA_BSL_AVG(1,2))))
disp(strcat('Week 1, pre=', num2str(LTA_BSL_AVG(2,1)), ',post=', num2str(LTA_BSL_AVG(2,2))))
disp(strcat('Week 7, pre=', num2str(LTA_BSL_AVG(3,1)), ',post=', num2str(LTA_BSL_AVG(3,2))))
disp('RTA')
disp(strcat('Pre-SCI, pre=', num2str(RTA_BSL_AVG(1,1)), ',post=', num2str(RTA_BSL_AVG(1,2))))
disp(strcat('Week 1, pre=', num2str(RTA_BSL_AVG(2,1)), ',post=', num2str(RTA_BSL_AVG(2,2))))
disp(strcat('Week 7, pre=', num2str(RTA_BSL_AVG(3,1)), ',post=', num2str(RTA_BSL_AVG(3,2))))
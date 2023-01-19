ID='Gi17547'
inputname=strcat('SortedData_', ID, '.mat');
load(inputname)


disp('===LTA MSD excitatory response during stance===');
temp0=[];
temp1=[];
temp3=[];
temp7=[];

for i=1:length(STANCE_LEFT.EXC(:,1))
    if STANCE_LEFT.EXC(i,1)==0
        temp0=cat(1,temp0, STANCE_LEFT.EXC(i,6));
    elseif STANCE_LEFT.EXC(i,1)==1
        temp1=cat(1,temp1, STANCE_LEFT.EXC(i,6));
    elseif STANCE_LEFT.EXC(i,1)==3
        temp3=cat(1,temp3, STANCE_LEFT.EXC(i,6));
    elseif STANCE_LEFT.EXC(i,1)==7
        temp7=cat(1,temp7, STANCE_LEFT.EXC(i,6));    
    end    
end    
%add stim during temporary stops
for i=1:length(STOP_LEFT.EXC(:,1))
    if STOP_LEFT.EXC(i,1)==0
        temp0=cat(1,temp0, STOP_LEFT.EXC(i,6));
    elseif STOP_LEFT.EXC(i,1)==1
        temp1=cat(1,temp1, STOP_LEFT.EXC(i,6));
    elseif STOP_LEFT.EXC(i,1)==3
        temp3=cat(1,temp3, STOP_LEFT.EXC(i,6));
    elseif STOP_LEFT.EXC(i,1)==7
        temp7=cat(1,temp7, STOP_LEFT.EXC(i,6));    
    end    
end 

subplot(2,2,1)
cdfplot(temp0)
hold all
cdfplot(temp1)
cdfplot(temp3)
cdfplot(temp7)
title('Stance LTA MSD')
legend('pre', 'wk1', 'wk3', 'wk7')

if isempty(temp0)==0
    if isempty(temp1)==0
        [p,h] = ranksum(temp0,temp1);
        res=strcat('Week 1 vs. Pre-SCI, p=', num2str(p));
        disp(res)  
        [h,p] = vartest2(temp0,temp1);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 1';
        disp(str)
    end    
    
    if isempty(temp3)==0
        [p,h] = ranksum(temp0,temp3);
        res=strcat('Week 3 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        [h,p] = vartest2(temp0,temp3);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 3';
        disp(str)
    end 

    if isempty(temp7)==0
        [p,h] = ranksum(temp0,temp7);
        res=strcat('Week 7 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        [h,p] = vartest2(temp0,temp7);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 7';
        disp(str)
    end 
else
    str='No data pre-SCI';
    disp(str)
end    

MUD_LTA=[];
MUD_LTA(1,1)=mean(temp0);
MUD_LTA(1,2)=std(temp0);
MUD_LTA(1,3)=100*std(temp0)/mean(temp0);
MUD_LTA(2,1)=mean(temp1);
MUD_LTA(2,2)=std(temp1);
MUD_LTA(2,3)=100*std(temp1)/mean(temp1);
MUD_LTA(3,1)=mean(temp3);
MUD_LTA(3,2)=std(temp3);
MUD_LTA(3,3)=100*std(temp3)/mean(temp3);
MUD_LTA(4,1)=mean(temp7);
MUD_LTA(4,2)=std(temp7);
MUD_LTA(4,3)=100*std(temp7)/mean(temp7);

disp('===LTA AMP excitatory response during stance===');
temp0=[];
temp1=[];
temp3=[];
temp7=[];

for i=1:length(STANCE_LEFT.EXC(:,1))
    if STANCE_LEFT.EXC(i,1)==0
        temp0=cat(1,temp0, STANCE_LEFT.EXC(i,7));
    elseif STANCE_LEFT.EXC(i,1)==1
        temp1=cat(1,temp1, STANCE_LEFT.EXC(i,7));
    elseif STANCE_LEFT.EXC(i,1)==3
        temp3=cat(1,temp3, STANCE_LEFT.EXC(i,7));
    elseif STANCE_LEFT.EXC(i,1)==7
        temp7=cat(1,temp7, STANCE_LEFT.EXC(i,7));    
    end    
end    

%add stim during stops
for i=1:length(STOP_LEFT.EXC(:,1))
    if STOP_LEFT.EXC(i,1)==0
        temp0=cat(1,temp0, STOP_LEFT.EXC(i,7));
    elseif STOP_LEFT.EXC(i,1)==1
        temp1=cat(1,temp1, STOP_LEFT.EXC(i,7));
    elseif STOP_LEFT.EXC(i,1)==3
        temp3=cat(1,temp3, STOP_LEFT.EXC(i,7));
    elseif STOP_LEFT.EXC(i,1)==7
        temp7=cat(1,temp7, STOP_LEFT.EXC(i,7));    
    end    
end 

subplot(2,2,3)
cdfplot(temp0)
hold all
cdfplot(temp1)
cdfplot(temp3)
cdfplot(temp7)
title('Stance LTA Amp')
legend('pre', 'wk1', 'wk3', 'wk7')

if isempty(temp0)==0
    if isempty(temp1)==0
        [p,h] = ranksum(temp0,temp1);
        res=strcat('Week 1 vs. Pre-SCI, p=', num2str(p));
        disp(res)  
        [h,p] = vartest2(temp0,temp1);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 1';
        disp(str)
    end    
    
    if isempty(temp3)==0
        [p,h] = ranksum(temp0,temp3);
        res=strcat('Week 3 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        [h,p] = vartest2(temp0,temp3);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 3';
        disp(str)
    end 

    if isempty(temp7)==0
        [p,h] = ranksum(temp0,temp7);
        res=strcat('Week 7 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        [h,p] = vartest2(temp0,temp7);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 7';
        disp(str)
    end 
else
    str='No data pre-SCI';
    disp(str)
end    

MUA_LTA=[];
MUA_LTA(1,1)=mean(temp0);
MUA_LTA(1,2)=std(temp0);
MUA_LTA(1,3)=100*std(temp0)/mean(temp0);
MUA_LTA(2,1)=mean(temp1);
MUA_LTA(2,2)=std(temp1);
MUA_LTA(2,3)=100*std(temp1)/mean(temp1);
MUA_LTA(3,1)=mean(temp3);
MUA_LTA(3,2)=std(temp3);
MUA_LTA(3,3)=100*std(temp3)/mean(temp3);
MUA_LTA(4,1)=mean(temp7);
MUA_LTA(4,2)=std(temp7);
MUA_LTA(4,3)=100*std(temp7)/mean(temp7);

disp('===RTA MSD excitatory response during stance===');
temp0=[];
temp1=[];
temp3=[];
temp7=[];

for i=1:length(STANCE_RIGHT.EXC(:,1))
    if STANCE_RIGHT.EXC(i,1)==0
        temp0=cat(1,temp0, STANCE_RIGHT.EXC(i,6));
    elseif STANCE_RIGHT.EXC(i,1)==1
        temp1=cat(1,temp1, STANCE_RIGHT.EXC(i,6));
    elseif STANCE_RIGHT.EXC(i,1)==3
        temp3=cat(1,temp3, STANCE_RIGHT.EXC(i,6));
    elseif STANCE_RIGHT.EXC(i,1)==7
        temp7=cat(1,temp7, STANCE_RIGHT.EXC(i,6));    
    end    
end    
%add stim during temporary stops
for i=1:length(STOP_RIGHT.EXC(:,1))
    if STOP_RIGHT.EXC(i,1)==0
        temp0=cat(1,temp0, STOP_RIGHT.EXC(i,6));
    elseif STOP_RIGHT.EXC(i,1)==1
        temp1=cat(1,temp1, STOP_RIGHT.EXC(i,6));
    elseif STOP_RIGHT.EXC(i,1)==3
        temp3=cat(1,temp3, STOP_RIGHT.EXC(i,6));
    elseif STOP_RIGHT.EXC(i,1)==7
        temp7=cat(1,temp7, STOP_RIGHT.EXC(i,6));    
    end    
end 

subplot(2,2,2)
cdfplot(temp0)
hold all
cdfplot(temp1)
cdfplot(temp3)
if isempty(temp7)==0
cdfplot(temp7)
end
title('Stance RTA MSD')
legend('pre', 'wk1', 'wk3', 'wk7')

if isempty(temp0)==0
    if isempty(temp1)==0
        [p,h] = ranksum(temp0,temp1);
        res=strcat('Week 1 vs. Pre-SCI, p=', num2str(p));
        disp(res)  
        [h,p] = vartest2(temp0,temp1);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 1';
        disp(str)
    end    
    
    if isempty(temp3)==0
        [p,h] = ranksum(temp0,temp3);
        res=strcat('Week 3 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        [h,p] = vartest2(temp0,temp3);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 3';
        disp(str)
    end 

    if isempty(temp7)==0
        [p,h] = ranksum(temp0,temp7);
        res=strcat('Week 7 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        [h,p] = vartest2(temp0,temp7);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 7';
        disp(str)
    end 
else
    str='No data pre-SCI';
    disp(str)
end    

MUD_RTA=[];
MUD_RTA(1,1)=mean(temp0);
MUD_RTA(1,2)=std(temp0);
MUD_RTA(1,3)=100*std(temp0)/mean(temp0);
MUD_RTA(2,1)=mean(temp1);
MUD_RTA(2,2)=std(temp1);
MUD_RTA(2,3)=100*std(temp1)/mean(temp1);
MUD_RTA(3,1)=mean(temp3);
MUD_RTA(3,2)=std(temp3);
MUD_RTA(3,3)=100*std(temp3)/mean(temp3);
MUD_RTA(4,1)=mean(temp7);
MUD_RTA(4,2)=std(temp7);
MUD_RTA(4,3)=100*std(temp7)/mean(temp7);

disp('===RTA AMP excitatory response during stance===');
temp0=[];
temp1=[];
temp3=[];
temp7=[];

for i=1:length(STANCE_RIGHT.EXC(:,1))
    if STANCE_RIGHT.EXC(i,1)==0
        temp0=cat(1,temp0, STANCE_RIGHT.EXC(i,7));
    elseif STANCE_RIGHT.EXC(i,1)==1
        temp1=cat(1,temp1, STANCE_RIGHT.EXC(i,7));
    elseif STANCE_RIGHT.EXC(i,1)==3
        temp3=cat(1,temp3, STANCE_RIGHT.EXC(i,7));
    elseif STANCE_RIGHT.EXC(i,1)==7
        temp7=cat(1,temp7, STANCE_RIGHT.EXC(i,7));    
    end    
end    

%add stim during stops
for i=1:length(STOP_RIGHT.EXC(:,1))
    if STOP_RIGHT.EXC(i,1)==0
        temp0=cat(1,temp0, STOP_RIGHT.EXC(i,7));
    elseif STOP_RIGHT.EXC(i,1)==1
        temp1=cat(1,temp1, STOP_RIGHT.EXC(i,7));
    elseif STOP_RIGHT.EXC(i,1)==3
        temp3=cat(1,temp3, STOP_RIGHT.EXC(i,7));
    elseif STOP_RIGHT.EXC(i,1)==7
        temp7=cat(1,temp7, STOP_RIGHT.EXC(i,7));    
    end    
end 

subplot(2,2,4)
cdfplot(temp0)
hold all
cdfplot(temp1)
cdfplot(temp3)
if isempty(temp7)==0
cdfplot(temp7)
end
title('Stance RTA Amp')
legend('pre', 'wk1', 'wk3', 'wk7')

if isempty(temp0)==0
    if isempty(temp1)==0
        [p,h] = ranksum(temp0,temp1);
        res=strcat('Week 1 vs. Pre-SCI, p=', num2str(p));
        disp(res)  
        [h,p] = vartest2(temp0,temp1);
        res=strcat('F-test, p=', num2str(p));
        disp(res)  
    else
        str='No data at week 1';
        disp(str)
    end    
    
    if isempty(temp3)==0
        [p,h] = ranksum(temp0,temp3);
        res=strcat('Week 3 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        [h,p] = vartest2(temp0,temp3);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 3';
        disp(str)
    end 

    if isempty(temp7)==0
        [p,h] = ranksum(temp0,temp7);
        res=strcat('Week 7 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        [h,p] = vartest2(temp0,temp7);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
    else
        str='No data at week 7';
        disp(str)
    end 
else
    str='No data pre-SCI';
    disp(str)
end    

MUA_RTA=[];
MUA_RTA(1,1)=mean(temp0);
MUA_RTA(1,2)=std(temp0);
MUA_RTA(1,3)=100*std(temp0)/mean(temp0);
MUA_RTA(2,1)=mean(temp1);
MUA_RTA(2,2)=std(temp1);
MUA_RTA(2,3)=100*std(temp1)/mean(temp1);
MUA_RTA(3,1)=mean(temp3);
MUA_RTA(3,2)=std(temp3);
MUA_RTA(3,3)=100*std(temp3)/mean(temp3);
MUA_RTA(4,1)=mean(temp7);
MUA_RTA(4,2)=std(temp7);
MUA_RTA(4,3)=100*std(temp7)/mean(temp7);
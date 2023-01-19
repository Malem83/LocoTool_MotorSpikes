ID='Gi17547'
inputname=strcat('SortedData_', ID, '.mat');
load(inputname)


disp('===LGL MSD inhibitory response during stance===');
temp0=[];
temp1=[];
temp3=[];
temp7=[];

for i=1:length(STANCE_LEFT.EXC(:,1))
    if STANCE_LEFT.EXC(i,1)==0 & STANCE_LEFT.EXC(i,10)<0
        temp0=cat(1,temp0, STANCE_LEFT.EXC(i,10));
    elseif STANCE_LEFT.EXC(i,1)==1 & STANCE_LEFT.EXC(i,10)<0
        temp1=cat(1,temp1, STANCE_LEFT.EXC(i,10));
    elseif STANCE_LEFT.EXC(i,1)==3 & STANCE_LEFT.EXC(i,10)<0
        temp3=cat(1,temp3, STANCE_LEFT.EXC(i,10));
    elseif STANCE_LEFT.EXC(i,1)==7 & STANCE_LEFT.EXC(i,10)<0
        temp7=cat(1,temp7, STANCE_LEFT.EXC(i,10));    
    end    
end    
%add during TA inhibition
for i=1:length(STANCE_LEFT.INH(:,1))
    if STANCE_LEFT.INH(i,1)==0 & STANCE_LEFT.INH(i,10)<0
        temp0=cat(1,temp0, STANCE_LEFT.INH(i,10));
    elseif STANCE_LEFT.INH(i,1)==1 & STANCE_LEFT.INH(i,10)<0
        temp1=cat(1,temp1, STANCE_LEFT.INH(i,10));
    elseif STANCE_LEFT.INH(i,1)==3 & STANCE_LEFT.INH(i,10)<0
        temp3=cat(1,temp3, STANCE_LEFT.INH(i,10));
    elseif STANCE_LEFT.INH(i,1)==7 & STANCE_LEFT.INH(i,10)<0
        temp7=cat(1,temp7, STANCE_LEFT.INH(i,10));    
    end    
end   
%add during TA FAILURE
for i=1:length(STANCE_LEFT.FAIL(:,1))
    if STANCE_LEFT.FAIL(i,1)==0 & STANCE_LEFT.FAIL(i,10)<0
        temp0=cat(1,temp0, STANCE_LEFT.FAIL(i,10));
    elseif STANCE_LEFT.FAIL(i,1)==1 & STANCE_LEFT.FAIL(i,10)<0
        temp1=cat(1,temp1, STANCE_LEFT.FAIL(i,10));
    elseif STANCE_LEFT.FAIL(i,1)==3 & STANCE_LEFT.FAIL(i,10)<0
        temp3=cat(1,temp3, STANCE_LEFT.FAIL(i,10));
    elseif STANCE_LEFT.FAIL(i,1)==7 & STANCE_LEFT.FAIL(i,10)<0
        temp7=cat(1,temp7, STANCE_LEFT.FAIL(i,10));    
    end    
end   
%add stim during temporary stops
for i=1:length(STOP_LEFT.EXC(:,1))
    if STOP_LEFT.EXC(i,1)==0 & STOP_LEFT.EXC(i,10)<0
        temp0=cat(1,temp0, STOP_LEFT.EXC(i,10));
    elseif STOP_LEFT.EXC(i,1)==1 & STOP_LEFT.EXC(i,10)<0
        temp1=cat(1,temp1, STOP_LEFT.EXC(i,10));
    elseif STOP_LEFT.EXC(i,1)==3 & STOP_LEFT.EXC(i,10)<0
        temp3=cat(1,temp3, STOP_LEFT.EXC(i,10));
    elseif STOP_LEFT.EXC(i,1)==7 & STOP_LEFT.EXC(i,10)<0
        temp7=cat(1,temp7, STOP_LEFT.EXC(i,10));    
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
        if length(temp0)>1 & length(temp1)>1
        [h,p] = vartest2(temp0,temp1);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 1';
        disp(str)
    end    
    
    if isempty(temp3)==0
        [p,h] = ranksum(temp0,temp3);
        res=strcat('Week 3 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        if length(temp0)>1 & length(temp3)>1
        [h,p] = vartest2(temp0,temp3);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 3';
        disp(str)
    end 

    if isempty(temp7)==0
        [p,h] = ranksum(temp0,temp7);
        res=strcat('Week 7 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        if length(temp0)>1 & length(temp7)>1
        [h,p] = vartest2(temp0,temp7);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 7';
        disp(str)
    end 
else
    str='No data pre-SCI';
    disp(str)
end        

MUD_LGL=[];
MUD_LGL(1,1)=mean(temp0);
MUD_LGL(1,2)=std(temp0);
MUD_LGL(1,3)=abs(100*std(temp0)/mean(temp0));
MUD_LGL(2,1)=mean(temp1);
MUD_LGL(2,2)=std(temp1);
MUD_LGL(2,3)=abs(100*std(temp1)/mean(temp1));
MUD_LGL(3,1)=mean(temp3);
MUD_LGL(3,2)=std(temp3);
MUD_LGL(3,3)=abs(100*std(temp3)/mean(temp3));
MUD_LGL(4,1)=mean(temp7);
MUD_LGL(4,2)=std(temp7);
MUD_LGL(4,3)=abs(100*std(temp7)/mean(temp7));

disp('===LGL AMP inhibitory response during stance===');
temp0=[];
temp1=[];
temp3=[];
temp7=[];

for i=1:length(STANCE_LEFT.EXC(:,1))
    if STANCE_LEFT.EXC(i,1)==0 & STANCE_LEFT.EXC(i,10)<0
        temp0=cat(1,temp0, STANCE_LEFT.EXC(i,11));
    elseif STANCE_LEFT.EXC(i,1)==1 & STANCE_LEFT.EXC(i,10)<0
        temp1=cat(1,temp1, STANCE_LEFT.EXC(i,11));
    elseif STANCE_LEFT.EXC(i,1)==3 & STANCE_LEFT.EXC(i,10)<0
        temp3=cat(1,temp3, STANCE_LEFT.EXC(i,11));
    elseif STANCE_LEFT.EXC(i,1)==7 & STANCE_LEFT.EXC(i,10)<0
        temp7=cat(1,temp7, STANCE_LEFT.EXC(i,11));    
    end    
end    
%add during TA inhibition
for i=1:length(STANCE_LEFT.INH(:,1))
    if STANCE_LEFT.INH(i,1)==0 & STANCE_LEFT.INH(i,10)<0
        temp0=cat(1,temp0, STANCE_LEFT.INH(i,11));
    elseif STANCE_LEFT.INH(i,1)==1 & STANCE_LEFT.INH(i,10)<0
        temp1=cat(1,temp1, STANCE_LEFT.INH(i,11));
    elseif STANCE_LEFT.INH(i,1)==3 & STANCE_LEFT.INH(i,10)<0
        temp3=cat(1,temp3, STANCE_LEFT.INH(i,11));
    elseif STANCE_LEFT.INH(i,1)==7 & STANCE_LEFT.INH(i,10)<0
        temp7=cat(1,temp7, STANCE_LEFT.INH(i,11));    
    end    
end   
%add during TA FAILURE
for i=1:length(STANCE_LEFT.FAIL(:,1))
    if STANCE_LEFT.FAIL(i,1)==0 & STANCE_LEFT.FAIL(i,10)<0
        temp0=cat(1,temp0, STANCE_LEFT.FAIL(i,11));
    elseif STANCE_LEFT.FAIL(i,1)==1 & STANCE_LEFT.FAIL(i,10)<0
        temp1=cat(1,temp1, STANCE_LEFT.FAIL(i,11));
    elseif STANCE_LEFT.FAIL(i,1)==3 & STANCE_LEFT.FAIL(i,10)<0
        temp3=cat(1,temp3, STANCE_LEFT.FAIL(i,11));
    elseif STANCE_LEFT.FAIL(i,1)==7 & STANCE_LEFT.FAIL(i,10)<0
        temp7=cat(1,temp7, STANCE_LEFT.FAIL(i,11));    
    end    
end   
%add stim during temporary stops
for i=1:length(STOP_LEFT.EXC(:,1))
    if STOP_LEFT.EXC(i,1)==0 & STOP_LEFT.EXC(i,10)<0
        temp0=cat(1,temp0, STOP_LEFT.EXC(i,11));
    elseif STOP_LEFT.EXC(i,1)==1 & STOP_LEFT.EXC(i,10)<0
        temp1=cat(1,temp1, STOP_LEFT.EXC(i,11));
    elseif STOP_LEFT.EXC(i,1)==3 & STOP_LEFT.EXC(i,10)<0
        temp3=cat(1,temp3, STOP_LEFT.EXC(i,11));
    elseif STOP_LEFT.EXC(i,1)==7 & STOP_LEFT.EXC(i,10)<0
        temp7=cat(1,temp7, STOP_LEFT.EXC(i,11));    
    end    
end 

subplot(2,2,3)
cdfplot(temp0)
hold all
cdfplot(temp1)
cdfplot(temp3)
cdfplot(temp7)
title('Stance LGL Amp')
legend('pre', 'wk1', 'wk3', 'wk7')

if isempty(temp0)==0
    if isempty(temp1)==0 
        [p,h] = ranksum(temp0,temp1);
        res=strcat('Week 1 vs. Pre-SCI, p=', num2str(p));
        disp(res)  
        if length(temp0)>1 & length(temp1)>1
        [h,p] = vartest2(temp0,temp1);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 1';
        disp(str)
    end    
    
    if isempty(temp3)==0
        [p,h] = ranksum(temp0,temp3);
        res=strcat('Week 3 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        if length(temp0)>1 & length(temp3)>1
        [h,p] = vartest2(temp0,temp3);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 3';
        disp(str)
    end 

    if isempty(temp7)==0
        [p,h] = ranksum(temp0,temp7);
        res=strcat('Week 7 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        if length(temp0)>1 & length(temp7)>1
        [h,p] = vartest2(temp0,temp7);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 7';
        disp(str)
    end 
else
    str='No data pre-SCI';
    disp(str)
end        

MUA_LGL=[];
MUA_LGL(1,1)=mean(temp0);
MUA_LGL(1,2)=std(temp0);
MUA_LGL(1,3)=abs(100*std(temp0)/mean(temp0));
MUA_LGL(2,1)=mean(temp1);
MUA_LGL(2,2)=std(temp1);
MUA_LGL(2,3)=abs(100*std(temp1)/mean(temp1));
MUA_LGL(3,1)=mean(temp3);
MUA_LGL(3,2)=std(temp3);
MUA_LGL(3,3)=abs(100*std(temp3)/mean(temp3));
MUA_LGL(4,1)=mean(temp7);
MUA_LGL(4,2)=std(temp7);
MUA_LGL(4,3)=abs(100*std(temp7)/mean(temp7));

disp('===RGL MSD inhibitory response during stance===');
temp0=[];
temp1=[];
temp3=[];
temp7=[];

for i=1:length(STANCE_RIGHT.EXC(:,1))
    if STANCE_RIGHT.EXC(i,1)==0 & STANCE_RIGHT.EXC(i,10)<0
        temp0=cat(1,temp0, STANCE_RIGHT.EXC(i,10));
    elseif STANCE_RIGHT.EXC(i,1)==1 & STANCE_RIGHT.EXC(i,10)<0
        temp1=cat(1,temp1, STANCE_RIGHT.EXC(i,10));
    elseif STANCE_RIGHT.EXC(i,1)==3 & STANCE_RIGHT.EXC(i,10)<0
        temp3=cat(1,temp3, STANCE_RIGHT.EXC(i,10));
    elseif STANCE_RIGHT.EXC(i,1)==7 & STANCE_RIGHT.EXC(i,10)<0
        temp7=cat(1,temp7, STANCE_RIGHT.EXC(i,10));    
    end    
end    
%add during TA inhibition
for i=1:length(STANCE_RIGHT.INH(:,1))
    if STANCE_RIGHT.INH(i,1)==0 & STANCE_RIGHT.INH(i,10)<0
        temp0=cat(1,temp0, STANCE_RIGHT.INH(i,10));
    elseif STANCE_RIGHT.INH(i,1)==1 & STANCE_RIGHT.INH(i,10)<0
        temp1=cat(1,temp1, STANCE_RIGHT.INH(i,10));
    elseif STANCE_RIGHT.INH(i,1)==3 & STANCE_RIGHT.INH(i,10)<0
        temp3=cat(1,temp3, STANCE_RIGHT.INH(i,10));
    elseif STANCE_RIGHT.INH(i,1)==7 & STANCE_RIGHT.INH(i,10)<0
        temp7=cat(1,temp7, STANCE_RIGHT.INH(i,10));    
    end    
end   
%add during TA FAILURE
if isempty(STANCE_RIGHT.FAIL)==0
for i=1:length(STANCE_RIGHT.FAIL(:,1))
    if STANCE_RIGHT.FAIL(i,1)==0 & STANCE_RIGHT.FAIL(i,10)<0
        temp0=cat(1,temp0, STANCE_RIGHT.FAIL(i,10));
    elseif STANCE_RIGHT.FAIL(i,1)==1 & STANCE_RIGHT.FAIL(i,10)<0
        temp1=cat(1,temp1, STANCE_RIGHT.FAIL(i,10));
    elseif STANCE_RIGHT.FAIL(i,1)==3 & STANCE_RIGHT.FAIL(i,10)<0
        temp3=cat(1,temp3, STANCE_RIGHT.FAIL(i,10));
    elseif STANCE_RIGHT.FAIL(i,1)==7 & STANCE_RIGHT.FAIL(i,10)<0
        temp7=cat(1,temp7, STANCE_RIGHT.FAIL(i,10));    
    end    
end   
end
%add stim during temporary stops
for i=1:length(STOP_RIGHT.EXC(:,1))
    if STOP_RIGHT.EXC(i,1)==0 & STOP_RIGHT.EXC(i,10)<0
        temp0=cat(1,temp0, STOP_RIGHT.EXC(i,10));
    elseif STOP_RIGHT.EXC(i,1)==1 & STOP_RIGHT.EXC(i,10)<0
        temp1=cat(1,temp1, STOP_RIGHT.EXC(i,10));
    elseif STOP_RIGHT.EXC(i,1)==3 & STOP_RIGHT.EXC(i,10)<0
        temp3=cat(1,temp3, STOP_RIGHT.EXC(i,10));
    elseif STOP_RIGHT.EXC(i,1)==7 & STOP_RIGHT.EXC(i,10)<0
        temp7=cat(1,temp7, STOP_RIGHT.EXC(i,10));    
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
title('Stance RGL MSD')
legend('pre', 'wk1', 'wk3', 'wk7')

if isempty(temp0)==0
    if isempty(temp1)==0 
        [p,h] = ranksum(temp0,temp1);
        res=strcat('Week 1 vs. Pre-SCI, p=', num2str(p));
        disp(res)  
        if length(temp0)>1 & length(temp1)>1
        [h,p] = vartest2(temp0,temp1);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 1';
        disp(str)
    end    
    
    if isempty(temp3)==0
        [p,h] = ranksum(temp0,temp3);
        res=strcat('Week 3 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        if length(temp0)>1 & length(temp3)>1
        [h,p] = vartest2(temp0,temp3);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 3';
        disp(str)
    end 

    if isempty(temp7)==0
        [p,h] = ranksum(temp0,temp7);
        res=strcat('Week 7 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        if length(temp0)>1 & length(temp7)>1
        [h,p] = vartest2(temp0,temp7);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 7';
        disp(str)
    end 
else
    str='No data pre-SCI';
    disp(str)
end        

MUD_RGL=[];
MUD_RGL(1,1)=mean(temp0);
MUD_RGL(1,2)=std(temp0);
MUD_RGL(1,3)=abs(100*std(temp0)/mean(temp0));
MUD_RGL(2,1)=mean(temp1);
MUD_RGL(2,2)=std(temp1);
MUD_RGL(2,3)=abs(100*std(temp1)/mean(temp1));
MUD_RGL(3,1)=mean(temp3);
MUD_RGL(3,2)=std(temp3);
MUD_RGL(3,3)=abs(100*std(temp3)/mean(temp3));
MUD_RGL(4,1)=mean(temp7);
MUD_RGL(4,2)=std(temp7);
MUD_RGL(4,3)=abs(100*std(temp7)/mean(temp7));

disp('===RGL AMP inhibitory response during stance===');
temp0=[];
temp1=[];
temp3=[];
temp7=[];

for i=1:length(STANCE_RIGHT.EXC(:,1))
    if STANCE_RIGHT.EXC(i,1)==0 & STANCE_RIGHT.EXC(i,10)<0
        temp0=cat(1,temp0, STANCE_RIGHT.EXC(i,11));
    elseif STANCE_RIGHT.EXC(i,1)==1 & STANCE_RIGHT.EXC(i,10)<0
        temp1=cat(1,temp1, STANCE_RIGHT.EXC(i,11));
    elseif STANCE_RIGHT.EXC(i,1)==3 & STANCE_RIGHT.EXC(i,10)<0
        temp3=cat(1,temp3, STANCE_RIGHT.EXC(i,11));
    elseif STANCE_RIGHT.EXC(i,1)==7 & STANCE_RIGHT.EXC(i,10)<0
        temp7=cat(1,temp7, STANCE_RIGHT.EXC(i,11));    
    end    
end    
%add during TA inhibition
for i=1:length(STANCE_RIGHT.INH(:,1))
    if STANCE_RIGHT.INH(i,1)==0 & STANCE_RIGHT.INH(i,10)<0
        temp0=cat(1,temp0, STANCE_RIGHT.INH(i,11));
    elseif STANCE_RIGHT.INH(i,1)==1 & STANCE_RIGHT.INH(i,10)<0
        temp1=cat(1,temp1, STANCE_RIGHT.INH(i,11));
    elseif STANCE_RIGHT.INH(i,1)==3 & STANCE_RIGHT.INH(i,10)<0
        temp3=cat(1,temp3, STANCE_RIGHT.INH(i,11));
    elseif STANCE_RIGHT.INH(i,1)==7 & STANCE_RIGHT.INH(i,10)<0
        temp7=cat(1,temp7, STANCE_RIGHT.INH(i,11));    
    end    
end   
%add during TA FAILURE
if isempty(STANCE_RIGHT.FAIL)==0
for i=1:length(STANCE_RIGHT.FAIL(:,1))
    if STANCE_RIGHT.FAIL(i,1)==0 & STANCE_RIGHT.FAIL(i,10)<0
        temp0=cat(1,temp0, STANCE_RIGHT.FAIL(i,11));
    elseif STANCE_RIGHT.FAIL(i,1)==1 & STANCE_RIGHT.FAIL(i,10)<0
        temp1=cat(1,temp1, STANCE_RIGHT.FAIL(i,11));
    elseif STANCE_RIGHT.FAIL(i,1)==3 & STANCE_RIGHT.FAIL(i,10)<0
        temp3=cat(1,temp3, STANCE_RIGHT.FAIL(i,11));
    elseif STANCE_RIGHT.FAIL(i,1)==7 & STANCE_RIGHT.FAIL(i,10)<0
        temp7=cat(1,temp7, STANCE_RIGHT.FAIL(i,11));    
    end    
end   
end
%add stim during temporary stops
for i=1:length(STOP_RIGHT.EXC(:,1))
    if STOP_RIGHT.EXC(i,1)==0 & STOP_RIGHT.EXC(i,10)<0
        temp0=cat(1,temp0, STOP_RIGHT.EXC(i,11));
    elseif STOP_RIGHT.EXC(i,1)==1 & STOP_RIGHT.EXC(i,10)<0
        temp1=cat(1,temp1, STOP_RIGHT.EXC(i,11));
    elseif STOP_RIGHT.EXC(i,1)==3 & STOP_RIGHT.EXC(i,10)<0
        temp3=cat(1,temp3, STOP_RIGHT.EXC(i,11));
    elseif STOP_RIGHT.EXC(i,1)==7 & STOP_RIGHT.EXC(i,10)<0
        temp7=cat(1,temp7, STOP_RIGHT.EXC(i,11));    
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
title('Stance RGL Amp')
legend('pre', 'wk1', 'wk3', 'wk7')

if isempty(temp0)==0
    if isempty(temp1)==0 
        [p,h] = ranksum(temp0,temp1);
        res=strcat('Week 1 vs. Pre-SCI, p=', num2str(p));
        disp(res)  
        if length(temp0)>1 & length(temp1)>1
        [h,p] = vartest2(temp0,temp1);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 1';
        disp(str)
    end    
    
    if isempty(temp3)==0
        [p,h] = ranksum(temp0,temp3);
        res=strcat('Week 3 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        if length(temp0)>1 & length(temp3)>1
        [h,p] = vartest2(temp0,temp3);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 3';
        disp(str)
    end 

    if isempty(temp7)==0
        [p,h] = ranksum(temp0,temp7);
        res=strcat('Week 7 vs. Pre-SCI, p=', num2str(p));
        disp(res)
        if length(temp0)>1 & length(temp7)>1
        [h,p] = vartest2(temp0,temp7);
        res=strcat('F-test, p=', num2str(p));
        disp(res) 
        end
    else
        str='No data at week 7';
        disp(str)
    end 
else
    str='No data pre-SCI';
    disp(str)
end        

MUA_RGL=[];
MUA_RGL(1,1)=mean(temp0);
MUA_RGL(1,2)=std(temp0);
MUA_RGL(1,3)=abs(100*std(temp0)/mean(temp0));
MUA_RGL(2,1)=mean(temp1);
MUA_RGL(2,2)=std(temp1);
MUA_RGL(2,3)=abs(100*std(temp1)/mean(temp1));
MUA_RGL(3,1)=mean(temp3);
MUA_RGL(3,2)=std(temp3);
MUA_RGL(3,3)=abs(100*std(temp3)/mean(temp3));
MUA_RGL(4,1)=mean(temp7);
MUA_RGL(4,2)=std(temp7);
MUA_RGL(4,3)=abs(00*std(temp7)/mean(temp7));
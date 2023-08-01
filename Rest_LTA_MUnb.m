dblist=dir('Database_*.mat')

Data_Succ=zeros(length(dblist), 3);
Data_MUnb=zeros(length(dblist), 3);
Data_pval=zeros(length(dblist), 2);
dblist2=[];
for i=1:length(dblist)
    dblist2(i).ID=str2num(dblist(i).name(10:14));
    load(dblist(i).name);
    for j=1:length(MotorSynth)
        temp=[];
        cnt=1;
        for k=1:length(MotorSynth(j).LTAMUnb(:,1))
        if MotorSynth(j).LTAMUnb(k,1)>0
            Data_Succ(i,j)=Data_Succ(i,j)+1;
            temp(cnt)=MotorSynth(j).LTAMUnb(k,1);
            cnt=cnt+1;
        end    
        end
        Data_Succ(i,j)=100*Data_Succ(i,j)/length(MotorSynth(j).LTAMUnb(:,1));
        Data_MUnb(i,j)=median(temp);
    end   

    %%stats vs. pre-SCI
    Data_pval(i,1)=ranksum(MotorSynth(1).LTAMUnb,MotorSynth(2).LTAMUnb);
    Data_pval(i,2)=ranksum(MotorSynth(1).LTAMUnb,MotorSynth(3).LTAMUnb);
end   
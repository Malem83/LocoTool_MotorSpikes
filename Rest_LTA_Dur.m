dblist=dir('Database_*.mat')

Data_Succ=zeros(length(dblist), 3);
Data_Dur=zeros(length(dblist), 3);
Data_pval=zeros(length(dblist), 2);

for i=1:length(dblist)
    load(dblist(i).name);
    for j=1:length(MotorSynth)
        temp=[];
        cnt=1;
        for k=1:length(MotorSynth(j).LTAdur(:,1))
        if MotorSynth(j).LTAdur(k,1)>0
            Data_Succ(i,j)=Data_Succ(i,j)+1;
            temp(cnt)=MotorSynth(j).LTAdur(k,1);
            cnt=cnt+1;
        end    
        end
        Data_Succ(i,j)=100*Data_Succ(i,j)/length(MotorSynth(j).LTAdur(:,1));
        Data_Dur(i,j)=1000*mean(temp);
    end   

    %%stats vs. pre-SCI
    Data_pval(i,1)=ranksum(MotorSynth(1).LTAdur,MotorSynth(2).LTAdur);
    Data_pval(i,2)=ranksum(MotorSynth(1).LTAdur,MotorSynth(3).LTAdur);
end   
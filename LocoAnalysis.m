outname='Gi17547';
outname2=strcat(outname, '_stimtb.mat');
%%last update october 21, 2020
nbpulse=1;

%check the directory, count nb of file
datalist=dir;
nbfile=length(datalist);
nbelem=0;
LocoSynth=[];

%read directory. How many file do we have? create a database.
for a=1:nbfile
    if datalist(a).isdir == 0    
        if length(datalist(a).name)== 33
        b=datalist(a).name(13:16);
        c=datalist(a).name(30:33);
        if b == 'loco' & c == '.mat'
            nbelem=nbelem+1;
            LocoSynth(nbelem).nucleus=datalist(a).name(1:2);
            LocoSynth(nbelem).ID=datalist(a).name(3:7);
            LocoSynth(nbelem).time=datalist(a).name(9:11);
            LocoSynth(nbelem).intensity=datalist(a).name(21:22);
            LocoSynth(nbelem).duration=datalist(a).name(27:29);
        end
        end
    end    
end

%extract timebases for stim and motor units
for b=1:nbelem
    %set the name and load file #b
    tempname=strcat(LocoSynth(b).nucleus, LocoSynth(b).ID, '_', LocoSynth(b).time, '_loco_int', LocoSynth(b).intensity, '_dur', LocoSynth(b).duration, '.mat');
    load(tempname);
    twin=ceil(0.001/(RTA.interval));
    
    %stimulation timebase
    cnt=1;
    for i=1:2:length(stim.times)
       LocoSynth(b).cycstim(cnt,1)=stim.times(i);
       cnt=cnt+1;
    end  
    
    %RTA unit timing and amplitude
    cnt=1;    
    spktim=0;
    for j=1:length(RTA_units.times)
        spktim=1+floor(RTA_units.times(j)/RTA.interval);
        LocoSynth(b).RTAunit(cnt,1)=RTA_units.times(j);
        LocoSynth(b).RTAunit(cnt,2)=min(RTA.values(spktim:spktim+twin,1));
        cnt=cnt+1;
    end    
    %RGL unit timing and amplitude
    cnt=1;    
    spktim=0;
    for j=1:length(RGL_units.times)
        spktim=1+floor(RGL_units.times(j)/RGL.interval);
        LocoSynth(b).RGLunit(cnt,1)=RGL_units.times(j);
        LocoSynth(b).RGLunit(cnt,2)=min(RGL.values(spktim:spktim+twin,1));
        cnt=cnt+1;
    end
    %LTA unit timing and amplitude
    cnt=1;    
    spktim=0;
    for j=1:length(LTA_units.times)
        spktim=1+floor(LTA_units.times(j)/LTA.interval);
        LocoSynth(b).LTAunit(cnt,1)=LTA_units.times(j);
        LocoSynth(b).LTAunit(cnt,2)=min(LTA.values(spktim:spktim+twin,1));
        cnt=cnt+1;
    end   
    %LGL unit timing and amplitude
    cnt=1;    
    spktim=0;
    for j=1:length(LGL_units.times)
        spktim=1+floor(LGL_units.times(j)/LGL.interval);
        LocoSynth(b).LGLunit(cnt,1)=LGL_units.times(j);
        LocoSynth(b).LGLunit(cnt,2)=min(LGL.values(spktim:spktim+twin,1));
        cnt=cnt+1;
    end   
end

save(outname2, 'LocoSynth')
disp('Timebases are saved.')




clear all
clc
clear
close all




SO_dir='OUT/HN_SO/';
Spindle_dir='OUT/HN_spindle/';
Out_dir='OUT/HN_SO_coupled/';


files_temp=dir([Spindle_dir '*.mat']);
files={};
for F = 1:length(files_temp)
    files{F}=strrep(files_temp(F).name,'_spindle.mat','');
end

for F=1:length(files)
    load([SO_dir files{F} '_SO.mat'])
    load([Spindle_dir files{F}  '_spindle.mat'])

    SO_IsSpindelCoupled_S2={};
    SO_IsSpindelCoupled_S3={};
    Coupled_ratio_S2=[];
    Coupled_ratio_S3=[];
    Coupled_Density_S2=[];
    Coupled_Density_S3=[];
    UnCoupled_Density_S2=[];
    UnCoupled_Density_S3=[];
    Coupled_N_S2=[];
    Coupled_N_S3=[];
    UnCoupled_N_S2=[];
    UnCoupled_N_S3=[];

    density_S2=cell2mat(density_S2);
    density_S3=cell2mat(density_S3);
    if isempty(density_S3)
        density_S3(1:8)=0;
    end
    if isempty(density_S2)
        density_S2(1:8)=0;
    end


    for CH=1:8
        try 
            A=spindle_intrv_stg2{CH};
        catch
            A=[];
        end

        try 
            B=spindle_intrv_stg3{CH};
        catch
            B=[];
        end

        Spindle_times=[A; B];

        try
            SO=events_slow_S2{CH};
        catch
            SO=[];
        end
        SO_IsSpindelCoupled_S2{CH}=[];
        for i=1:size(SO,1)
            SO_IsSpindelCoupled_S2{CH}(i)=sum(mean(Spindle_times,2)>SO(i,1)   &  mean(Spindle_times,2)<SO(i,2))>0;
        end



        try
            SO=events_slow_S3{CH};
        catch
            spin=[];
        end
        SO_IsSpindelCoupled_S3{CH}=[];
        for i=1:size(SO,1)
            SO_IsSpindelCoupled_S3{CH}(i)=sum(mean(Spindle_times,2)>SO(i,1)   &  mean(Spindle_times,2)<SO(i,2))>0;
        end



        Coupled_ratio_S2(CH)=sum(SO_IsSpindelCoupled_S2{CH})/length(SO_IsSpindelCoupled_S2{CH});
        Coupled_ratio_S3(CH)=sum(SO_IsSpindelCoupled_S3{CH})/length(SO_IsSpindelCoupled_S3{CH});





        Coupled_Density_S2(CH)=Coupled_ratio_S2(CH)*density_S2(CH);
        Coupled_Density_S3(CH)=Coupled_ratio_S3(CH)*density_S3(CH);

        UnCoupled_Density_S2(CH)=(1-Coupled_ratio_S2(CH))*density_S2(CH);
        UnCoupled_Density_S3(CH)=(1-Coupled_ratio_S3(CH))*density_S3(CH);

        Coupled_N_S2(CH)=sum(SO_IsSpindelCoupled_S2{CH});
        Coupled_N_S3(CH)=sum(SO_IsSpindelCoupled_S3{CH});

        UnCoupled_N_S2(CH)=sum(not(SO_IsSpindelCoupled_S2{CH}));
        UnCoupled_N_S3(CH)=sum(not(SO_IsSpindelCoupled_S3{CH}));

    end



    save([Out_dir files{F} '_Coupling_info.mat'],...
        'SO_IsSpindelCoupled_S2','SO_IsSpindelCoupled_S3',...
        'Coupled_ratio_S2','Coupled_ratio_S3',...
        'Coupled_Density_S2','Coupled_Density_S3',...
        'UnCoupled_Density_S2','UnCoupled_Density_S3',...
        'Coupled_N_S2','Coupled_N_S3',...
        'UnCoupled_N_S2','UnCoupled_N_S3')


end
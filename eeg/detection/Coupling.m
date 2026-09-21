clc
clear
close all




SO_dir='OUT/SO/';
Spindle_dir='OUT/spindle/';
Out_dir='OUT/coupled/';


files_temp=dir([Spindle_dir '*.mat']);
files={};
for F = 1:length(files_temp)
    files{F}=strrep(files_temp(F).name,'_spindle.mat','');
end

for F=1:length(files)
    load([SO_dir files{F} '_SO.mat'])
    load([Spindle_dir files{F}  '_spindle.mat'])

    Spindel_IsSOCoupled_S2={};
    Spindel_IsSOCoupled_S3={};
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

    for CH=1:8
        SO_times=[events_slow_S2{CH}(:,[1 3]); events_slow_S3{CH}(:,[1 3])];

        try
            spin=spindle_intrv_stg2{CH};
            Spindel_IsSOCoupled_S2{CH}=[];
        catch
            spin=[];
        end
        for i=1:size(spin,1)
            Spindel_IsSOCoupled_S2{CH}(i)=sum(SO_times(:,1)<=mean(spin(i,:)) & SO_times(:,2)>=mean(spin(i,:)) )>0;
        end
        try
            spin=spindle_intrv_stg3{CH};

        catch
            spin=[];
        end
        Spindel_IsSOCoupled_S3{CH}=[];
        for i=1:size(spin,1)
            Spindel_IsSOCoupled_S3{CH}(i)=sum(SO_times(:,1)<=mean(spin(i,:)) & SO_times(:,2)>=mean(spin(i,:)) )>0;
        end

        Coupled_ratio_S2(CH)=sum(Spindel_IsSOCoupled_S2{CH})/length(Spindel_IsSOCoupled_S2{CH});
        Coupled_ratio_S3(CH)=sum(Spindel_IsSOCoupled_S3{CH})/length(Spindel_IsSOCoupled_S3{CH});
        
        if isempty(spDns_stg3)
            spDns_stg3(1:8)=0;
        end
        if isempty(spDns_stg2)
            spDns_stg2(1:8)=0;
        end

        Coupled_Density_S2(CH)=Coupled_ratio_S2(CH)*spDns_stg2(CH);
        Coupled_Density_S3(CH)=Coupled_ratio_S3(CH)*spDns_stg3(CH);

        UnCoupled_Density_S2(CH)=(1-Coupled_ratio_S2(CH))*spDns_stg2(CH);
        UnCoupled_Density_S3(CH)=(1-Coupled_ratio_S3(CH))*spDns_stg3(CH);

        Coupled_N_S2(CH)=sum(Spindel_IsSOCoupled_S2{CH});
        Coupled_N_S3(CH)=sum(Spindel_IsSOCoupled_S3{CH});

        UnCoupled_N_S2(CH)=sum(not(Spindel_IsSOCoupled_S2{CH}));
        UnCoupled_N_S3(CH)=sum(not(Spindel_IsSOCoupled_S3{CH}));

    end



    save([Out_dir files{F} '_Coupling_info.mat'],...
        'Spindel_IsSOCoupled_S2','Spindel_IsSOCoupled_S3',...
        'Coupled_ratio_S2','Coupled_ratio_S3',...
        'duration_stage_S2','duration_stage_S3',...
        'Coupled_Density_S2','Coupled_Density_S3',...
        'UnCoupled_Density_S2','UnCoupled_Density_S3',...
        'Coupled_N_S2','Coupled_N_S3',...
        'UnCoupled_N_S2','UnCoupled_N_S3')


end
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
%cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/os_behavioral_regression/ospan_vs_math_load/allsub/
cmd = ['fslmerge -t group_am-pm_ospan_vs_math_load_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_am-pm_ospan_vs_math_load.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)


%V1only
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
%cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/os_behavioral_regression/ospan_vs_math_load/allsub/
cmd = ['fslmerge -t group_am-pm_ospan_vs_math_load_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/';

n=0
for iss = 1:39%:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    i_ses = sessions(1);
    if i_ses ==1
        disp(['v1_' ss])
        cmd = [cmd PathToData 'v1_' ss '_am-pm_ospan_vs_math_load.nii.gz '];
        n=n+1;
    end
end
unix(cmd)

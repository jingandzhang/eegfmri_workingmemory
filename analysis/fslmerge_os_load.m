clear
%%%%%%%%%%%%%%
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/
cmd = ['fslmerge -t group_am-pm_ospan_vs_math_load_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/';

n=0
for iss = 3:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:2:end)/2
        cmd = [cmd PathToData  ss '_am-pm_ospan_vs_math_load.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)

%%%%%%%%%% V1 only
%%%%ospan vs math/ am-pm
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/v1only
cmd = ['fslmerge -t group_am-pm_ospan_vs_math_load_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/';

n=0
for iss = 3:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_am-pm_ospan_vs_math_load.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
unix(cmd)
cmd2 = 'fslmaths group_am-pm_ospan_vs_math_load_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/v1only/negative/group_am-pm_ospan_vs_math_load_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/v1only/group_am-pm_ospan_vs_math_load_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/v1only/positive/group_am-pm_ospan_vs_math_load_v1only_pos.nii.gz

%%%%
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/complete2v
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/complete2v/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/complete2v/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/complete2v
cmd = ['fslmerge -t group_am-pm_ospan_vs_math_load_complete2v '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/';

n=0
for iss = 3:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)==4
            cmd = [cmd PathToData ss '_am-pm_ospan_vs_math_load.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_am-pm_ospan_vs_math_load_complete2v.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/complete2v/negative/group_am-pm_ospan_vs_math_load_complete2v_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/complete2v/group_am-pm_ospan_vs_math_load_complete2v.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/complete2v/positive/group_am-pm_ospan_vs_math_load_complete2v_pos.nii.gz

%%%allsub
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/allsub
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/allsub/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/allsub/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/allsub
cmd = ['fslmerge -t group_am-pm_ospan_vs_math_load_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/';

n=0
for iss = 3:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)>=2
            cmd = [cmd PathToData ss '_am-pm_ospan_vs_math_load.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_am-pm_ospan_vs_math_load_allsub.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/allsub/negative/group_am-pm_ospan_vs_math_load_allsub_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/allsub/group_am-pm_ospan_vs_math_load_allsub.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/am-pm/allsub/positive/group_am-pm_ospan_vs_math_load_allsub_pos.nii.gz



%%%%ospan vs math/ allsession
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/v1only
cmd = ['fslmerge -t group_allsessions_ospan_vs_math_load_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/';

n=0
for iss = 3:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:2:end)
        if sessions(1)==1
            cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_allsessions_ospan_vs_math_load.nii.gz '];
            disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_ospan_vs_math_load_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/v1only/negative/group_allsessions_ospan_vs_math_load_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/v1only/group_allsessions_ospan_vs_math_load_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/v1only/positive/group_allsessions_ospan_vs_math_load_v1only_pos.nii.gz

%%%v1v2
%%%%ospan vs math/ allsession
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/complete2v
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/complete2v/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/complete2v/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/complete2v
cmd = ['fslmerge -t group_allsessions_ospan_vs_math_load_complete2v '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/';

n=0
for iss = 3:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)==4
            cmd = [cmd PathToData ss '_allsessions_ospan_vs_math_load.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_ospan_vs_math_load_complete2v.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/complete2v/negative/group_allsessions_ospan_vs_math_load_complete2v_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/complete2v/group_allsessions_ospan_vs_math_load_complete2v.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/complete2v/positive/group_allsessions_ospan_vs_math_load_complete2v_pos.nii.gz

%%%allsub
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub
cmd = ['fslmerge -t group_allsessions_ospan_vs_math_load_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/';

n=0
for iss = 3:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)>=2
            cmd = [cmd PathToData ss '_allsessions_ospan_vs_math_load.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_ospan_vs_math_load_allsub.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/negative/group_allsessions_ospan_vs_math_load_allsub_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/group_allsessions_ospan_vs_math_load_allsub.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/positive/group_allsessions_ospan_vs_math_load_allsub_pos.nii.gz

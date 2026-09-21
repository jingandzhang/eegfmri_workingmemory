%%%%%%%%%% V1 only
%%%%ospan vs math/ am-pm
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only
cmd = ['fslmerge -t group_am-pm_math_vs_baseline_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses =1% sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_am-pm_math_vs_baseline.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
cmd2 = 'fslmaths group_am-pm_math_vs_baseline_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/negative/group_am-pm_math_vs_baseline_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/group_am-pm_math_vs_baseline_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/positive/group_am-pm_math_vs_baseline_v1only_pos.nii.gz
clear all

%%%% complete2v
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v
cmd = ['fslmerge -t group_am-pm_math_vs_baseline_complete2v '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)==4
            cmd = [cmd PathToData ss '_am-pm_math_vs_baseline.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_am-pm_math_vs_baseline_complete2v.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v/negative/group_am-pm_math_vs_baseline_complete2v_neg.nii'
unix(cmd2)

copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v/group_am-pm_math_vs_baseline_complete2v.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/positive/group_am-pm_math_vs_baseline_complete2v_pos.nii.gz

clear all

%%%allsub
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub
cmd = ['fslmerge -t group_am-pm_math_vs_baseline_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)>=2
            cmd = [cmd PathToData ss '_am-pm_math_vs_baseline.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_am-pm_math_vs_baseline_allsub.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/negative/group_am-pm_math_vs_baseline_allsub_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/group_am-pm_math_vs_baseline_allsub.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/positive/group_am-pm_math_vs_baseline_allsub_pos.nii.gz
clear all


%%%%ospan vs math/ allsession
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/allsessions/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/allsessions/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/allsessions/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/allsessions/v1only
cmd = ['fslmerge -t group_allsessions_ret_vs_baseline_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_base/';

n=0
for iss = 1:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1
            cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_allsessions_ret_vs_baseline.nii.gz '];
            disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_math_vs_baseline_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only/negative/group_allsessions_math_vs_baseline_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only/group_allsessions_math_vs_baseline_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only/positive/group_allsessions_math_vs_baseline_v1only_pos.nii.gz
clear all

%%%v1v2
%%%%ospan vs math/ allsession
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v
cmd = ['fslmerge -t group_allsessions_math_vs_baseline_complete2v '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)==4
            cmd = [cmd PathToData ss '_allsessions_math_vs_baseline.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_math_vs_baseline_complete2v.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/negative/group_allsessions_math_vs_baseline_complete2v_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/group_allsessions_math_vs_baseline_complete2v.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/positive/group_allsessions_math_vs_baseline_complete2v_pos.nii.gz
clear all

%%%allsub
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub
cmd = ['fslmerge -t group_allsessions_math_vs_baseline_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)>=2
            cmd = [cmd PathToData ss '_allsessions_math_vs_baseline.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_math_vs_baseline_allsub.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/negative/group_allsessions_math_vs_baseline_allsub_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/group_allsessions_math_vs_baseline_allsub.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/positive/group_allsessions_math_vs_baseline
clear all


%%%%ospan vs math/ 
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/v1only
cmd = ['fslmerge -t group_pmaverage_math_vs_baseline_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:2:end)
        if sessions(1)==1 & length(sessions)==2
            cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_pmaverage_math_vs_baseline.nii.gz '];
            disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_pmaverage_math_vs_baseline_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/v1only/negative/group_pmaverage_math_vs_baseline_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/v1only/group_pmaverage_math_vs_baseline_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/v1only/positive/group_pmaverage_math_vs_baseline_v1only_pos.nii.gz

clear all

%%%v1v2
%%%%ospan vs math/ allsession
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v
cmd = ['fslmerge -t group_pmaverage_math_vs_baseline_complete2v '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)==4
            cmd = [cmd PathToData ss '_pmaverage_math_vs_baseline.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_pmaverage_math_vs_baseline_complete2v.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/negative/group_pmaverage_math_vs_baseline_complete2v_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/group_pmaverage_math_vs_baseline_complete2v.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/positive/group_pmaverage_math_vs_baseline_complete2v_pos.nii.gz
clear all

%%%allsub
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub
cmd = ['fslmerge -t group_pmaverage_math_vs_baseline_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)>=2
            cmd = [cmd PathToData ss '_pmaverage_math_vs_baseline.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_pmaverage_math_vs_baseline_allsub.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/negative/group_pmaverage_math_vs_baseline_allsub_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/group_pmaverage_math_vs_baseline_allsub.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/positive/group_pmaverage_math_vs_baseline
clear all
%%%%ospan vs math/ 
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/v1only
cmd = ['fslmerge -t group_amaverage_math_vs_baseline_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)-1
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:2:end)
        if sessions(1)==1 & length(sessions)==2
            cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_amaverage_math_vs_baseline.nii.gz '];
            disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_amaverage_math_vs_baseline_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/v1only/negative/group_amaverage_math_vs_baseline_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/v1only/group_amaverage_math_vs_baseline_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/v1only/positive/group_amaverage_math_vs_baseline_v1only_pos.nii.gz

clear all

%%%v1v2
%%%%ospan vs math/ allsession
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v
cmd = ['fslmerge -t group_amaverage_math_vs_baseline_complete2v '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)==4
            cmd = [cmd PathToData ss '_amaverage_math_vs_baseline.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_amaverage_math_vs_baseline_complete2v.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/negative/group_amaverage_math_vs_baseline_complete2v_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/group_amaverage_math_vs_baseline_complete2v.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/positive/group_amaverage_math_vs_baseline_complete2v_pos.nii.gz
clear all

%%%allsub
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub
cmd = ['fslmerge -t group_amaverage_math_vs_baseline_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)>=2
            cmd = [cmd PathToData ss '_amaverage_math_vs_baseline.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_amaverage_math_vs_baseline_allsub.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/negative/group_amaverage_math_vs_baseline_allsub_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/group_amaverage_math_vs_baseline_allsub.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/positive/group_amaverage_math_vs_baseline
clear all


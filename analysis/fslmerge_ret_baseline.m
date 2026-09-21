%%%%ospan vs math/ allsession
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
%mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/allsessions/v1only
%mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/allsessions/v1only/positive
%mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/allsessions/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/
cmd = ['fslmerge -t group_allsessions_ret_vs_baseline '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/';
%delete 120 141 145
n=0
for iss =1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1
            cmd = [cmd PathToData  ss '_allsessions_ret_vs_baseline.nii.gz '];
            disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_ret_vs_baseline.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/negative/group_allsessions_ret_vs_baseline_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/group_allsessions_re_vs_baseline.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/positive/group_allsessions_ret_vs_baseline_v1only_pos.nii.gz
clear all

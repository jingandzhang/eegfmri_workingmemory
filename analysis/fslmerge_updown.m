clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_upvsdown/allvisits/
cmd = ['fslmerge -t group_so_upvsdown '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_upvsdown/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_upvsdown.nii.gz  '];
        disp(['v' num2str(i_ses)  '_'  ss]);
        n=n+1;
    end
end
 
unix(cmd)


clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_up/average/
cmd = ['fslmerge -t group_so_up '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_up/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
        cmd = [cmd PathToData 'average'  '_'  ss '_upstate.nii.gz  '];
        disp(['average'  '_'  ss]);
        n=n+1;

end
 
unix(cmd)

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/sp_nrem/allvisits/
cmd = ['fslmerge -t group_sp_nrem '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/sp_nrem/';

n=0
for iss = 1:29%length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_sp_nrem.nii.gz '];
        disp(['v' num2str(i_ses)  '_'  ss]);
        n=n+1;
    end
end
 
unix(cmd)

%%%%%%%%%%%%%%
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
%mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/
%mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/positive
%mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/negative
cmd = ['fslmerge -t group_so_indiv '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/';

n=0
%list=[2:11, 13:29]
ses_list{26,1} = 3;%deleted 142 v1 for outlier in the SO
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss}; 
    for i_ses = sessions(1:end)
        %cmd = [cmd PathToData  'average_'  ss '_so_nrem.nii.gz '];        
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_so_nrem.nii.gz '];
        disp(['v' num2str(i_ses)  '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
cmd2 = 'fslmaths group_so_indiv.nii -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/average/negative/group_so_indiv_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/group_so_indiv.nii /mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/average/positive/group_so_indiv_pos.nii
%%%%%%
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/v1only/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/v1only/
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/v1only/negative
cmd = ['fslmerge -t group_so_nrem_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/';

n=0
list=[2:11, 13:29]
for iss = list%length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_so_nrem.nii.gz '];
        disp(['v' num2str(i_ses)  '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
cmd2 = 'fslmaths group_so_nrem_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/v1only/negative/group_so_nrem_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/v1only/group_so_nrem_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/v1only/positive/group_so_nrem_v1only_pos.nii.gz

%%%%%%%%%%%%%%
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/
cmd = ['fslmerge -t group_am-pm_ospan_vs_math_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_am-pm_ospan_vs_math.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/
cmd = ['fslmerge -t group_am-pm_ospan_vs_baseline_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/';

n=0
for iss = 1:34%length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_am-pm_ospan_vs_baseline.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
 
unix(cmd)


cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/
cmd = ['fslmerge -t group_am-pm_math_vs_baseline_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:34%length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_am-pm_math_vs_baseline.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)

%%%%%%%%%% V1 only
%%%%ospan vs math/ am-pm
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/v1only
cmd = ['fslmerge -t group_am-pm_ospan_vs_math_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_am-pm_ospan_vs_math.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
unix(cmd)
cmd2 = 'fslmaths group_am-pm_ospan_vs_math_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/v1only/negative/group_am-pm_ospan_vs_math_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/v1only/group_am-pm_ospan_vs_math_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/v1only/positive/group_am-pm_ospan_vs_math_v1only_pos.nii.gz

%%%%
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/complete2v
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/complete2v/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/complete2v/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/complete2v
cmd = ['fslmerge -t group_am-pm_ospan_vs_math_complete2v '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)==4
            cmd = [cmd PathToData ss '_am-pm_ospan_vs_math.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_am-pm_ospan_vs_math_complete2v.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/complete2v/negative/group_am-pm_ospan_vs_math_complete2v_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/complete2v/group_am-pm_ospan_vs_math_complete2v.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v/positive/group_am-pm_ospan_vs_math_complete2v_pos.nii.gz

%%%allsub
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub
cmd = ['fslmerge -t group_am-pm_ospan_vs_math_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)>=2
            cmd = [cmd PathToData ss '_am-pm_ospan_vs_math.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_am-pm_ospan_vs_math_allsub.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/negative/group_am-pm_ospan_vs_math_allsub_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/group_am-pm_ospan_vs_math_allsub.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/positive/group_am-pm_ospan_vs_math_allsub_pos.nii.gz



%%%%ospan vs math/ allsession
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/v1only
cmd = ['fslmerge -t group_allsessions_ospan_vs_math_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:2:end)
        if sessions(1)==1
            cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_allsessions_ospan_vs_math.nii.gz '];
            disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_ospan_vs_math_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/v1only/negative/group_allsessions_ospan_vs_math_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/v1only/group_allsessions_ospan_vs_math_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/v1only/positive/group_allsessions_ospan_vs_math_v1only_pos.nii.gz

%%%v1v2
%%%%ospan vs math/ allsession
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v
cmd = ['fslmerge -t group_allsessions_ospan_vs_math_complete2v '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)==4
            cmd = [cmd PathToData ss '_allsessions_ospan_vs_math.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_ospan_vs_math_complete2v.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v/negative/group_allsessions_ospan_vs_math_complete2v_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v/group_allsessions_ospan_vs_math_complete2v.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v/positive/group_allsessions_ospan_vs_math_complete2v_pos.nii.gz

%%%allsub
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub
cmd = ['fslmerge -t group_allsessions_ospan_vs_math_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1:sessions(1:2:end)
        if sessions(1)==1 & length(sessions)>=2
            cmd = [cmd PathToData ss '_allsessions_ospan_vs_math.nii.gz '];
            disp([ss]);
            n=n+1;
        end
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_ospan_vs_math_allsub.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/negative/group_allsessions_ospan_vs_math_allsub_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/group_allsessions_ospan_vs_math_allsub.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/positive/group_allsessions_ospan_vs_math_allsub_pos.nii.gz


%%%% ospan vs baseline/ am-pm
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/v1only
cmd = ['fslmerge -t group_am-pm_ospan_vs_baseline_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_am-pm_ospan_vs_baseline.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
cmd2 = 'fslmaths group_am-pm_ospan_vs_baseline_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/v1only/negative/group_am-pm_ospan_vs_baseline_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/v1only/group_am-pm_ospan_vs_baseline_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/v1only/positive/group_am-pm_ospan_vs_baseline_v1only_pos.nii.gz

%%%% ospan vs baseline/ allsessions
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/v1only
cmd = ['fslmerge -t group_allsessions_ospan_vs_baseline_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_allsessions_ospan_vs_baseline.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_ospan_vs_baseline_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/v1only/negative/group_allsessions_ospan_vs_baseline_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/v1only/group_allsessions_ospan_vs_baseline_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/v1only/positive/group_allsessions_ospan_vs_baseline_v1only_pos.nii.gz

%%%% math vs baseline/ am-pm
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only
cmd = ['fslmerge -t group_am-pm_math_vs_baseline_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_am-pm_math_vs_baseline.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
cmd2 = 'fslmaths group_am-pm_math_vs_baseline_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/negative/group_am-pm_math_vs_baseline_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/group_am-pm_math_vs_baseline_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/positive/group_am-pm_math_vs_baseline_v1only_pos.nii.gz

%%%% math vs baseline/ allsessions
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only/negative
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only
cmd = ['fslmerge -t group_allsessions_math_vs_baseline_v1only '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';

n=0
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = 1%sessions(1:2:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_allsessions_math_vs_baseline.nii.gz '];
        disp(['v' num2str(round((i_ses+1)/2)) '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
cmd2 = 'fslmaths group_allsessions_math_vs_baseline_v1only.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only/negative/group_allsessions_math_vs_baseline_v1only_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only/group_allsessions_math_vs_baseline_v1only.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only/positive/group_allsessions_math_vs_baseline_v1only_pos.nii.gz


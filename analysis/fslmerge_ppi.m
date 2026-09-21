%PCtest
info=niftiinfo('/mnt/tambinidata/sleepstudy/data/derivatives/group/PCtest_nov9/group_ppi_indiv_so_precuneus.nii.gz')

load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/PCtest_nov9/
cmd = ['fslmerge -t group_ppi_indiv_so_precuneus '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/';

n=0
%list=[2:11, 13:29]
for iss = [2:11, 13:18, 20:34] %2:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:end)
        %cmd = [cmd PathToData  ss '_v' num2str(round((i_ses+1)/2))  'average' '_precuneus.nii.gz '];        
        cmd = [cmd PathToData  ss '_allsessions_precuneus.nii.gz '];
        disp(['v' num2str(i_ses)  '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
cmd2 = 'fslmaths group_ppi_indiv_so_precuneus.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/negative/group_ppi_indiv_so_precuneus_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/group_ppi_indiv_so_precuneus.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/positive/group_ppi_indiv_so_precuneus_pos.nii.gz

%%%%%%%%%%%%%%
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/negative
cmd = ['fslmerge -t group_ppi_indiv_so_precuneus '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/';

n=0
%list=[2:11, 13:29]
for iss = [2:11, 13:18, 20:34] %2:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:end)
        %cmd = [cmd PathToData  ss '_v' num2str(round((i_ses+1)/2))  'average' '_precuneus.nii.gz '];        
        cmd = [cmd PathToData  ss '_allsessions_precuneus.nii.gz '];
        disp(['v' num2str(i_ses)  '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
cmd2 = 'fslmaths group_ppi_indiv_so_precuneus.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/negative/group_ppi_indiv_so_precuneus_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/group_ppi_indiv_so_precuneus.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus/allsessions/positive/group_ppi_indiv_so_precuneus_pos.nii.gz

%%%%%%%%%%%%%%
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/positive
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/negative
cmd = ['fslmerge -t group_ppi_os_precuneus '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/';

n=0
%list=[2:11, 13:29]
for iss = 1:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:end)
        %cmd = [cmd PathToData  'average_'  ss '_so_nrem.nii.gz '];        
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_precuneus.nii.gz '];
        disp(['v' num2str(i_ses)  '_'  ss]);
        n=n+1;
    end
end
unix(cmd)
cmd2 = 'fslmaths group_os.nii.gz -mul -1 -nan /mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/negative/group_indiv_so_neg.nii'
unix(cmd2)
copyfile /mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/group_so_indiv.nii.gz /mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/positive/group_indiv_so_pos.nii.gz

%%%%%%%%%%%%%%
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/am-pm/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/am-pm/
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/am-pm/positive/
mkdir /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/am-pm/negative/
cmd = ['fslmerge -t group_am-pm_ppi_os_precuneus '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/';

n=0
for iss = 2:length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:2:end)
        cmd = [cmd PathToData ss '_precuneus.nii.gz '];
        disp([  ss]);
        n=n+1;
    end
end
unix(cmd)

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/
cmd = ['fslmerge -t group_am-pm_ospan_vs_baseline_allsub '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/';

n=0
for iss = 1:34%length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:2:end)
        cmd = [cmd PathToData ss '_am-pm_precuneus.nii.gz '];
        disp([  ss]);
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


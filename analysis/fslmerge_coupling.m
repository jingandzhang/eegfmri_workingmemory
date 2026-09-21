clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/coupled_vs_uncoupled/allvisits/
cmd = ['fslmerge -t group_coupled_vs_uncoupled '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/coupled_vs_uncoupled/';

n=0
for iss = 1:34%length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_coupled_vs_uncoupled.nii.gz '];
        disp(['v' num2str(i_ses)  '_'  ss]);
        n=n+1;
    end
end
 
unix(cmd)

clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/uncoupled_vs_nrem/allvisits/
cmd = ['fslmerge -t group_uncoupled '];
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/uncoupled_vs_nrem/';

n=0
for iss = 1:34%length(ss_list)
    ss = ss_list{iss};
    sessions = ses_list{iss};
    for i_ses = sessions(1:end)
        cmd = [cmd PathToData 'v' num2str(round((i_ses+1)/2))  '_'  ss '_uncoupled.nii.gz '];
        disp(['v' num2str(i_ses)  '_'  ss]);
        n=n+1;
    end
end
 
unix(cmd)

clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/fir_so/
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/fir_so/';

for i_beta = 1:10
    cmd = ['fslmerge -t group_fir_so_beta_00' num2str(i_beta,'%02.f') ' '];
    files=dir(['*' num2str(i_beta,'%02.f') '.nii.gz'])
    for i=1:length(files)
        cmd = [cmd files(i).name ' '];
        disp(files(i).name);
    end
    unix(cmd)
end

clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts/
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/fir_so/
PathToData = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/fir_so/';

for i_beta = 1:10
    cmd = ['fslmerge -t group_fir_so_beta_00' num2str(i_beta,'%02.f') 'v1only' ' '];
    files=dir(['*ses-1*' num2str(i_beta,'%02.f') '.nii.gz'])
    for i=1:length(files)
        cmd = [cmd files(i).name ' '];
        disp(files(i).name);
    end
    unix(cmd)
end

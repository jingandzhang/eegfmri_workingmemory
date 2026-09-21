
addpath /mnt/tambinidata/scripts/
addpath /tmp/mribin/spm12/
os_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/allvisits/positive/';
so_map = glob('OneSampT_tstat1.nii*', os_dir);
assert(length(so_map)==1)

unix(['gunzip ' so_map{1}])
so_map = glob('OneSampT_tstat1.nii*', os_dir);

info = spm_vol(so_map{1});
so_data = spm_read_vols(info);

ampm_os_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/positive/';
ampm_os_map = glob('OneSampT_tstat1.nii*', ampm_os_dir);
assert(length(ampm_os_map)==1)

unix(['gunzip ' ampm_os_map{1}])
ampm_os_map = glob('OneSampT_tstat1.nii*', ampm_os_dir);

info = spm_vol(ampm_os_map{1});
ampm_os_data = spm_read_vols(info)

ret_os_map ='/mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/positive/Ret_AM-PM_Pos_OneSampT_masknoCBS_tstat1.nii.gz';;
unix(['gunzip ' ret_os_map])

info = spm_vol(ret_os_map);
ret_os_data = spm_read_vols(info);


ampm_math_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/positive/';
ampm_math_map = glob('OneSampT_tstat1.nii*', ampm_math_dir);
assert(length(ampm_math_map)==1)

unix(['gunzip ' ampm_math_map{1}])
ampm_math_map = glob('OneSampT_tstat1.nii*', ampm_math_dir);

info = spm_vol(ampm_math_map{1});
ampm_math_data = spm_read_vols(info)

% 
% brain_mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_graymask_ds_noCBS.nii'; ;%'/mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds_noCBS_copy.nii';
% info = spm_vol(brain_mask_fl);
% brain_mask = spm_read_vols(info);

mask_dir = '/mnt/tambinidata/sleepstudy/analysis/network_mask/';
brain_mask_fl = [mask_dir 'network_3_ds.nii']
;info = spm_vol(brain_mask_fl);
brain_mask = spm_read_vols(info);
% add gray matter mask to brain mask
so_data = so_data(brain_mask==1);
ampm_os_data = ampm_os_data(brain_mask==1);
ampm_math_data = ampm_math_data(brain_mask==1);
ret_os_data = ret_os_data(brain_mask==1);


%%
set(gcf,'PaperPositionMode','auto')
figure(1);linregplotdata_robust_corrtext(so_data,ampm_math_data)
figure(2);linregplotdata_robust_corrtext(so_data,ampm_os_data)
figure(3);linregplotdata_robust_corrtext(so_data,ret_os_data)

fdir = sprintf('/mnt/tambinidata/sleepstudy/data/derivatives/group/os_paper_results/van_corr_ampm_math.png');
print('-f1','-dpng',fdir);
clf
fdir = sprintf('/mnt/tambinidata/sleepstudy/data/derivatives/group/os_paper_results/van_corr_ampm_ospan.png');
print('-f2','-dpng',fdir);
clf
fdir = sprintf('/mnt/tambinidata/sleepstudy/data/derivatives/group/os_paper_results/van_corr_ampm_ret.png');
print('-f3,'-dpng',fdir);
clf
%[b,stats] = robustfit([ampm_os_data ampm_math_data],so_data);


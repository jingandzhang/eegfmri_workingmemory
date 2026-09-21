N_parcel = 1;
save_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr_7networks';
addpath /mnt/tambinidata/scripts/


os_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/allvisits/positive/';
so_map = glob('OneSampT_tstat1.nii*', os_dir);
assert(length(so_map)==1)

unix(['gunzip ' so_map{1}])
so_map = glob('OneSampT_tstat1.nii*', os_dir);

info = spm_vol(so_map{1});
so_data = spm_read_vols(info);

ampm_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/positive/';
ampm_map = glob('OneSampT_tstat1.nii*', ampm_dir);
assert(length(ampm_map)==1)

unix(['gunzip ' ampm_map{1}])
ampm_map = glob('OneSampT_tstat1.nii*', ampm_dir);


info = spm_vol(ampm_map{1});
ampm_data = spm_read_vols(info);

r_vec = zeros(1,N_parcel);
p_vec = zeros(1,N_parcel);

for i = 1:N_parcel   
    tmp_so_data  = [];
    tmp_ampm_data = [];
    %brain_mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds_noCBS_copy.nii'; 
    mask_dir = '/mnt/tambinidata/sleepstudy/analysis/network_mask/';
    mask_fl = [mask_dir 'network_4_ds.nii'];
    info = spm_vol(mask_fl);
    brain_mask = spm_read_vols(info);

    % add parcel mask to brain mask
    tmp_so_data = so_data(brain_mask==1);
    tmp_ampm_data = ampm_data(brain_mask==1);
    
    [coeff,stats,r] = arobustfit(tmp_so_data,tmp_ampm_data);
    slope_idx = 2;
    r_vec(i) = round(r,5);
    p_vec(i) = round(stats.p(slope_idx),5);
    %%
    figure(1)
    linregplotdata_robust_corrtext(tmp_so_data,tmp_ampm_data)
    set(gca,'TickDir','out')
    feps = sprintf('%s/amaverage_vs_so_corr_parcel_wholemask_VA.eps','/mnt/tambinidata/sleepstudy/data/derivatives/group/os_paper_results');
    pause(1)    
    %print('-f1','-dpng',fdir);
    print('-f1','-depsc2','-r300','-painters',feps);
    clf
end
%save([save_dir '/amaverage_vs_so_corr_wholemask_VA'],'r_vec','p_vec')

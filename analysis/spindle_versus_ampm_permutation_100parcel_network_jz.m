N_parcel = 1;
save_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/spindle_vs_ampm_corr_7networks';
addpath /mnt/tambinidata/scripts/


so_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/sp_nrem/allvisit/';
so_map = glob('OneSampT_tstat1.nii*', so_dir);
assert(length(so_map)==1)

%unix(['gunzip ' so_map{1}])
so_map = glob('OneSampT_tstat1.nii*', so_dir);

info = spm_vol(so_map{1});
so_data = spm_read_vols(info);

ampm_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/nullmaps/';
num_permut = 1000;
r_vec = zeros(num_permut,N_parcel);
p_vec = zeros(num_permut,N_parcel);
for i_sim = 1:num_permut
    ampm_map = [ampm_dir sprintf('tmap_nullsim_%d.nii',i_sim)];
    info = spm_vol(ampm_map);
    ampm_data = spm_read_vols(info);

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
        r_vec(i_sim,i) = round(r,5);
        p_vec(i_sim,i) = round(stats.p(slope_idx),5);
%         %%
%         figure(1)
%         linregplotdata_robust_corrtext(tmp_so_data,tmp_ampm_data)
%         fdir = sprintf('%s/ampm_vs_so_corr_parcel_%d.png',save_dir,i);
%         pause(1)    
%         print('-f1','-dpng',fdir);
%         clf
    end
end
save([save_dir '/allses_vs_sp_null_permutation_corr_wholemask_VA'],'r_vec','p_vec')
%load([save_dir '/ampm_vs_sp_null_permutation_corr_wholemask_FP.mat'])

null_p=p_vec;
null_r=r_vec;
load([save_dir '/allses_vs_sp_corr_wholemask_VA.mat'])
true_p=p_vec;
true_r=r_vec;

for i = 1
    if true_r(:,i)>0
        sig_r(:,i)=null_r(:,i)>true_r(:,i);
    else
        sig_r(:,i)=null_r(:,i)<true_r(:,i);
    end
    proportion_r(i)=sum(sig_r(:,i))/num_permut;
end


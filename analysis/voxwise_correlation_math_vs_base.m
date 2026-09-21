addpath /mnt/tambinidata/scripts/
addpath /mnt/tambinidata/scripts/spm12/
load ss_info.mat
load ss_info_os.mat


so_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/';
so_ss_fls = glob('v*.nii', so_dir);

for i=1:length(so_ss_fls)
    sid=so_ss_fls{i}(end-14:end-11);
    visit=so_ss_fls{i}(end-20);
    so_ss_list{i}=strcat(sid,visit);
end  

os_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';
os_ss_fls = glob('v*am-pm_math_vs_baseline.nii.gz', os_dir);

for i=1:length(os_ss_fls)
    sid=os_ss_fls{i}(end-32:end-29);
    visit=os_ss_fls{i}(end-38);
    os_ss_list{i}=strcat(sid,visit);
end  
ss_ospan= os_ss_fls(find(ismember(os_ss_list,so_ss_list)));
ss_so= so_ss_fls(find(ismember(so_ss_list,os_ss_list)));

reshaped_os_data=nan(length(ss_ospan),240120); %initiate hardcoded voxel num
reshaped_so_data=nan(length(ss_ospan),240120); 
for j=1:length(ss_ospan)
    info_os = spm_vol(ss_ospan{j}); %(so_map{1});
    os_data = spm_read_vols(info_os);
    dims_os=size(os_data);
    reshaped_os_data(j, :)=reshape(os_data,1,[]);
    info_so = spm_vol(ss_so{j}); %(so_map{1});
    so_data = spm_read_vols(info_so);
    dims_so=size(so_data);
    reshaped_so_data(j, :)=reshape(so_data,1,[]);
end 

voxel_r=nan(1,size(reshaped_os_data,2));
voxel_p=nan(1,size(reshaped_os_data,2));
for ii=1:size(reshaped_os_data,2)
    
    [coeff,stats,r] = arobustfit(reshaped_so_data(:,ii),reshaped_os_data(:,ii));  %swap x and y
    slope_idx = 2;
    voxel_r(ii)= round(r,5);
    voxel_p(ii) = round(stats.p(slope_idx),5);

%     [rho,pval]=corr(reshaped_os_data(:,ii),reshaped_so_data(:,ii));
%     voxel_r(ii)=rho;
%     voxel_p(ii)=pval;    
end
reshaped_3d_r=reshape(voxel_r,size(so_data)); %put it back to 3d
reshaped_3d_p=reshape(voxel_p,size(so_data));

%apply mask

mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds_noCBS_copy.nii';
%mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/positive/cluster_index_allsession_noCBS_tfcemask.nii';
mask_info=spm_vol(mask_fl);
mask=spm_read_vols(mask_info);
reshaped_3d_r(mask==0)=0;
reshaped_3d_p(mask==0)=1;


new_info_os_r=info_os;
new_info_os_r.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/positive/voxelwise_so_ampm_mathvsbase_corr_rmap_noCBSmask.nii';
spm_write_vol(new_info_os_r, reshaped_3d_r);
new_info_os_p=info_os;
new_info_os_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/positive/voxelwise_so_ampm_mathvsbase_corr_pmap_noCBSmask.nii';
spm_write_vol(new_info_os_p, 1-reshaped_3d_p);

%seperate neg and pos
pos_voxel_r=voxel_r;
pos_voxel_r(voxel_r<0)=0;
pos_voxel_p=voxel_p;
pos_voxel_p(voxel_r<0)=1;

neg_voxel_r=voxel_r;
neg_voxel_r(voxel_r>0)=0;
neg_voxel_p=voxel_p;
neg_voxel_p(voxel_r>0)=1;

%put it back to 3d
pos_reshaped_3d_r=reshape(pos_voxel_r,size(so_data));
pos_reshaped_3d_p=reshape(pos_voxel_p,size(so_data));
neg_reshaped_3d_r=reshape(neg_voxel_r,size(so_data));
neg_reshaped_3d_p=reshape(neg_voxel_p,size(so_data));

%apply mask 
%mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds_noCBS_copy.nii';
mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds_noCBS_copy.nii';
%mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/positive_noCBS/ospan_vs_math_pos_OneSampT_cluster_index_fdr_mask.nii';

mask_info=spm_vol(mask_fl);
mask=spm_read_vols(mask_info);
pos_reshaped_3d_r(mask==0)=0;
pos_reshaped_3d_p(mask==0)=1;
neg_reshaped_3d_r(mask==0)=0;
neg_reshaped_3d_p(mask==0)=1;

%fdr corrected vals 

fdr_pos_voxel_r = pos_reshaped_3d_r;
fdr_pos_voxel_p = mafdr(pos_reshaped_3d_p(:),'BHFDR',true);
fdr_neg_voxel_r = neg_reshaped_3d_r;
fdr_neg_voxel_p = mafdr(neg_reshaped_3d_p(:),'BHFDR',true);
fdr_pos_voxel_r = reshape(fdr_pos_voxel_r,size(so_data));
fdr_pos_voxel_p = reshape(fdr_pos_voxel_p,size(so_data));
fdr_neg_voxel_r = reshape(fdr_neg_voxel_r,size(so_data));
fdr_neg_voxel_p = reshape(fdr_neg_voxel_p,size(so_data));

%write data
fdr_pos_new_info_os_r=info_os;
fdr_pos_new_info_os_r.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/positive/fdr_pos_voxelwise_so_ampm_mathvsbase_corr_rmap_noCBS_mask.nii';
spm_write_vol(fdr_pos_new_info_os_r,fdr_pos_voxel_r);
fdr_pos_new_info_os_p=info_os;
fdr_pos_new_info_os_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/positive/fdr_pos_voxelwise_so_ampm_mathvsbase_corr_pmap_noCBS_mask.nii';
spm_write_vol(fdr_pos_new_info_os_p, 1-fdr_pos_voxel_p);

fdr_neg_new_info_os_r=info_os;
fdr_neg_new_info_os_r.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/negative/fdr_neg_voxelwise_so_ampm_mathvsbase_corr_rmap_noCBS_mask.nii';
spm_write_vol(fdr_neg_new_info_os_r,fdr_neg_voxel_r);
fdr_neg_new_info_os_p=info_os;
fdr_neg_new_info_os_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/negative/fdr_neg_voxelwise_so_ampm_mathvsbase_corr_pmap_noCBS_mask.nii';
spm_write_vol(fdr_neg_new_info_os_p, 1-fdr_neg_voxel_p);
% 
% %apply mask precuneous 
% mask_fl_pre = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/negative/mask_allsessions_noCBS/precuneus_tfce_mask.nii';
% mask_info_pre=spm_vol(mask_fl_pre);
% mask_pre=spm_read_vols(mask_info_pre);
% pos_reshaped_3d_r_pre(mask_pre==0)=0;
% pos_reshaped_3d_p_pre(mask_pre==0)=1;
% neg_reshaped_3d_r_pre(mask_pre==0)=0;
% neg_reshaped_3d_p_pre(mask_pre==0)=1;
% %fdr corrected vals 
% 
% fdr_pos_voxel_r_pre = mafdr(pos_reshaped_3d_r_pre(:),'BHFDR',true);
% fdr_pos_voxel_p_pre = mafdr(pos_reshaped_3d_p_pre(:),'BHFDR',true);
% fdr_neg_voxel_r_pre = mafdr(neg_reshaped_3d_r_pre(:),'BHFDR',true);
% fdr_neg_voxel_p_pre = mafdr(neg_reshaped_3d_p_pre(:),'BHFDR',true);
% fdr_pos_voxel_r_pre = reshape(fdr_pos_voxel_r_pre,size(so_data));
% fdr_pos_voxel_p_pre = reshape(fdr_pos_voxel_p_pre,size(so_data));
% fdr_neg_voxel_r_pre = reshape(fdr_neg_voxel_r_pre,size(so_data));
% fdr_neg_voxel_p_pre = reshape(fdr_neg_voxel_p_pre,size(so_data));
% 
% 
% %write data
% fdr_pos_new_info_os_r_pre=info_os;
% fdr_pos_new_info_os_r_pre.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_pos_voxelwise_so_ampm_corr_rmap_pre.nii';
% spm_write_vol(fdr_pos_new_info_os_r_pre,fdr_pos_voxel_r_pre);
% fdr_pos_new_info_os_p_pre=info_os;
% fdr_pos_new_info_os_p_pre.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_pos_voxelwise_so_ampm_corr_pmap_pre.nii';
% spm_write_vol(fdr_pos_new_info_os_p_pre, 1-fdr_pos_voxel_p_pre);
% 
% fdr_neg_new_info_os_r_pre=info_os;
% fdr_neg_new_info_os_r_pre.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_neg_voxelwise_so_ampm_corr_rmap_pre.nii';
% spm_write_vol(fdr_neg_new_info_os_r_pre,fdr_neg_voxel_r_pre);
% fdr_neg_new_info_os_p_pre=info_os;
% fdr_neg_new_info_os_p_pre.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_neg_voxelwise_so_ampm_corr_pmap_pre.nii';
% spm_write_vol(fdr_neg_new_info_os_p_pre, 1-fdr_neg_voxel_p_pre);
% 
% 
% %apply mask allses
% mask_fl_allses = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/positive_noCBS/ospan_vs_math_pos_OneSampT_cluster_index_fdr_mask.nii';
% mask_info_allses=spm_vol(mask_fl_allses);
% mask_allses=spm_read_vols(mask_info_allses);
% pos_reshaped_3d_r_allses(mask_allses==0)=0;
% pos_reshaped_3d_p_allses(mask_allses==0)=1;
% neg_reshaped_3d_r_allses(mask_allses==0)=0;
% neg_reshaped_3d_p_allses(mask_allses==0)=1;
% %fdr corrected vals 
% 
% fdr_pos_voxel_r_allses = mafdr(pos_reshaped_3d_r_allses,'BHFDR',true);
% fdr_pos_voxel_p_allses = mafdr(pos_reshaped_3d_p_allses,'BHFDR',true);
% fdr_neg_voxel_r_allses = mafdr(neg_reshaped_3d_r_allses,'BHFDR',true);
% fdr_neg_voxel_p_allses = mafdr(neg_reshaped_3d_p_allses,'BHFDR',true);
% fdr_pos_voxel_r_allses = reshape(fdr_pos_voxel_r_allses,size(so_data));
% fdr_pos_voxel_p_allses = reshape(fdr_pos_voxel_p_allses,size(so_data));
% fdr_neg_voxel_r_allses = reshape(fdr_neg_voxel_r_allses,size(so_data));
% fdr_neg_voxel_p_allses = reshape(fdr_neg_voxel_p_allses,size(so_data));
% %write data
% fdr_pos_new_info_os_r_allses=info_os;
% fdr_pos_new_info_os_r_allses.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_pos_voxelwise_so_ampm_corr_rmap_allses.nii';
% spm_write_vol(fdr_pos_new_info_os_r_allses,fdr_pos_voxel_r_allses);
% fdr_pos_new_info_os_p_allses=info_os;
% fdr_pos_new_info_os_p_allses.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_pos_voxelwise_so_ampm_corr_pmap_allses.nii';
% spm_write_vol(fdr_pos_new_info_os_p_allses, 1-fdr_pos_voxel_p_allses);
% 
% fdr_neg_new_info_os_r_allses=info_os;
% fdr_neg_new_info_os_r_allses.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_neg_voxelwise_so_ampm_corr_rmap_allses.nii';
% spm_write_vol(fdr_neg_new_info_os_r_allses,fdr_neg_voxel_r_allses);
% fdr_neg_new_info_os_p_allses=info_os;
% fdr_neg_new_info_os_p_allses.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_neg_voxelwise_so_ampm_corr_pmap_allses.nii';
% spm_write_vol(fdr_neg_new_info_os_p_allses, 1-fdr_neg_voxel_p_allses);

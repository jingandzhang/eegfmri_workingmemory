addpath /mnt/tambinidata/scripts/
load ss_info.mat
load ss_info_os.mat
addpath /mnt/tambinidata/scripts/spm12


so_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/';
so_ss_fls = glob('v*.nii', so_dir);

for i=1:length(so_ss_fls)
    sid=so_ss_fls{i}(end-14:end-11);
    visit=so_ss_fls{i}(end-20);
    so_ss_list{i}=strcat(sid,visit);
end  

os_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ret_vs_baseline/';
os_ss_fls = glob('v*am-pm_ret_vs_base.nii.gz', os_dir);
for i=1:length(os_ss_fls)
    sid=os_ss_fls{i}(end-27:end-24);
    visit=os_ss_fls{i}(end-33);
    os_ss_list{i}=strcat(sid,visit);
end  
ss_ospan= os_ss_fls(find(ismember(os_ss_list,so_ss_list)));
ss_so= so_ss_fls(find(ismember(so_ss_list,os_ss_list)));

ospan_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/';
ospan_ss_fls = glob('v*am-pm_ospan_vs_math.nii', ospan_dir);
for i=1:length(ospan_ss_fls)
    sid=ospan_ss_fls{i}(end-26:end-23);
    visit=ospan_ss_fls{i}(end-32);
    ospan_ss_list{i}=strcat(sid,visit);
end  
ss_ospan_math= ospan_ss_fls(find(ismember(ospan_ss_list,so_ss_list)));
ss_so= so_ss_fls(find(ismember(so_ss_list,ospan_ss_list)));


math_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/';
math_ss_fls = glob('v*am-pm_math_vs_baseline.nii.gz', math_dir);
for i=1:length(math_ss_fls)
    sid=math_ss_fls{i}(end-32:end-29);
    visit=math_ss_fls{i}(end-38);
    math_ss_list{i}=strcat(sid,visit);   
end  
ss_math= math_ss_fls(find(ismember(math_ss_list,so_ss_list)));
ss_so= so_ss_fls(find(ismember(so_ss_list,math_ss_list)));

% reshaped_os_data=nan(length(ss_ospan),240120); %initiate hardcoded voxel num
reshaped_so_data=nan(length(ss_ospan),240120); 
reshaped_math_data=nan(length(ss_ospan),240120); 

for j=1:length(ss_ospan)
    info_os = spm_vol(ss_ospan{j}); %(so_map{1});
    os_data = spm_read_vols(info_os);
    dims_os=size(os_data);
    reshaped_os_data(j, :)=reshape(os_data,1,[]);
    
    info_ospan = spm_vol(ss_ospan_math{j}); %(so_map{1});
    ospan_data = spm_read_vols(info_ospan);
    dims_os=size(ospan_data);
    reshaped_ospan_data(j, :)=reshape(ospan_data,1,[]);
    
    info_math = spm_vol(ss_math{j}); %(so_map{1});
    math_data = spm_read_vols(info_math);
    dims_math=size(math_data);
    reshaped_math_data(j, :)=reshape(math_data,1,[]);
    
    info_so = spm_vol(ss_so{j}); %(so_map{1});
    so_data = spm_read_vols(info_so);
    dims_so=size(so_data);
    reshaped_so_data(j, :)=reshape(so_data,1,[]);
    
end 

voxel_t_math=nan(1,size(reshaped_os_data,2));
voxel_p_math=nan(1,size(reshaped_os_data,2));
voxel_t_ospan=nan(1,size(reshaped_os_data,2));
voxel_p_ospan=nan(1,size(reshaped_os_data,2));
voxel_t_ret=nan(1,size(reshaped_os_data,2));
voxel_p_ret=nan(1,size(reshaped_os_data,2));
for ii=1:size(reshaped_os_data,2)
    
    [b, stats] = robustfit([reshaped_os_data(:,ii) reshaped_ospan_data(:,ii) reshaped_math_data(:,ii)],reshaped_so_data(:,ii));
    
    voxel_p_ret(ii)=round(stats.p(2),5);   
    voxel_t_ret(ii)=round(stats.t(2),5);
    voxel_p_ospan(ii)=round(stats.p(3),5);   
    voxel_t_ospan(ii)=round(stats.t(3),5);
    voxel_p_math(ii)=round(stats.p(4),5);   
    voxel_t_math(ii)=round(stats.t(4),5);   
end
reshaped_3d_t_ret=reshape(voxel_t_ret,size(so_data)); %put it back to 3d
reshaped_3d_p_ret=reshape(voxel_p_ret,size(so_data));
reshaped_3d_t_ospan=reshape(voxel_t_ospan,size(so_data)); %put it back to 3d
reshaped_3d_p_ospan=reshape(voxel_p_ospan,size(so_data));
reshaped_3d_t_math=reshape(voxel_t_math,size(so_data)); %put it back to 3d
reshaped_3d_p_math=reshape(voxel_p_math,size(so_data));
%apply mask

mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds_noCBS_copy.nii';
mask_info=spm_vol(mask_fl);
mask=spm_read_vols(mask_info);
reshaped_3d_t_ret(mask==0)=0;
reshaped_3d_p_ret(mask==0)=1;
reshaped_3d_t_ospan(mask==0)=0;
reshaped_3d_p_ospan(mask==0)=1;
reshaped_3d_t_math(mask==0)=0;
reshaped_3d_p_math(mask==0)=1;

new_info_os_t=info_os;
new_info_os_t.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/voxelwise_so_os_3factor_corr_tmap_multiregression.nii';
spm_write_vol(new_info_os_t, reshaped_3d_t_ospan);
new_info_os_p=info_os;
new_info_os_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/voxelwise_so_os_3factor_corr_pmap_multiregression.nii';
spm_write_vol(new_info_os_p, 1-reshaped_3d_p_ospan);

new_info_ret_t=info_ospan;
new_info_ret_t.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/voxelwise_so_ret_3factor_corr_tmap_multiregression.nii';
spm_write_vol(new_info_ret_t, reshaped_3d_t_ret);
new_info_ret_p=info_ospan;
new_info_ret_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/voxelwise_so_ret_3factor_corr_pmap_multiregression.nii';
spm_write_vol(new_info_ret_p, 1-reshaped_3d_p_ret);

new_info_math_t=info_math;
new_info_math_t.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/voxelwise_so_math_3factor_corr_tmap_multiregression.nii';
spm_write_vol(new_info_math_t, reshaped_3d_t_math);
new_info_math_p=info_math;
new_info_math_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/voxelwise_so_math_3factor_corr_pmap_multiregression.nii';
spm_write_vol(new_info_math_p, 1-reshaped_3d_p_math);
%seperate neg and pos for os
pos_voxel_t_ospan=voxel_t_ospan;
pos_voxel_t_ospan(voxel_t_ospan<0)=0;
pos_voxel_p_ospan=voxel_p_ospan;
pos_voxel_p_ospan(voxel_t_ospan<0)=1;

neg_voxel_t_ospan=voxel_t_ospan;
neg_voxel_t_ospan(voxel_t_ospan>0)=0;
neg_voxel_p_ospan=voxel_p_ospan;
neg_voxel_p_ospan(voxel_t_ospan>0)=1;

%seperate neg and pos for ret
pos_voxel_t_ret=voxel_t_ret;
pos_voxel_t_ret(voxel_t_ret<0)=0;
pos_voxel_p_ret=voxel_p_ret;
pos_voxel_p_ret(voxel_t_ret<0)=1;

neg_voxel_t_ret=voxel_t_ret;
neg_voxel_t_ret(voxel_t_ret>0)=0;
neg_voxel_p_ret=voxel_p_ret;
neg_voxel_p_ret(voxel_t_ret>0)=1;
%seperate neg and pos for math
pos_voxel_t_math=voxel_t_math;
pos_voxel_t_math(voxel_t_math<0)=0;
pos_voxel_p_math=voxel_p_math;
pos_voxel_p_math(voxel_t_math<0)=1;

neg_voxel_t_math=voxel_t_math;
neg_voxel_t_math(voxel_t_math>0)=0;
neg_voxel_p_math=voxel_p_math;
neg_voxel_p_math(voxel_t_math>0)=1;
%put it back to 3d os
pos_reshaped_3d_t_ospan=reshape(pos_voxel_t_ospan,size(so_data));
pos_reshaped_3d_p_ospan=reshape(pos_voxel_p_ospan,size(so_data));
neg_reshaped_3d_r_ospan=reshape(neg_voxel_t_ospan,size(so_data));
neg_reshaped_3d_p_ospan=reshape(neg_voxel_p_ospan,size(so_data));

%put it back to 3d ret
pos_reshaped_3d_t_ret=reshape(pos_voxel_t_ret,size(so_data));
pos_reshaped_3d_p_ret=reshape(pos_voxel_p_ret,size(so_data));
neg_reshaped_3d_r_ret=reshape(neg_voxel_t_ret,size(so_data));
neg_reshaped_3d_p_ret=reshape(neg_voxel_p_ret,size(so_data));
%put it back to 3d math
pos_reshaped_3d_t_math=reshape(pos_voxel_t_math,size(math_data));
pos_reshaped_3d_p_math=reshape(pos_voxel_p_math,size(math_data));
neg_reshaped_3d_t_math=reshape(neg_voxel_t_math,size(math_data));
neg_reshaped_3d_p_math=reshape(neg_voxel_p_math,size(math_data));
%apply mask 
mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds_noCBS_copy.nii';
%mask_fl= '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/negative/mask_allsessions_noCBS/precuneus_tfce_mask.nii';
%mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/positive_noCBS/ospan_vs_math_pos_OneSampT_cluster_index_fdr_mask.nii';

mask_info=spm_vol(mask_fl);
mask=spm_read_vols(mask_info);
pos_reshaped_3d_t_ospan(mask==0)=0;
pos_reshaped_3d_p_ospan(mask==0)=1;
neg_reshaped_3d_t_ospan(mask==0)=0;
neg_reshaped_3d_p_ospan(mask==0)=1;

pos_reshaped_3d_t_ret(mask==0)=0;
pos_reshaped_3d_p_ret(mask==0)=1;
neg_reshaped_3d_t_ret(mask==0)=0;
neg_reshaped_3d_p_ret(mask==0)=1;

pos_reshaped_3d_t_math(mask==0)=0;
pos_reshaped_3d_p_math(mask==0)=1;
neg_reshaped_3d_t_math(mask==0)=0;
neg_reshaped_3d_p_math(mask==0)=1;
%fdr corrected vals 

fdr_pos_voxel_r = pos_reshaped_3d_t_ospan;
fdr_pos_voxel_p = mafdr(pos_reshaped_3d_p_ospan(:),'BHFDR',true);
fdr_neg_voxel_r = neg_reshaped_3d_t_ospan;
fdr_neg_voxel_p = mafdr(neg_reshaped_3d_p_ospan(:),'BHFDR',true);
fdr_pos_voxel_r = reshape(fdr_pos_voxel_r,size(so_data));
fdr_pos_voxel_p = reshape(fdr_pos_voxel_p,size(so_data));
fdr_neg_voxel_r = reshape(fdr_neg_voxel_r,size(so_data));
fdr_neg_voxel_p = reshape(fdr_neg_voxel_p,size(so_data));

fdr_pos_voxel_r_ret = pos_reshaped_3d_t_ret;
fdr_pos_voxel_p_ret = mafdr(pos_reshaped_3d_p_ret(:),'BHFDR',true);
fdr_neg_voxel_r_ret = neg_reshaped_3d_t_ret;
fdr_neg_voxel_p_ret = mafdr(neg_reshaped_3d_p_ret(:),'BHFDR',true);
fdr_pos_voxel_r_ret = reshape(fdr_pos_voxel_r_ret,size(so_data));
fdr_pos_voxel_p_ret = reshape(fdr_pos_voxel_p_ret,size(so_data));
fdr_neg_voxel_r_ret = reshape(fdr_neg_voxel_r_ret,size(so_data));
fdr_neg_voxel_p_ret = reshape(fdr_neg_voxel_p_ret,size(so_data));
%fdr corrected vals 
fdr_pos_voxel_t_math = pos_reshaped_3d_t_math;
fdr_pos_voxel_p_math = mafdr(pos_reshaped_3d_p_math(:),'BHFDR',true);
fdr_neg_voxel_t_math = neg_reshaped_3d_t_math;
fdr_neg_voxel_p_math = mafdr(neg_reshaped_3d_p_math(:),'BHFDR',true);
fdr_pos_voxel_t_math = reshape(fdr_pos_voxel_t_math,size(math_data));
fdr_pos_voxel_p_math = reshape(fdr_pos_voxel_p_math,size(math_data));
fdr_neg_voxel_t_math = reshape(fdr_neg_voxel_t_math,size(math_data));
fdr_neg_voxel_p_math = reshape(fdr_neg_voxel_p_math,size(math_data));

%write data
fdr_pos_new_info_os_t=info_os;
fdr_pos_new_info_os_t.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_pos_voxelwise_so_os_3factors_ampm_corr_tmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_pos_new_info_os_t,fdr_pos_voxel_r);
fdr_pos_new_info_os_p=info_os;
fdr_pos_new_info_os_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_pos_voxelwise_so_os_3factors_ampm_corr_pmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_pos_new_info_os_p, 1-fdr_pos_voxel_p);

fdr_neg_new_info_os_r=info_os;
fdr_neg_new_info_os_r.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_neg_voxelwise_so_os_3factors_ampm_corr_tmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_neg_new_info_os_r,fdr_neg_voxel_r);
fdr_neg_new_info_os_p=info_os;
fdr_neg_new_info_os_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_neg_voxelwise_so_os_3factors_ampm_corr_pmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_neg_new_info_os_p, 1-fdr_neg_voxel_p);
% 
%write data
fdr_pos_new_info_ret_t=info_ospan;
fdr_pos_new_info_ret_t.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_pos_voxelwise_so_ret_3factors_ampm_corr_tmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_pos_new_info_ret_t,fdr_pos_voxel_r_ret);
fdr_pos_new_info_ret_p=info_ospan;
fdr_pos_new_info_ret_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_pos_voxelwise_so_ret_3factors_ampm_corr_pmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_pos_new_info_ret_p, 1-fdr_pos_voxel_p_ret);

fdr_neg_new_info_os_r=info_os;
fdr_neg_new_info_os_r.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_neg_voxelwise_so_ret_3factors_ampm_corr_tmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_neg_new_info_os_r,fdr_neg_voxel_r_ret);
fdr_neg_new_info_os_p=info_os;
fdr_neg_new_info_os_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_neg_voxelwise_so_ret_3factors_ampm_corr_pmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_neg_new_info_os_p, 1-fdr_neg_voxel_p_ret);
% 


%write data
fdr_pos_new_info_math_t=info_math;
fdr_pos_new_info_math_t.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_pos_voxelwise_so_math_3factors_ampm_corr_tmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_pos_new_info_math_t,fdr_pos_voxel_t_math);
fdr_pos_new_info_math_p=info_math;
fdr_pos_new_info_math_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_pos_voxelwise_so_math_3factors_ampm_corr_pmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_pos_new_info_math_p, 1-fdr_pos_voxel_p_math);

fdr_neg_new_info_math_t=info_math;
fdr_neg_new_info_math_t.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_neg_voxelwise_so_math_3factors_ampm_corr_tmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_neg_new_info_math_t,fdr_neg_voxel_t_math);
fdr_neg_new_info_math_p=info_math;
fdr_neg_new_info_math_p.fname= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/fdr_neg_voxelwise_so_math_3factors_ampm_corr_pmap_noCBS_multipleregression.nii';
spm_write_vol(fdr_neg_new_info_math_p, 1-fdr_neg_voxel_p_math);
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

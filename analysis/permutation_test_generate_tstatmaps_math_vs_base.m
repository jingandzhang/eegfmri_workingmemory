

addpath(genpath('/mnt/tambinidata/scripts/'))
ampm_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/';
null_dir = [ampm_dir 'nullmaps/'];
if isdir(null_dir)==0
    mkdir(null_dir)
end

tmap_info = spm_vol([ampm_dir 'positive/OneSampT_tstat1.nii']);

mask_fl = '/mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds_copy.nii';
data_fl = [ampm_dir 'positive/group_allsessions_math_vs_baseline_allsub_pos.nii'];

info = spm_vol(data_fl);
data_orig = spm_read_vols(info);
Nses = size(data_orig, 4);
Nsim = 1000; % # of null permutations to run
%%
mask_info = spm_vol(mask_fl);
mask = spm_read_vols(mask_info);
data_size = size(mask);
mask_reshape = reshape(mask, [prod(data_size),1]);

%%
for isim = 1:Nsim
    data = data_orig;

    for iss = 1:Nses
        toflip = rand > .5; % to flip or not flip sign of map for a given subject/session

        if toflip
            data(:,:,:,iss) = -1*data(:,:,:,iss);
        end
        
    end
    
    data_reshape = reshape(data, [prod(data_size),Nses]);
    data_select = data_reshape(mask_reshape==1,:);
    
    [~,~,~,stats] = ttest(data_select, 0, 'Dim', 2);
    tvalues = stats.tstat;
    
    tmap = zeros([prod(data_size), 1]);
    tmap(mask_reshape==1) = tvalues;
    tmap = reshape(tmap, data_size);
    
    new_info = tmap_info;
    new_info.fname = [null_dir 'tmap_nullsim_' num2str(isim) '.nii'];
    spm_write_vol(new_info, tmap)
    
end

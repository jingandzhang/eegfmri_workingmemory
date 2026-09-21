clear
load ss_info.mat
addpath /mnt/tambinidata/scripts/
addpath /tmp/mribin/spm12/

roi=['/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/cluster_mask55.nii']
       % roi=['/mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/allvisits/negative/mask_wm/cluster_mask9.nii']
        unix(['gunzip ' [roi '.gz']])
contrast_list = {'so_nrem'};

for i_con = 1:length(contrast_list)
    contrast_name = contrast_list{i_con};
    for i_roi = 1%:length(roi_list)
%         roi_out=zeros(length(ss_list),4);
%         roi_name = num2str(roi_list{i_roi});
%         

        for iss=1:length(ss_list)
            %open the subject directory and count session files 
            ss = ss_list{iss};
            ss_dir = [preproc_dir ss];
            %sessions = ses_list{iss};
            sessions_dir = ses_list{iss};
            if isempty(sessions_dir)
                warning(['Warning, no sessions found for subject' num2str(ss) '. Please check subject IDs and the paths are correct.']);
            end
            for i_ses = sessions_dir
                %spm_dir = [ss_dir '/ses-' num2str(i_ses) '/spm_nrem_coupling_model1_test/'];
                spm_dir = [ss_dir '/ses-' num2str(i_ses) '/spm_nrem_indiv_so_model1_test/'];
                file_str = ['*con_' contrast_name '.nii'];
                %file_str = ['*con_' contrast_name '_so_nrem.nii'];
                img = char(glob(file_str,spm_dir));
                if ~isempty(img)
                    roi_out(iss, i_ses) = rex(img,roi,  'select_clusters',0);
                end
            end
        end
        %filename = [data_dir 'derivatives/group/' contrast_name '/ROI/200parcels/' contrast_name '_' roi_name '.mat']
       
        roi_out(roi_out==0)=nan; 
        filename = [data_dir 'derivatives/group/indiv_so_corr_ampm_mask55_roi.mat']
        save(filename,'roi_out','ss_list')
    end
end
% load('/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/ROI/allsub_network/ospan_vs_math_cluster_mask_tstat_6_18.nii.mat')
% ss_list_ospan=ss_list;
% roi_out_ospan=roi_out;
% load('/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr_7networks/so_nrem_cluster_mask_tstat_6_18.nii.mat')
% ss_ospan= roi_out_ospan(find(ismember(ss_list_ospan,ss_list)),:);
% ampm_ospan=ss_ospan(:,2:2:4)-ss_ospan(:,1:2:3);
% allsub_ampm_ospan=[ampm_ospan(:,1)' ampm_ospan(:,2)'];
% allsub_ampm_ospan(60)=nan;
% allsub_ampm_sleep=[roi_out(:,1)' roi_out(:,3)']; %delete sub 142 for outlier in ospan precunous
% [rho, pval]=corr(allsub_ampm_sleep', allsub_ampm_ospan', 'rows' ,'complete')
% scatter(allsub_ampm_sleep', allsub_ampm_ospan')
% 
% 
% load('/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/ROI/allsub_network/ospan_vs_math_cluster_mask24.nii.mat')
% ss_list_ospan=ss_list;
% roi_out_ospan=roi_out;
% load('/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr_7networks/so_nrem_cluster_mask24.nii.mat')
% ss_ospan= roi_out_ospan(find(ismember(ss_list_ospan,ss_list)),:);
% ampm_ospan=ss_ospan(:,2:2:4)-ss_ospan(:,1:2:3);
% allsub_ampm_ospan=[ampm_ospan(:,1)' ampm_ospan(:,2)'];
% allsub_ampm_ospan(60)=NaN;
% allsub_ampm_sleep=[roi_out(:,1)' roi_out(:,3)']; %delete sub 142 for outlier in ospan precunous
% [rho, pval]=corr(allsub_ampm_sleep', allsub_ampm_ospan', 'rows' ,'complete')
% scatter(allsub_ampm_sleep', allsub_ampm_ospan')
% 
% load('/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/ROI/allsub_network/ospan_vs_math_ospan_vs_math_pos_OneSampT_t2_mask.nii.mat')
% ss_list_ospan=ss_list;
% roi_out_ospan=roi_out;
% load('/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr_7networks/so_nrem_ospan_vs_math_pos_OneSampT_t2_mask.nii.mat')
% ss_ospan= roi_out_ospan(find(ismember(ss_list_ospan,ss_list)),:);
% ampm_ospan=ss_ospan(:,2:2:4)-ss_ospan(:,1:2:3);
% allsub_ampm_ospan=[ampm_ospan(:,1)' ampm_ospan(:,2)'];
% allsub_ampm_sleep=[roi_out(:,1)' roi_out(:,3)']; %delete sub 142 for outlier in ospan precunous
% [rho, pval]=corr(allsub_ampm_sleep', allsub_ampm_ospan', 'rows' ,'complete')
% scatter(allsub_ampm_sleep', allsub_ampm_ospan')
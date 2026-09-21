clear
load ss_info_os.mat
addpath /mnt/tambinidata/scripts/
%roi_list = {'cluster_fdr_mask_merged','cluster_fdr_mask10','cluster_fdr_mask13','cluster_fdr_mask15','cluster_fdr_mask16','cluster_fdr_mask18','cluster_fdr_mask19'} 
%roi_list = {'MNI_R_Thal_bin_Lib','MNI_L_Thal_bin_Lib','MNI_R_Stri_bin_Lib','MNI_L_Stri_bin_Lib','MNI_R_Pall_bin_Lib','MNI_L_Pall_bin_Lib','MNI_R_Accu_bin_Lib','MNI_L_Accu_bin_Lib','MNI_R_Caud_bin_Lib','MNI_L_Caud_bin_Lib','MNI_R_Puta_bin_Lib','MNI_L_Puta_bin_Lib','MNI_Post_R_Hipp_bin_Lib','MNI_Mid_R_Hipp_bin_Lib','MNI_R_Hipp_bin_Lib','MNI_Ant_R_Hipp_bin_Lib','MNI_Post_L_Hipp_bin_Lib','MNI_Mid_L_Hipp_bin_Lib','MNI_L_Hipp_bin_Lib','MNI_Ant_L_Hipp_bin_Lib'}
roi_list = {'network_6_ds.nii'} ;%,'cluster_mask_tstat_23.nii','cluster_mask_tstat_22.nii','cluster_mask_tstat_21.nii','cluster_mask_tstat_20.nii'};
contrast_list = {'ospan_vs_math'};%{'math_vs_baseline','ospan_vs_baseline','ospan_vs_math'}
for i_con = 1:length(contrast_list)
    contrast_name = contrast_list{i_con};
    for i_roi = 1:length(roi_list)
        roi_out=zeros(length(ss_list),4);
        roi_name = roi_list{i_roi};
        %roi=['/mnt/tambinidata/atlas/MNI_rois/' roi_name '.nii']
        roi=['/mnt/tambinidata/sleepstudy/analysis/network_mask/' roi_name];
        %roi=['/mnt/tambinidata/atlas/Yeo_JNeurophysiol11_MNI152/100parcels/' roi_name];
        %roi=['/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/positive/' roi_name '.nii']
        %unix(['gunzip ' [roi '.gz']])
        for iss=1:length(ss_list)
            %open the subject directory and count session files 
            ss = ss_list{iss};
            ss_dir = [preproc_dir ss];
            sessions = ses_list{iss};
            sessions_dir = glob('ses*', ss_dir);
            if isempty(sessions)
                warning(['Warning, no sessions found for subject' num2str(ss) '. Please check subject IDs and the paths are correct.']);
            end
            for i_ses = sessions
                spm_dir = [char(sessions_dir(i_ses)) '/spm_os_model1_test/'];
                %spm_dir = [char(sessions_dir(i_ses)) '/spm_os_model1_load/'];
                file_str = ['*con_' contrast_name '*.nii'];
                img = char(glob(file_str,spm_dir));
                roi_out(iss, i_ses) = rex(img,roi,  'select_clusters',0);

            end
        end
        filename = [data_dir 'derivatives/group/' contrast_name '/ROI/allsub_network/' contrast_name '_' roi_name '.mat'];
        %filename = [data_dir 'derivatives/group/ospan_vs_math_load/ROI/allsub/' contrast_name '_' roi_name '.mat']
        roi_out(roi_out==0)=nan;
        save(filename,'roi_out','ss_list')
    end
end

[H,P,ci,stat]=ttest(nanmean(roi_out(:,1:4),2)) %one sample t test for all sessions

[H,P,ci,stat]=ttest(nanmean(roi_out(:,1:2:3),2)) %one sample t test for am
[H,P,ci,stat]=ttest2(nanmean(roi_out(:,1:2:3),2),nanmean(roi_out(:,2:2:4),2)) %session 1 and 3 avg & 2 4 avg

[H,P,ci,stat]=ttest(nanmean(roi_out(:,2:2:4),2)-nanmean(roi_out(:,1:2:3),2)) %session 1 and 3 avg & 2 4 avg


[H,P,ci,stat]=ttest(roi_out(:,1:2:3),roi_out(:,2:2:4)) 

[H,P,ci,stat]=ttest2(nanmean(roi_out(:,1:2:3),2),nanmean(roi_out(:,2:2:4),2)) %session 1 and 3 avg & 2 4 avg
[H,P,ci,stat]=ttest2(mean(roi_out(:,1:2:3),2),mean(roi_out(:,2:2:4),2))
[H,P,ci,stat]=ttest2(roi_out(:,1),roi_out(:,2))
[H,P,ci,stat]=ttest2(cat(1,roi_out(:,1),roi_out(:,3)),cat(1,roi_out(:,2),roi_out(:,4)))

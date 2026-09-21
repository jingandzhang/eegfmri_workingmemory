clear
load ss_info.mat
addpath /mnt/tambinidata/scripts/
roi_list = {'precuneus_tfce_mask'} %{'cluster_fdr_mask_merged','cluster_fdr_mask10','cluster_fdr_mask13','cluster_fdr_mask15','cluster_fdr_mask16','cluster_fdr_mask18','cluster_fdr_mask19'} 
contrast_list = {'0001','0002','0003','0004','0005','0006','0007','0008','0009','0010'}

for i_con = 1:length(contrast_list)
    contrast_name = contrast_list{i_con};
    for i_roi = 1:length(roi_list)
        roi_out=zeros(length(ss_list),4);
        roi_name = num2str(roi_list{i_roi});
        %roi=['/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/positive/' roi_name '.nii']
        %roi=['/mnt/tambinidata/atlas/MNI_rois/' roi_name '.nii']
        %roi=['/mnt/tambinidata/atlas/Yeo_JNeurophysiol11_MNI152/200parcels/roi_' roi_name '.nii']
        roi=['/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/negative/mask_allsessions_noCBS/' roi_name '.nii']
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
                spm_dir = [ss_dir '/ses-' num2str(i_ses) '/spm_nrem_indiv_so_fir_model1_test/'];
                file_str = ['*beta_' contrast_name '.nii'];
                %file_str = ['*con_' contrast_name '_so_nrem.nii'];
                img = char(glob(file_str,spm_dir));
                if ~isempty(img)
                    roi_out(iss, i_ses) = rex(img,roi,  'select_clusters',0);
                end
            end
        end
        filename = [data_dir 'derivatives/group/fir_indiv_so/ROI/beta_' contrast_name '_' roi_name '.mat']
        roi_out(roi_out==0)=nan;
        save(filename,'roi_out','ss_list')
    end
end


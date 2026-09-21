clear
load ss_info.mat
addpath /mnt/tambinidata/scripts/
roi_list = {'cluster_fdr_mask29'} %{'cluster_fdr_mask_merged','cluster_fdr_mask10','cluster_fdr_mask13','cluster_fdr_mask15','cluster_fdr_mask16','cluster_fdr_mask18','cluster_fdr_mask19'} 
%roi_list = num2cell(1:200)
%contrast_list = {'so_nrem'}
%roi_list = {'MNI_Post_R_Hipp_bin_Lib','MNI_Mid_R_Hipp_bin_Lib','MNI_R_Hipp_bin_Lib','MNI_Ant_R_Hipp_bin_Lib','MNI_Post_L_Hipp_bin_Lib','MNI_Mid_L_Hipp_bin_Lib','MNI_L_Hipp_bin_Lib','MNI_Ant_L_Hipp_bin_Lib','MNI_vmPFC_bin_Lib','MNI_R_Thal_bin_Lib','MNI_L_Thal_bin_Lib','MNI_R_Stri_bin_Lib','MNI_L_Stri_bin_Lib','MNI_R_Pall_bin_Lib','MNI_L_Pall_bin_Lib','MNI_R_Accu_bin_Lib','MNI_L_Accu_bin_Lib','MNI_R_Caud_bin_Lib','MNI_L_Caud_bin_Lib','MNI_R_Puta_bin_Lib','MNI_L_Puta_bin_Lib'}%{'MNI_Post_R_Hipp_bin_Lib','MNI_Mid_R_Hipp_bin_Lib','MNI_R_Hipp_bin_Lib','MNI_Ant_R_Hipp_bin_Lib','MNI_Post_L_Hipp_bin_Lib','MNI_Mid_L_Hipp_bin_Lib','MNI_L_Hipp_bin_Lib','MNI_Ant_L_Hipp_bin_Lib'}
%contrast_list = {'uncoupled','coupled_vs_uncoupled','coupled'}
contrast_list = {'0001','0002','0003','0004','0005','0006','0007','0008','0009','0010'}

for i_con = 1:length(contrast_list)
    contrast_name = contrast_list{i_con};
    for i_roi = 1:length(roi_list)
        roi_out=zeros(length(ss_list),4);
        roi_name = num2str(roi_list{i_roi});
        %roi=['/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/positive/' roi_name '.nii']
        %roi=['/mnt/tambinidata/atlas/MNI_rois/' roi_name '.nii']
        %roi=['/mnt/tambinidata/atlas/Yeo_JNeurophysiol11_MNI152/200parcels/roi_' roi_name '.nii']
        roi=['/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/negative/' roi_name '.nii']
        unix(['gunzip ' [roi '.gz']])
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
                spm_dir = [ss_dir '/ses-' num2str(i_ses) '/spm_nrem_so_fir_model1_test/'];
                file_str = ['*beta_' contrast_name '.nii'];
                %file_str = ['*con_' contrast_name '_so_nrem.nii'];
                img = char(glob(file_str,spm_dir));
                if ~isempty(img)
                    roi_out(iss, i_ses) = rex(img,roi,  'select_clusters',0);
                end
            end
        end
        filename = [data_dir 'derivatives/group/so_nrem/fir_so/ROI/beta_' contrast_name '_' roi_name '_neg.mat']
        roi_out(roi_out==0)=nan;
        save(filename,'roi_out','ss_list')
    end
end


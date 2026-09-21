load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
folder_name = 'spm_os_model1';
voi_name={'Post_R_Hipp','Post_L_Hipp','L_Caud','R_Caud','L_Puta','R_Puta','L_Stri','R_Stri','R_Hipp','L_Hipp','R_Accu','L_Accu','R_Pall','L_Pall','R_Lc','L_Lc','R_Thal','L_Thal'};
matlabbatch{1}.spm.util.voi.adjust = 0;
matlabbatch{1}.spm.util.voi.session = 1;
matlabbatch{1}.spm.util.voi.roi{1}.mask.threshold = 0.5;
matlabbatch{1}.spm.util.voi.expression = 'i1';
for iss=1:length(ss_list)
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss];
    sessions = glob('ses*', ss_dir);
    if isempty(sessions)
        warning('Warning, no sessions found. Please check subject IDs and the paths are correct.');
    end
    %loop for sessions
    for i_ses= 1:length(sessions)
        %create a 'spm_localizer_Model1' folder, located
        [filepath,name] = fileparts(char(sessions(i_ses)));
        ses = name; %session is equal to the name of the folder 
        func_dir = [ss_dir '/' ses '/func/'];
        %in data/derivatives/sub-00X/ses-X/ 
        spm_dir = [ss_dir '/' ses '/' folder_name '_test/'];
        cd(spm_dir)
        mkdir([spm_dir 'ppi/']);
        spm_mat_file=[spm_dir 'SPM.mat'];
        copyfile(spm_mat_file, 'ppi')
        spm_mat_file_ppi=[spm_dir 'ppi/SPM.mat'];
        matlabbatch{1}.spm.util.voi.spmmat=cellstr(spm_mat_file_ppi);
        for i=1:length(voi_name)
            matlabbatch{1}.spm.util.voi.name = voi_name{i};
            mask_image=strcat('/mnt/tambinidata/atlas/MNI_rois/MNI_', voi_name(i), '_bin_Lib.nii');
            matlabbatch{1}.spm.util.voi.roi{1}.mask.image=mask_image;
            spm_jobman('run',matlabbatch);
        end
    end
end


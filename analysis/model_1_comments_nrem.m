%clear
clc
clear all
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts/
% home_dir = getenv('HOME');
% data_dir = [home_dir '/train/data/'];
b_dir = [data_dir 'behav/'];

onset_dir = [analysis_dir '/so_sp_events_newsub/'];

% variables for the analysis 
Nscans = [];
Ntrs = {};
Ntrs_begin = 1; % can modify this if you don't want to start w/ the first scan 
folder_name = 'spm_nrem_model1_test';

% these are template spm jobs that we'll load in and modify  
test_specfile = glob('job_spec.mat', [analysis_dir], 0);
test_estfile = glob('job_est.mat', [analysis_dir], 0);

% Set up contrast names and associatied contrast vectors for each contrast. 
con_names = {'so_nrem','sp_nrem'};
% Each row here in 'con_vectors' contained the vector for one contrast.
% Here there were a total of 6 conditions (indicated by 6 columns) and 9
% different contrasts (indicated by the 9 rows)
con_vectors = [1 0; 0 1];
Ncons = 2;
%con_vectors = [1]%; ...
%    0 1 0 0 0 0; ...
%    0 0 1 0 0 0; ...
%    0 0 0 1 0 0; ...
%    0 0 0 0 1 0; ...
%    0 0 0 0 0 1]; 

%Ncons = length(con_names);
spm_fls = {'spmT';'con'};


%for loop for subjects 
for iss=1%:length(ss_list)
    %open the subject directory and count session files 
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss '/'];
    ss_b_dir = [b_dir ss];
    sessions = glob('ses*', ss_dir);
    if isempty(sessions)
        warning('Warning, no sessions found. Please check subject IDs and the paths are correct.');
    end
    %loop for sessions
    for i_ses= 1:2:length(sessions)
        %create a 'spm_localizer_Model1' folder, located
        [filepath,name] = fileparts(char(sessions(i_ses)));
        ses = name; %session is equal to the name of the folder 
        func_dir = [ss_dir '/' ses '/func/truncate'];
        
        scan_fls = glob(['*S1_nrem_truncated.nii'],func_dir, 0);
        Nscans = size(scan_fls,1);
        %in data/derivatives/sub-00X/ses-X/ 
        spm_dir = [ss_dir '/' ses '/' folder_name '/'];
        
        if ~isdir(spm_dir); mkdir(spm_dir); end

        % grab the nuisance file - contains nuisance signals for all scans
        nuis_file = glob('*sleep_nuisance_nrem.txt', func_dir, 0); % (using 0 as 3rd input to glob will output string)
        assert(ischar(nuis_file)==1) %make sure there is just 1 file
        
        % grab the Model 1 onset timing file for each session
        ses_b_dir = [ss_b_dir '/' ses '/'];
      
        % this chunk creates model specification job
        load(test_specfile)
        matlabbatch{1}.spm.stats.fmri_spec.dir = {spm_dir};
        fls = {};
        if ~(Nscans==1)
            for iscan = 1:Nscans
                scan_fl =scan_fls{iscan};
                Ntrs{iscan} = niftiinfo(scan_fl).ImageSize(4)
                for ivol = Ntrs_begin:Ntrs{iscan} % loop over all time points
                    fls{length(fls)+1,1} = [scan_fl ',' num2str(ivol) ''];
                end
            end
        else
             scan_fl =scan_fls;
             Ntrs{1} = niftiinfo(scan_fl).ImageSize(4)
                for ivol = Ntrs_begin:Ntrs{1} % loop over all time points
                    fls{length(fls)+1,1} = [scan_fl ',' num2str(ivol) ''];
                end
        end
        
        
        % use the onsets only with nrem events
        onset_times = glob(['onsets_' ss '_' ses '*nrem.mat'],onset_dir,0);
        assert(ischar(onset_times)==1)
        
        matlabbatch{1}.spm.stats.fmri_spec.sess.scans = fls;
        matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {onset_times}; %%%%%
        % make sure that timing_file and nuis_file are strings (char array)
        matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {nuis_file};
        matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128; % high pass filter - this is common (~.008 Hz)
        matlabbatch{1}.spm.stats.fmri_spec.mthresh = -Inf; % modify if you want to use spm's automatic mask - try 0.5
%          fls_zip = glob(['*combined-mask.nii.gz'], ss_dir);
%             if not(isempty(fls_zip))
%                 for ifile = 1:length(fls_zip)
%                     unix(['gunzip ' fls_zip{ifile}]) %need permission
%                 end
%             else %if you do not find any of these files move onto next task
%                 warning(['No mask files were found, continuing to next task.']);
%             end
        %glob('*combined-mask.nii', [ss_dir],0)
        mask_zip = glob('*combined-mask.nii.gz', [ss_dir],0);
        if not(isempty(mask_zip))
            unix(['gunzip ' mask_zip]) %need permission
        else %if you do not find any of these files move onto next task
            warning(['No zip masks were found.']);
        end
        if isempty(glob('*combined-mask.nii', [ss_dir],0))
            error(['no mask found in' ss_dir])
        end
        matlabbatch{1}.spm.stats.fmri_spec.mask = {glob('*combined-mask.nii', [ss_dir],0)}; % delete if you don't want ot use a pre-determined mask

        % save model specification job
        save([spm_dir 'job_model_spec.mat'],'matlabbatch')

        % run model specification job
        spm('defaults','fmri');
        spm_jobman('initcfg');
        spm_jobman('run',matlabbatch);
        
        % show design matrix
         load([spm_dir 'SPM.mat'])
         figure;imagesc(SPM.xX.X);colorbar
         title('design matrix BEFORE running concatenate function')

        % concatenate conditions from different scans together
        if ~(Nscans==1)
            spm_fmri_concatenate([spm_dir 'SPM.mat'], cat(1,cell2mat(Ntrs)));
            % show design matrix
             load([spm_dir 'SPM.mat'])
             figure;imagesc(SPM.xX.X);colorbar
             title('design matrix AFTER running concatenate function')
        end

        % create model estimation job
        load(test_estfile)
        matlabbatch{1}.spm.stats.fmri_est.spmmat = {[spm_dir 'SPM.mat']};
        save([spm_dir 'job_model_est.mat'],'matlabbatch')

        % run model estimation job
        spm('defaults','fmri');
        spm_jobman('initcfg');
        spm_jobman('run',matlabbatch);

        % create contrast estimation job 
        clear matlabbatch
        matlabbatch{1}.spm.stats.con.spmmat = {[spm_dir 'SPM.mat']};
        for icon = 1:Ncons 
            matlabbatch{1}.spm.stats.con.consess{icon}.tcon.name = con_names{icon};
            matlabbatch{1}.spm.stats.con.consess{icon}.tcon.weights = con_vectors(icon,:);
            matlabbatch{1}.spm.stats.con.consess{icon}.tcon.sessrep = 'none';
        end
        matlabbatch{1}.spm.stats.con.delete = 1;

        % run contrast estimation job
        spm('defaults','fmri');
        spm_jobman('initcfg');
        spm_jobman('run',matlabbatch);

        % copy contrast files into contrast directory
        for ifltype = 1:length(spm_fls)
            for icon = 1:Ncons
                if icon > 9
                    fl = glob([spm_fls{ifltype} '_00' num2str(icon) '*'], spm_dir, 0);
                else
                    fl = glob([spm_fls{ifltype} '_000' num2str(icon) '*'], spm_dir, 0);
                end
                unix(['cp -rp ' fl ' ' spm_dir ss '_' ses '_' spm_fls{ifltype} '_' con_names{icon} '.nii'])
            end
        end
    end
end


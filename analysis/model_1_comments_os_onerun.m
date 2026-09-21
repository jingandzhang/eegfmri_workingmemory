%clear
clc
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
addpath /mnt/tambinidata/scripts/
% home_dir = getenv('HOME');
% data_dir = [home_dir '/train/data/'];
b_dir = [data_dir 'behav/'];

% variables for the analysis 
Nscans = 1;
Ntrs = 216;
Ntrs_begin = 1; % can modify this if you don't want to start w/ the first scan 
folder_name = 'spm_os_model1';

% these are template spm jobs that we'll load in and modify  
test_specfile = glob('job_spec.mat', [analysis_dir], 0);
test_estfile = glob('job_est.mat', [analysis_dir], 0);

% Set up contrast names and associatied contrast vectors for each contrast. 
con_names = {'ospan_vs_baseline';'math_vs_baseline';'ospan_vs_math'};
% Each row here in 'con_vectors' contained the vector for one contrast.
% Here there were a total of 6 conditions (indicated by 6 columns) and 9
% different contrasts (indicated by the 9 rows)

con_vectors = [1 0 0; ...
   0 0 1; ...
   1 0 -1]; 

Ncons = length(con_names);
spm_fls = {'spmT';'con'};
%%
%for loop for subjects 
for iss=36 %1:length(ss_list)
    %%
    %open the subject directory and count session files 
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss];
    ss_b_dir = [b_dir ss];
    sessions = glob('ses*', ss_dir);
    if isempty(sessions)
        warning('Warning, no sessions found. Please check subject IDs and the paths are correct.');
    end
    %loop for sessions
    for i_ses=2
        %create a 'spm_localizer_Model1' folder, located
        [filepath,name] = fileparts(char(sessions(i_ses)));
        ses = name; %session is equal to the name of the folder 
        func_dir = [ss_dir '/' ses '/func/'];
        %in data/derivatives/sub-00X/ses-X/ 
        spm_dir = [ss_dir '/' ses '/' folder_name '_test/'];

        if ~isdir(spm_dir); mkdir(spm_dir); end

        % grab the nuisance file - contains nuisance signals for all scans
        nuis_file = glob('*os_nuisance_test.txt', func_dir, 0); % (using 0 as 3rd input to glob will output string)
        assert(ischar(nuis_file)==1) %make sure there is just 1 file
        
        % grab the Model 1 onset timing file for each session
        ses_b_dir = [ss_b_dir '/' ses '/'];
        onset_times = glob('*os_onsets_onerun*',analysis_dir,0);
        assert(ischar(onset_times)==1)
        
        % this chunk creates model specification job
        load(test_specfile)
        matlabbatch{1}.spm.stats.fmri_spec.dir = {spm_dir};
        fls = {};
        for iscan = 2 %1:Nscans
            % modify to grab the data for each of the localizer scans per
            % session
            scan_fl = glob([ss '_' ses '_' 'task-os_run-0' num2str(iscan) '_*' '_S1.nii'],...
                func_dir, 0);
            for ivol = Ntrs_begin:Ntrs % loop over all time points
                fls{length(fls)+1,1} = [scan_fl ',' num2str(ivol) ''];
            end
        end
        
        matlabbatch{1}.spm.stats.fmri_spec.sess.scans = fls;
        matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {onset_times}; % make sure that timing_file and nuis_file are strings (char array)
        matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {nuis_file};
        matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128; % high pass filter - this is common (~.008 Hz)
        matlabbatch{1}.spm.stats.fmri_spec.mthresh = -Inf; % modify if you want to use spm's automatic mask - try 0.5
        fls_zip = glob(['*combined-mask.nii.gz'], ss_dir);
            if not(isempty(fls_zip))
                for ifile = 1:length(fls_zip)
                    unix(['gunzip ' fls_zip{ifile}]) %need permission
                end
            else %if you do not find any of these files move onto next task
                warning(['No mask files were found, continuing to next task.']);
            end
        matlabbatch{1}.spm.stats.fmri_spec.mask = {glob('*combined-mask.nii', [ss_dir],0)}; % delete if you don't want ot use a pre-determined mask

        % save model specification job
        mkdir(spm_dir);
        save([spm_dir 'job_model_spec.mat'],'matlabbatch')

        % run model specification job
        spm('defaults','fmri');
        spm_jobman('initcfg');
        spm_jobman('run',matlabbatch);
        
        % show design matrix
%         load([spm_dir 'SPM.mat'])
%         figure;imagesc(SPM.xX.X);colorbar
%         title('design matrix BEFORE running concatenate function')

        % concatenate conditions from different scans together
        spm_fmri_concatenate([spm_dir 'SPM.mat'], Ntrs*ones(1,Nscans)); %%% we are here
        
        % show design matrix
%         load([spm_dir 'SPM.mat'])
%         figure;imagesc(SPM.xX.X);colorbar
%         title('design matrix AFTER running concatenate function')

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
            matlabbatch{1}.spm.stats.con.consess{icon}.tcon.weights = con_vectors(icon,:)';
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


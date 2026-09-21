clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts/
folder_name = 'spm_nrem_indiv_so_model1';
%voi_name={'R_Hipp','L_Hipp','R_Thal','L_Thal','vmPFC','Post_R_Hipp','Post_L_Hipp','Mid_R_Hipp','Mid_L_Hipp','Ant_R_Hipp','Ant_L_Hipp','L_Puta','R_Puta','L_Stri','R_Stri','R_Hipp','L_Hipp','R_Accu','L_Accu','R_Pall','L_Pall','R_Lc','L_Lc','R_Thal','L_Thal'};
%voi_name={'L_Puta','R_Puta','L_Stri','R_Stri','R_Accu','L_Accu','R_Pall','L_Pall','R_Lc','L_Lc','R_Caud','L_Caud'};
% 
matlabbatch{1}.spm.util.voi.adjust = 0;%,'L_Puta','R_Puta','L_Stri','R_Stri','R_Hipp','L_Hipp','R_Accu','L_Accu','R_Pall','L_Pall','R_Lc','L_Lc','R_Thal','L_Thal'};

matlabbatch{1}.spm.util.voi.adjust = 0;
matlabbatch{1}.spm.util.voi.session = 1;
matlabbatch{1}.spm.util.voi.roi{1}.mask.threshold = 0.5;
matlabbatch{1}.spm.util.voi.expression = 'i1';
for iss=length(ss_list)
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss '/'];
    sessions = glob('ses*', ss_dir);
    if isempty(sessions)
        warning('Warning, no sessions found. Please check subject IDs and the paths are correct.');
    end
    %loop for sessions
    for i_ses= 1:2:length(sessions)
        %create a 'spm_localizer_Model1' folder, located
        [filepath,name] = fileparts(char(sessions(i_ses)));
        ses = name; %session is equal to the name of the folder 
        func_dir = [ss_dir '/' ses '/func/'];
        %in data/derivatives/sub-00X/ses-X/ 
        spm_dir = [ss_dir '/' ses '/' folder_name '_test/'];
        cd(spm_dir)
%         mkdir([spm_dir 'ppi/']);
        spm_mat_file=[spm_dir 'SPM.mat'];

            ppi_dir = [ss_dir '/' ses '/' folder_name '_voi_precuneus/'];
            if ~isfolder(ppi_dir); mkdir(ppi_dir); end
            copyfile(spm_mat_file, ppi_dir)

            spm_mat_file_ppi=[ppi_dir 'SPM.mat'];
            matlabbatch{1}.spm.util.voi.spmmat=cellstr(spm_mat_file_ppi);
            matlabbatch{1}.spm.util.voi.name = 'precuneus_tfce_mask.nii';
            mask_image={'/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/negative/mask_allsessions_noCBS/precuneus_tfce_mask.nii'};
            matlabbatch{1}.spm.util.voi.roi{1}.mask.image=mask_image;
            spm_jobman('run',matlabbatch);

    end
end


%%
clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts

folder_name = 'spm_nrem_indiv_so_model1';
voi_list= {'precuneus'};
%{'L_Caud','R_Caud','L_Puta','R_Puta','L_Stri','R_Stri','R_Accu','L_Accu','R_Pall','L_Pall','R_Lc','L_Lc'};%{'Post_R_Hipp','Post_L_Hipp','Mid_R_Hipp','Mid_L_Hipp','Ant_R_Hipp','Ant_L_Hipp'};
%,'L_Caud','R_Caud','L_Puta','R_Puta','L_Stri','R_Stri','R_Hipp','L_Hipp','R_Accu','L_Accu','R_Pall','L_Pall','R_Lc','L_Lc','R_Thal','L_Thal'};
Ntrs = {};
Nscans = [];


for iss=3%length(ss_list)
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss];
    sessions = glob('ses*', ss_dir);
    if isempty(sessions)
        warning('Warning, no sessions found. Please check subject IDs and the paths are correct.');
    end

    %loop for sessions
    for i_ses= 1:2:length(sessions)
        %%
        [filepath,name] = fileparts(char(sessions(i_ses)));
        ses = name; %session is equal to the name of the folder 
        func_dir = [ss_dir '/' ses '/func/truncate'];
        %in data/derivatives/sub-00X/ses-X/ 
        spm_dir = [ss_dir '/' ses '/' folder_name '_test/'];
%%
        for i=1:length(voi_list)
            voi_name = voi_list{i};
            ppi_dir = [ss_dir '/' ses '/' folder_name '_ppi_' voi_name '/'];
            voi_dir = [ss_dir '/' ses '/' folder_name '_voi_' voi_name '/'];
            mkdir(ppi_dir)
            nuis_file = glob('*sleep_nuisance_nrem.txt', func_dir, 0);
            spm_mat_file=[voi_dir 'SPM.mat'];
            
            matlabbatch{1}.spm.stats.ppi.spmmat = {spm_mat_file};
%             matlabbatch{1}.spm.stats.ppi.type.ppi.voi = {[voi_dir '/VOI_' voi_name '_1.mat']};
            matlabbatch{1}.spm.stats.ppi.type.ppi.voi = {[voi_dir '/VOI_' voi_name '_tfce_mask_1.mat']};
            
            matlabbatch{1}.spm.stats.ppi.type.ppi.u = [1 1 1
                                                       2 1 0];%so: 1 0 %sp: 0 1
            matlabbatch{1}.spm.stats.ppi.name = voi_name;
            matlabbatch{1}.spm.stats.ppi.disp = 1;
            spm_jobman('run',matlabbatch);
            
            %%
            clear matlabbatch
            %this will returm a ppi.mat for next steps
            %%%%%%%%%%%%%%%%
            
%             spm_mat_file=[ppi_dir 'SPM.mat'];
%             copyfile(spm_mat_file_og, spm_mat_file)
%             load(spm_mat_file)
%             SPM.swd = ppi_dir(1:end-1);
%             save(spm_mat_file, 'SPM')
            
            load ([voi_dir 'PPI_' voi_name '.mat'])%load PPI mat for that voi
            matlabbatch{1}.spm.stats.fmri_spec.dir = {[ppi_dir]};
            matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
            matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2.24;
            matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
            matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
            
            
            %%
            %load nii
            scan_fls = glob(['*S1_nrem_truncated.nii'],func_dir, 0);
            Nscans = size(scan_fls,1);
            fls = {};
            if ~(Nscans==1)
                for iscan = 1:Nscans
                    scan_fl =scan_fls{iscan};
                    Ntrs{iscan} = niftiinfo(scan_fl).ImageSize(4)
                    for ivol = 1:Ntrs{iscan} % loop over all time points
                        fls{length(fls)+1,1} = [scan_fl ',' num2str(ivol) ''];
                    end
                end
            else
                 scan_fl =scan_fls;
                 Ntrs{1} = niftiinfo(scan_fl).ImageSize(4)
                    for ivol = 1:Ntrs{1} % loop over all time points
                        fls{length(fls)+1,1} = [scan_fl ',' num2str(ivol) ''];
                    end
            end
            matlabbatch{1}.spm.stats.fmri_spec.sess.scans = fls;
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
            matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(1).name = 'PPI_interaction';
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(1).val = PPI.ppi;
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(2).name = voi_name;
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(2).val = PPI.Y; 
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(3).name = 'so_nrem';
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(3).val = PPI.P;
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {nuis_file};
            matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
            matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
            matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
            matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
            matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
            matlabbatch{1}.spm.stats.fmri_spec.mthresh = -Inf;
            matlabbatch{1}.spm.stats.fmri_spec.mask = {glob('*combined-mask.nii', [ss_dir],0)};
            matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
            matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
            spm_jobman('run',matlabbatch);
            clear matlabbatch
            
            
            % concatenate conditions from different scans together
            if ~(Nscans==1)
                spm_fmri_concatenate([ppi_dir 'SPM.mat'], cat(1,cell2mat(Ntrs)));
            end
            
            matlabbatch{1}.spm.stats.fmri_est.spmmat = {[ppi_dir '/SPM.mat']};%cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
            matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
            matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
            
            matlabbatch{2}.spm.stats.con.spmmat = {[ppi_dir '/SPM.mat']}; %cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
            matlabbatch{2}.spm.stats.con.consess{1}.tcon.name = [voi_name '_PPI_Interaction'];
            matlabbatch{2}.spm.stats.con.consess{1}.tcon.weights = 1;
            matlabbatch{2}.spm.stats.con.consess{1}.tcon.sessrep = 'none';            
             matlabbatch{2}.spm.stats.con.consess{2}.tcon.name = [voi_name '_PPI_Conn'];
             matlabbatch{2}.spm.stats.con.consess{2}.tcon.weights = [0 1 0];
             matlabbatch{2}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
            
            matlabbatch{2}.spm.stats.con.delete = 0;
            
            spm_jobman('run',matlabbatch);
            clear matlabbatch
            
        end
    end
end
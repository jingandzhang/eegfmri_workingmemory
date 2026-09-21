clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
addpath /mnt/tambinidata/scripts/
folder_name = 'spm_os_model1';
voi_name={'precuneus'};%'Post_R_Hipp','Post_L_Hipp','L_Caud','R_Caud','L_Puta','R_Puta','L_Stri','R_Stri','R_Hipp','L_Hipp','R_Accu','L_Accu','R_Pall','L_Pall','R_Lc','L_Lc','R_Thal','L_Thal'};
matlabbatch{1}.spm.util.voi.adjust = 0;
matlabbatch{1}.spm.util.voi.session = 1;
matlabbatch{1}.spm.util.voi.roi{1}.mask.threshold = 0.5;
matlabbatch{1}.spm.util.voi.expression = 'i1';
for iss=36%36:length(ss_list)
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss '/'];
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
%         mkdir([spm_dir 'ppi/']);
        spm_mat_file=[spm_dir 'SPM.mat'];
        for i=1:length(voi_name)
            
            ppi_dir = [ss_dir '/' ses '/' folder_name '_voi_' voi_name{i} '/'];
            if ~isfolder(ppi_dir); mkdir(ppi_dir); end
            copyfile(spm_mat_file, ppi_dir)

            spm_mat_file_ppi=[ppi_dir 'SPM.mat'];
            matlabbatch{1}.spm.util.voi.spmmat=cellstr(spm_mat_file_ppi);
            matlabbatch{1}.spm.util.voi.name = voi_name{i};
            mask_image={'/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/negative/mask_allsessions_noCBS/precuneus_tfce_mask.nii'};
            matlabbatch{1}.spm.util.voi.roi{1}.mask.image=mask_image;
            spm_jobman('run',matlabbatch);
        end
    end
end


%%
clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
addpath /mnt/tambinidata/scripts

folder_name = 'spm_os_model1';
voi_list= {'precuneus'};
Ntrs = 216;
Nscans = 2;


for iss=36% 40:length(ss_list)
    
    
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss];
    sessions = glob('ses*', ss_dir);
    if isempty(sessions)
        warning('Warning, no sessions found. Please check subject IDs and the paths are correct.');
    end

    
    %loop for sessions
    for i_ses= 4%1:length(sessions)
        %%
        %create a 'spm_localizer_Model1' folder, located
        [filepath,name] = fileparts(char(sessions(i_ses)));
        ses = name; %session is equal to the name of the folder 
        func_dir = [ss_dir '/' ses '/func/'];
        %in data/derivatives/sub-00X/ses-X/ 
        spm_dir = [ss_dir '/' ses '/' folder_name '_test/'];
%%
        for i=1:length(voi_list)
            voi_name = voi_list{i};
            ppi_dir = [ss_dir '/' ses '/' folder_name '_ppi_' voi_name '/'];
            voi_dir = [ss_dir '/' ses '/' folder_name '_voi_' voi_name '/'];
            mkdir(ppi_dir)
            
            spm_mat_file=[voi_dir 'SPM.mat'];
            
            matlabbatch{1}.spm.stats.ppi.spmmat = {spm_mat_file};
            matlabbatch{1}.spm.stats.ppi.type.ppi.voi = {[voi_dir '/VOI_' voi_name '_1.mat']};
            matlabbatch{1}.spm.stats.ppi.type.ppi.u = [1 1 1
                                                       2 1 0
                                                       3 1 -1
                                                       4 1 0];
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
            run1_scan = [func_dir ss '_' ses '_task-os_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold_S1.nii']
            run2_scan = [func_dir ss '_' ses '_task-os_run-02_space-MNI152NLin2009cAsym_desc-preproc_bold_S1.nii']
           
            matlabbatch{1}.spm.stats.fmri_spec.sess.scans ={
                                                             [run1_scan ',1']
                                                             [run1_scan ',2']
                                                             [run1_scan ',3']
                                                             [run1_scan ',4']
                                                             [run1_scan ',5']
                                                             [run1_scan ',6']
                                                             [run1_scan ',7']
                                                             [run1_scan ',8']
                                                             [run1_scan ',9']
                                                             [run1_scan ',10']
                                                             [run1_scan ',11']
                                                             [run1_scan ',12']
                                                             [run1_scan ',13']
                                                             [run1_scan ',14']
                                                             [run1_scan ',15']
                                                             [run1_scan ',16']
                                                             [run1_scan ',17']
                                                             [run1_scan ',18']
                                                             [run1_scan ',19']
                                                             [run1_scan ',20']
                                                             [run1_scan ',21']
                                                             [run1_scan ',22']
                                                             [run1_scan ',23']
                                                             [run1_scan ',24']
                                                             [run1_scan ',25']
                                                             [run1_scan ',26']
                                                             [run1_scan ',27']
                                                             [run1_scan ',28']
                                                             [run1_scan ',29']
                                                             [run1_scan ',30']
                                                             [run1_scan ',31']
                                                             [run1_scan ',32']
                                                             [run1_scan ',33']
                                                             [run1_scan ',34']
                                                             [run1_scan ',35']
                                                             [run1_scan ',36']
                                                             [run1_scan ',37']
                                                             [run1_scan ',38']
                                                             [run1_scan ',39']
                                                             [run1_scan ',40']
                                                             [run1_scan ',41']
                                                             [run1_scan ',42']
                                                             [run1_scan ',43']
                                                             [run1_scan ',44']
                                                             [run1_scan ',45']
                                                             [run1_scan ',46']
                                                             [run1_scan ',47']
                                                             [run1_scan ',48']
                                                             [run1_scan ',49']
                                                             [run1_scan ',50']
                                                             [run1_scan ',51']
                                                             [run1_scan ',52']
                                                             [run1_scan ',53']
                                                             [run1_scan ',54']
                                                             [run1_scan ',55']
                                                             [run1_scan ',56']
                                                             [run1_scan ',57']
                                                             [run1_scan ',58']
                                                             [run1_scan ',59']
                                                             [run1_scan ',60']
                                                             [run1_scan ',61']
                                                             [run1_scan ',62']
                                                             [run1_scan ',63']
                                                             [run1_scan ',64']
                                                             [run1_scan ',65']
                                                             [run1_scan ',66']
                                                             [run1_scan ',67']
                                                             [run1_scan ',68']
                                                             [run1_scan ',69']
                                                             [run1_scan ',70']
                                                             [run1_scan ',71']
                                                             [run1_scan ',72']
                                                             [run1_scan ',73']
                                                             [run1_scan ',74']
                                                             [run1_scan ',75']
                                                             [run1_scan ',76']
                                                             [run1_scan ',77']
                                                             [run1_scan ',78']
                                                             [run1_scan ',79']
                                                             [run1_scan ',80']
                                                             [run1_scan ',81']
                                                             [run1_scan ',82']
                                                             [run1_scan ',83']
                                                             [run1_scan ',84']
                                                             [run1_scan ',85']
                                                             [run1_scan ',86']
                                                             [run1_scan ',87']
                                                             [run1_scan ',88']
                                                             [run1_scan ',89']
                                                             [run1_scan ',90']
                                                             [run1_scan ',91']
                                                             [run1_scan ',92']
                                                             [run1_scan ',93']
                                                             [run1_scan ',94']
                                                             [run1_scan ',95']
                                                             [run1_scan ',96']
                                                             [run1_scan ',97']
                                                             [run1_scan ',98']
                                                             [run1_scan ',99']
                                                             [run1_scan ',100']
                                                             [run1_scan ',101']
                                                             [run1_scan ',102']
                                                             [run1_scan ',103']
                                                             [run1_scan ',104']
                                                             [run1_scan ',105']
                                                             [run1_scan ',106']
                                                             [run1_scan ',107']
                                                             [run1_scan ',108']
                                                             [run1_scan ',109']
                                                             [run1_scan ',110']
                                                             [run1_scan ',111']
                                                             [run1_scan ',112']
                                                             [run1_scan ',113']
                                                             [run1_scan ',114']
                                                             [run1_scan ',115']
                                                             [run1_scan ',116']
                                                             [run1_scan ',117']
                                                             [run1_scan ',118']
                                                             [run1_scan ',119']
                                                             [run1_scan ',120']
                                                             [run1_scan ',121']
                                                             [run1_scan ',122']
                                                             [run1_scan ',123']
                                                             [run1_scan ',124']
                                                             [run1_scan ',125']
                                                             [run1_scan ',126']
                                                             [run1_scan ',127']
                                                             [run1_scan ',128']
                                                             [run1_scan ',129']
                                                             [run1_scan ',130']
                                                             [run1_scan ',131']
                                                             [run1_scan ',132']
                                                             [run1_scan ',133']
                                                             [run1_scan ',134']
                                                             [run1_scan ',135']
                                                             [run1_scan ',136']
                                                             [run1_scan ',137']
                                                             [run1_scan ',138']
                                                             [run1_scan ',139']
                                                             [run1_scan ',140']
                                                             [run1_scan ',141']
                                                             [run1_scan ',142']
                                                             [run1_scan ',143']
                                                             [run1_scan ',144']
                                                             [run1_scan ',145']
                                                             [run1_scan ',146']
                                                             [run1_scan ',147']
                                                             [run1_scan ',148']
                                                             [run1_scan ',149']
                                                             [run1_scan ',150']
                                                             [run1_scan ',151']
                                                             [run1_scan ',152']
                                                             [run1_scan ',153']
                                                             [run1_scan ',154']
                                                             [run1_scan ',155']
                                                             [run1_scan ',156']
                                                             [run1_scan ',157']
                                                             [run1_scan ',158']
                                                             [run1_scan ',159']
                                                             [run1_scan ',160']
                                                             [run1_scan ',161']
                                                             [run1_scan ',162']
                                                             [run1_scan ',163']
                                                             [run1_scan ',164']
                                                             [run1_scan ',165']
                                                             [run1_scan ',166']
                                                             [run1_scan ',167']
                                                             [run1_scan ',168']
                                                             [run1_scan ',169']
                                                             [run1_scan ',170']
                                                             [run1_scan ',171']
                                                             [run1_scan ',172']
                                                             [run1_scan ',173']
                                                             [run1_scan ',174']
                                                             [run1_scan ',175']
                                                             [run1_scan ',176']
                                                             [run1_scan ',177']
                                                             [run1_scan ',178']
                                                             [run1_scan ',179']
                                                             [run1_scan ',180']
                                                             [run1_scan ',181']
                                                             [run1_scan ',182']
                                                             [run1_scan ',183']
                                                             [run1_scan ',184']
                                                             [run1_scan ',185']
                                                             [run1_scan ',186']
                                                             [run1_scan ',187']
                                                             [run1_scan ',188']
                                                             [run1_scan ',189']
                                                             [run1_scan ',190']
                                                             [run1_scan ',191']
                                                             [run1_scan ',192']
                                                             [run1_scan ',193']
                                                             [run1_scan ',194']
                                                             [run1_scan ',195']
                                                             [run1_scan ',196']
                                                             [run1_scan ',197']
                                                             [run1_scan ',198']
                                                             [run1_scan ',199']
                                                             [run1_scan ',200']
                                                             [run1_scan ',201']
                                                             [run1_scan ',202']
                                                             [run1_scan ',203']
                                                             [run1_scan ',204']
                                                             [run1_scan ',205']
                                                             [run1_scan ',206']
                                                             [run1_scan ',207']
                                                             [run1_scan ',208']
                                                             [run1_scan ',209']
                                                             [run1_scan ',210']
                                                             [run1_scan ',211']
                                                             [run1_scan ',212']
                                                             [run1_scan ',213']
                                                             [run1_scan ',214']
                                                             [run1_scan ',215']
                                                             [run1_scan ',216']
                                                             [run2_scan ',1']
                                                             [run2_scan ',2']
                                                             [run2_scan ',3']
                                                             [run2_scan ',4']
                                                             [run2_scan ',5']
                                                             [run2_scan ',6']
                                                             [run2_scan ',7']
                                                             [run2_scan ',8']
                                                             [run2_scan ',9']
                                                             [run2_scan ',10']
                                                             [run2_scan ',11']
                                                             [run2_scan ',12']
                                                             [run2_scan ',13']
                                                             [run2_scan ',14']
                                                             [run2_scan ',15']
                                                             [run2_scan ',16']
                                                             [run2_scan ',17']
                                                             [run2_scan ',18']
                                                             [run2_scan ',19']
                                                             [run2_scan ',20']
                                                             [run2_scan ',21']
                                                             [run2_scan ',22']
                                                             [run2_scan ',23']
                                                             [run2_scan ',24']
                                                             [run2_scan ',25']
                                                             [run2_scan ',26']
                                                             [run2_scan ',27']
                                                             [run2_scan ',28']
                                                             [run2_scan ',29']
                                                             [run2_scan ',30']
                                                             [run2_scan ',31']
                                                             [run2_scan ',32']
                                                             [run2_scan ',33']
                                                             [run2_scan ',34']
                                                             [run2_scan ',35']
                                                             [run2_scan ',36']
                                                             [run2_scan ',37']
                                                             [run2_scan ',38']
                                                             [run2_scan ',39']
                                                             [run2_scan ',40']
                                                             [run2_scan ',41']
                                                             [run2_scan ',42']
                                                             [run2_scan ',43']
                                                             [run2_scan ',44']
                                                             [run2_scan ',45']
                                                             [run2_scan ',46']
                                                             [run2_scan ',47']
                                                             [run2_scan ',48']
                                                             [run2_scan ',49']
                                                             [run2_scan ',50']
                                                             [run2_scan ',51']
                                                             [run2_scan ',52']
                                                             [run2_scan ',53']
                                                             [run2_scan ',54']
                                                             [run2_scan ',55']
                                                             [run2_scan ',56']
                                                             [run2_scan ',57']
                                                             [run2_scan ',58']
                                                             [run2_scan ',59']
                                                             [run2_scan ',60']
                                                             [run2_scan ',61']
                                                             [run2_scan ',62']
                                                             [run2_scan ',63']
                                                             [run2_scan ',64']
                                                             [run2_scan ',65']
                                                             [run2_scan ',66']
                                                             [run2_scan ',67']
                                                             [run2_scan ',68']
                                                             [run2_scan ',69']
                                                             [run2_scan ',70']
                                                             [run2_scan ',71']
                                                             [run2_scan ',72']
                                                             [run2_scan ',73']
                                                             [run2_scan ',74']
                                                             [run2_scan ',75']
                                                             [run2_scan ',76']
                                                             [run2_scan ',77']
                                                             [run2_scan ',78']
                                                             [run2_scan ',79']
                                                             [run2_scan ',80']
                                                             [run2_scan ',81']
                                                             [run2_scan ',82']
                                                             [run2_scan ',83']
                                                             [run2_scan ',84']
                                                             [run2_scan ',85']
                                                             [run2_scan ',86']
                                                             [run2_scan ',87']
                                                             [run2_scan ',88']
                                                             [run2_scan ',89']
                                                             [run2_scan ',90']
                                                             [run2_scan ',91']
                                                             [run2_scan ',92']
                                                             [run2_scan ',93']
                                                             [run2_scan ',94']
                                                             [run2_scan ',95']
                                                             [run2_scan ',96']
                                                             [run2_scan ',97']
                                                             [run2_scan ',98']
                                                             [run2_scan ',99']
                                                             [run2_scan ',100']
                                                             [run2_scan ',101']
                                                             [run2_scan ',102']
                                                             [run2_scan ',103']
                                                             [run2_scan ',104']
                                                             [run2_scan ',105']
                                                             [run2_scan ',106']
                                                             [run2_scan ',107']
                                                             [run2_scan ',108']
                                                             [run2_scan ',109']
                                                             [run2_scan ',110']
                                                             [run2_scan ',111']
                                                             [run2_scan ',112']
                                                             [run2_scan ',113']
                                                             [run2_scan ',114']
                                                             [run2_scan ',115']
                                                             [run2_scan ',116']
                                                             [run2_scan ',117']
                                                             [run2_scan ',118']
                                                             [run2_scan ',119']
                                                             [run2_scan ',120']
                                                             [run2_scan ',121']
                                                             [run2_scan ',122']
                                                             [run2_scan ',123']
                                                             [run2_scan ',124']
                                                             [run2_scan ',125']
                                                             [run2_scan ',126']
                                                             [run2_scan ',127']
                                                             [run2_scan ',128']
                                                             [run2_scan ',129']
                                                             [run2_scan ',130']
                                                             [run2_scan ',131']
                                                             [run2_scan ',132']
                                                             [run2_scan ',133']
                                                             [run2_scan ',134']
                                                             [run2_scan ',135']
                                                             [run2_scan ',136']
                                                             [run2_scan ',137']
                                                             [run2_scan ',138']
                                                             [run2_scan ',139']
                                                             [run2_scan ',140']
                                                             [run2_scan ',141']
                                                             [run2_scan ',142']
                                                             [run2_scan ',143']
                                                             [run2_scan ',144']
                                                             [run2_scan ',145']
                                                             [run2_scan ',146']
                                                             [run2_scan ',147']
                                                             [run2_scan ',148']
                                                             [run2_scan ',149']
                                                             [run2_scan ',150']
                                                             [run2_scan ',151']
                                                             [run2_scan ',152']
                                                             [run2_scan ',153']
                                                             [run2_scan ',154']
                                                             [run2_scan ',155']
                                                             [run2_scan ',156']
                                                             [run2_scan ',157']
                                                             [run2_scan ',158']
                                                             [run2_scan ',159']
                                                             [run2_scan ',160']
                                                             [run2_scan ',161']
                                                             [run2_scan ',162']
                                                             [run2_scan ',163']
                                                             [run2_scan ',164']
                                                             [run2_scan ',165']
                                                             [run2_scan ',166']
                                                             [run2_scan ',167']
                                                             [run2_scan ',168']
                                                             [run2_scan ',169']
                                                             [run2_scan ',170']
                                                             [run2_scan ',171']
                                                             [run2_scan ',172']
                                                             [run2_scan ',173']
                                                             [run2_scan ',174']
                                                             [run2_scan ',175']
                                                             [run2_scan ',176']
                                                             [run2_scan ',177']
                                                             [run2_scan ',178']
                                                             [run2_scan ',179']
                                                             [run2_scan ',180']
                                                             [run2_scan ',181']
                                                             [run2_scan ',182']
                                                             [run2_scan ',183']
                                                             [run2_scan ',184']
                                                             [run2_scan ',185']
                                                             [run2_scan ',186']
                                                             [run2_scan ',187']
                                                             [run2_scan ',188']
                                                             [run2_scan ',189']
                                                             [run2_scan ',190']
                                                             [run2_scan ',191']
                                                             [run2_scan ',192']
                                                             [run2_scan ',193']
                                                             [run2_scan ',194']
                                                             [run2_scan ',195']
                                                             [run2_scan ',196']
                                                             [run2_scan ',197']
                                                             [run2_scan ',198']
                                                             [run2_scan ',199']
                                                             [run2_scan ',200']
                                                             [run2_scan ',201']
                                                             [run2_scan ',202']
                                                             [run2_scan ',203']
                                                             [run2_scan ',204']
                                                             [run2_scan ',205']
                                                             [run2_scan ',206']
                                                             [run2_scan ',207']
                                                             [run2_scan ',208']
                                                             [run2_scan ',209']
                                                             [run2_scan ',210']
                                                             [run2_scan ',211']
                                                             [run2_scan ',212']
                                                             [run2_scan ',213']
                                                             [run2_scan ',214']
                                                             [run2_scan ',215']
                                                             [run2_scan ',216']
                                                             };

            
            matlabbatch{1}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
            matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(1).name = 'PPI_interaction';
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(1).val = PPI.ppi;
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(2).name = voi_name;
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(2).val = PPI.Y; 
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(3).name = 'ospan_vs_math';
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.regress(3).val = PPI.P;
            
%             matlabbatch{1}.spm.stats.fmri_spec.sess.regress(4).name = 'block1';
%             
%             matlabbatch{1}.spm.stats.fmri_spec.sess.regress(4).val = kron([1 0]',ones(216,1))
            
            matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {[func_dir ss '_' ses '_' 'task-os_nuisance_test.txt']};
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
            spm_fmri_concatenate([ppi_dir 'SPM.mat'], Ntrs*ones(1,Nscans)); %%

            
            matlabbatch{1}.spm.stats.fmri_est.spmmat = {[ppi_dir '/SPM.mat']};%cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
            matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
            matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
            
            matlabbatch{2}.spm.stats.con.spmmat = {[ppi_dir '/SPM.mat']}; %cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
            matlabbatch{2}.spm.stats.con.consess{1}.tcon.name = [voi_name '_PPI_Interaction'];
            matlabbatch{2}.spm.stats.con.consess{1}.tcon.weights = 1;
            matlabbatch{2}.spm.stats.con.consess{1}.tcon.sessrep = 'none';            
            matlabbatch{2}.spm.stats.con.consess{2}.tcon.name = [voi_name '_PPI_Conn'];
            matlabbatch{2}.spm.stats.con.consess{2}.tcon.weights = [0 1 0 0];
            matlabbatch{2}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
            
            matlabbatch{2}.spm.stats.con.delete = 0;
            
            spm_jobman('run',matlabbatch);
            clear matlabbatch
            
        end
    end
end
load ss_info.mat;
addpath /mnt/tambinidata/scripts/
iss=9;
ss = ss_list{iss};
ss_dir = [preproc_dir ss];
sleep_mrk_dir = [data_dir 'sleep_mrk'];
nrem_timing_dir = [sleep_mrk_dir '/truncate/'];
for i_ses= 1:2:3
fmri_file = ['/mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-115/ses-1/'...
    'func/sub-115_ses-1_task-sleep_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold_S1.nii'];
sleep_mrk_dir = [data_dir 'sleep_mrk'];
sleep_analysis_dir=['/mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-115/ses-1/sleep_analysis/'];

%fmri_file =
%'sub-115_ses-1_task-sleep_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold_S1.nii';
%nrem_timing = 'fmri_nrem_spindles_chunks_115_V1.mat';
load(nrem_timing);
tr=2.24;
% read in data
info = spm_vol(fmri_file);
data = spm_read_vols(info);
disp(size(data))

for j=1:length(nrem_times) %loop through # of NREM
    start_time_points = round(nrem_times(j).start_times/tr);
    end_time_points = round(nrem_times(j).end_times/tr);

    % select time points to write out
    for i=1:length(nrem_times(j).start_times) %loop through # of chunks
        selected_time_points = [start_time_points(i):end_time_points(i)-1];
        Ntrs = length(selected_time_points);

        % create new data to write out
        data_new = data(:,:,:,selected_time_points);
        info_new = info(selected_time_points);
        disp(size(data_new))

        truncated_id = ['_' num2str(j) '_' num2str(i)];
        write_dir = sleep_analysis_dir;
        append = ['_truncated' truncated_id];

        % write new truncated data to file
        for itr = 1:Ntrs
            [~,f,e] = fileparts(info_new(itr).fname);
            info_new(itr).fname = [write_dir '/' f append e];
            info_new(itr).n = [itr 1];
            info_new(itr).private.dat.dim = size(data_new);
            spm_write_vol(info_new(itr), data_new(:,:,:,itr));
        end

    end
end
end
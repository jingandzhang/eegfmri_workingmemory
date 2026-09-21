
test_file = ['/mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-106/ses-3/sleep_analysis/'...
    'func/sub-001_ses-001_task-sleep_run-001_space-T1w_desc-preproc_bold.nii'];

% read in data
info = spm_vol(test_file);
data = spm_read_vols(info);
disp(size(data))

% select arbitrary time points to write out
selected_time_points = [1:20 60:140 180:240];
Ntrs = length(selected_time_points);

% create new data to write out
data_new = data(:,:,:,selected_time_points);
info_new = info(selected_time_points);
disp(size(data_new))

%%
write_dir = pwd;
append = '_truncated';

% write new truncated data to file
for itr = 1:Ntrs
    [~,f,e] = fileparts(info_new(itr).fname);
    info_new(itr).fname = [write_dir '/' f append e];
    info_new(itr).n = [itr 1];
    info_new(itr).private.dat.dim = size(data_new);
    spm_write_vol(info_new(itr), data_new(:,:,:,itr));
end
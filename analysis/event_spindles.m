%for spm 1st level analysis
clear all
clc
spindle_length=3;
load ss_info.mat;
spindle_truncated_dir = [data_dir 'sleep_mrk/truncate/'];
spindle_truncated_fls = glob(['fmri_nrem_spindles_chunks' '*.mat'], spindle_truncated_dir);

for i=1:length(spindle_truncated_fls)
    load(char(spindle_truncated_fls(i)));
    name = strrep(char(spindle_truncated_fls(i)),'/mnt/tambinidata/sleepstudy/data/sleep_mrk/truncate/fmri_nrem_spindles_chunks_','');
    name = strrep(name, '.mat', '');
    nrem_times(1).sp_onset_new_win_cat = nrem_times(1).sp_onset_new_win; %copy marker to add duration
    for j=2:length(nrem_times)
        nrem_times(j).sp_onset_new_win_cat = nrem_times(j).sp_onset_new_win + nrem_times(j-1).duration
    end
    onset_spindle = cat(2,nrem_times(1:length(nrem_times)).sp_onset_new_win_cat);
    [onset_spindle,idx] = sort(onset_spindle);
    duration_spindle = cat(2,nrem_times(1:length(nrem_times)).sp_duration_per_win);
    duration_spindle = duration_spindle(idx);
    %duration_spindle = repmat(spindle_length,size(onset_spindle));
    onset_baseline = cat(2,[0 onset_spindle + duration_spindle]);
    duration_baseline = onset_spindle - onset_baseline(1:end-1);
    onsets = {onset_spindle, onset_baseline};%add other events later
    names = {'spindles','baseline'};
    durations = {duration_spindle, duration_baseline};
    filename=['onsets_' name];
    save([analysis_dir '/spindle_event_files/' filename], 'names', 'durations','onsets');
end
   
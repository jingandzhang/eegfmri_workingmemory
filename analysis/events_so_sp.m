%for spm 1st level analysis
clear all
clc
%load ss_info.mat;
%spindle_truncated_dir = [data_dir 'sleep_mrk/truncate/'];
%spindle_truncated_fls = glob(['fmri_nrem_spindles_chunks' '*.mat'], spindle_truncated_dir);
events_files = dir('events_nrem*');
for i=43:46%1:length(events_files)
    load(events_files(i).name);
    name = strrep(events_files(i).name,'events_nrem_so_sp_','');
    name = strrep(name, '.mat', '');
    
    %nrem
    nrem_times(1).hn_so_onset_win_cat = nrem_times(1).hn_so_onset_win; %copy marker to add duration
    for j=2:length(nrem_times)
        nrem_times(j).hn_so_onset_win_cat = nrem_times(j).hn_so_onset_win + sum([nrem_times(1:j-1).duration])
    end
    onset_so = cat(1,nrem_times(1:length(nrem_times)).hn_so_onset_win_cat);
    [onset_so,idx] = sort(onset_so);
    duration_so = cat(1,nrem_times(1:length(nrem_times)).hn_so_duration_win);
    duration_so = duration_so(idx);
    
    %sws only
    nrem_times(1).hn_so_S3_onset_win_cat = nrem_times(1).hn_so_S3_onset_win; %copy marker to add duration
    for j=2:length(nrem_times)
        nrem_times(j).hn_so_S3_onset_win_cat = nrem_times(j).hn_so_S3_onset_win + sum([nrem_times(1:j-1).duration])
    end
    %add all the durations in the previous runs 
    onset_S3_so = cat(1,nrem_times(1:length(nrem_times)).hn_so_S3_onset_win_cat);
    duration_S3_so = cat(1,nrem_times(1:length(nrem_times)).hn_so_S3_duration_win);
    %S2 only
    nrem_times(1).hn_so_S2_onset_win_cat = nrem_times(1).hn_so_S2_onset_win; %copy marker to add duration
    for j=2:length(nrem_times)
        nrem_times(j).hn_so_S2_onset_win_cat = nrem_times(j).hn_so_S2_onset_win +sum([nrem_times(1:j-1).duration])
    end
    onset_S2_so = cat(1,nrem_times(1:length(nrem_times)).hn_so_S2_onset_win_cat);
    duration_S2_so = cat(1,nrem_times(1:length(nrem_times)).hn_so_S2_duration_win);
    
    %nrem only
    nrem_times(1).hn_sp_onset_win_cat = nrem_times(1).hn_sp_onset_win; %copy marker to add duration
    for j=2:length(nrem_times)
        nrem_times(j).hn_sp_onset_win_cat = nrem_times(j).hn_sp_onset_win + sum([nrem_times(1:j-1).duration])
    end
    onset_sp = cat(1,nrem_times(1:length(nrem_times)).hn_sp_onset_win_cat);
    [onset_sp,idx] = sort(onset_sp);
    duration_sp = cat(1,nrem_times(1:length(nrem_times)).hn_sp_duration_win);
    duration_sp = duration_sp(idx);
    
    %sws only
    nrem_times(1).hn_sp_S3_onset_win_cat = nrem_times(1).hn_sp_S3_onset_win; %copy marker to add duration
    for j=2:length(nrem_times)
        nrem_times(j).hn_sp_S3_onset_win_cat = nrem_times(j).hn_sp_S3_onset_win + sum([nrem_times(1:j-1).duration])
    end
    onset_S3_sp = cat(1,nrem_times(1:length(nrem_times)).hn_sp_S3_onset_win_cat);
    duration_S3_sp = cat(1,nrem_times(1:length(nrem_times)).hn_sp_S3_duration_win);
    %s2 only
    nrem_times(1).hn_sp_S2_onset_win_cat = nrem_times(1).hn_sp_S2_onset_win; %copy marker to add duration
    for j=2:length(nrem_times)
        nrem_times(j).hn_sp_S2_onset_win_cat = nrem_times(j).hn_sp_S2_onset_win + sum([nrem_times(1:j-1).duration])
    end
    onset_S2_sp = cat(1,nrem_times(1:length(nrem_times)).hn_sp_S2_onset_win_cat);
    duration_S2_sp = cat(1,nrem_times(1:length(nrem_times)).hn_sp_S2_duration_win);
    
    onsets = {onset_so', onset_S3_so', onset_S2_so', onset_sp', onset_S3_sp', onset_S2_sp'};%add other events later
    names = {'so_nrem','so_S3','so_S2','sp_nrem','sp_S3','sp_S2'};
    durations = {duration_so', duration_S3_so', duration_S2_so', duration_sp', duration_S3_sp', duration_S2_sp'};
    filename=['onsets_' name];
    save(filename, 'names', 'durations','onsets')
    %save([analysis_dir '/spindle_event_files/' filename], 'names', 'durations','onsets');
end
   
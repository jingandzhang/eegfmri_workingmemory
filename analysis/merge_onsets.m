nrem_times_part1(1).hn_so_onset_win_cat = nrem_times_part1(1).hn_so_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part1)
        nrem_times_part1(j).hn_so_onset_win_cat = nrem_times_part1(j).hn_so_onset_win + sum([nrem_times_part1(1:j-1).duration])
    end
    onset_so = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_so_onset_win_cat);
    [onset_so,idx] = sort(onset_so);
    duration_so = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_so_duration_win);
    duration_so = duration_so(idx);
    
    %sws only
    nrem_times_part1(1).hn_so_S3_onset_win_cat = nrem_times_part1(1).hn_so_S3_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part1)
        nrem_times_part1(j).hn_so_S3_onset_win_cat = nrem_times_part1(j).hn_so_S3_onset_win + sum([nrem_times_part1(1:j-1).duration])
    end
    %add all the durations in the previous runs 
    onset_S3_so = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_so_S3_onset_win_cat);
    duration_S3_so = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_so_S3_duration_win);
    %S2 only
    nrem_times_part1(1).hn_so_S2_onset_win_cat = nrem_times_part1(1).hn_so_S2_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part1)
        nrem_times_part1(j).hn_so_S2_onset_win_cat = nrem_times_part1(j).hn_so_S2_onset_win +sum([nrem_times_part1(1:j-1).duration])
    end
    onset_S2_so = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_so_S2_onset_win_cat);
    duration_S2_so = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_so_S2_duration_win);
    %nrem only
    nrem_times_part1(1).hn_sp_onset_win_cat = nrem_times_part1(1).hn_sp_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part1)
        nrem_times_part1(j).hn_sp_onset_win_cat = nrem_times_part1(j).hn_sp_onset_win + sum([nrem_times_part1(1:j-1).duration])
    end
    onset_sp = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_sp_onset_win_cat);
    [onset_sp,idx] = sort(onset_sp);
    duration_sp = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_sp_duration_win);
    duration_sp = duration_sp(idx);
    
    %sws only
    nrem_times_part1(1).hn_sp_S3_onset_win_cat = nrem_times_part1(1).hn_sp_S3_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part1)
        nrem_times_part1(j).hn_sp_S3_onset_win_cat = nrem_times_part1(j).hn_sp_S3_onset_win + sum([nrem_times_part1(1:j-1).duration])
    end
    onset_S3_sp = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_sp_S3_onset_win_cat);
    duration_S3_sp = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_sp_S3_duration_win);
    %s2 only
    nrem_times_part1(1).hn_sp_S2_onset_win_cat = nrem_times_part1(1).hn_sp_S2_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part1)
        nrem_times_part1(j).hn_sp_S2_onset_win_cat = nrem_times_part1(j).hn_sp_S2_onset_win + sum([nrem_times_part1(1:j-1).duration])
    end
    onset_S2_sp = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_sp_S2_onset_win_cat);
    duration_S2_sp = cat(1,nrem_times_part1(1:length(nrem_times_part1)).hn_sp_S2_duration_win);
    
    nrem_times_part2(1).hn_so_onset_win_cat = nrem_times_part2(1).hn_so_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part2)
        nrem_times_part2(j).hn_so_onset_win_cat = nrem_times_part2(j).hn_so_onset_win + sum([nrem_times_part2(1:j-1).duration])
    end
    onset_so = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_so_onset_win_cat);
    [onset_so,idx] = sort(onset_so);
    duration_so = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_so_duration_win);
    duration_so = duration_so(idx);
    
    %sws only
    nrem_times_part2(1).hn_so_S3_onset_win_cat = nrem_times_part2(1).hn_so_S3_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part2)
        nrem_times_part2(j).hn_so_S3_onset_win_cat = nrem_times_part2(j).hn_so_S3_onset_win + sum([nrem_times_part2(1:j-1).duration])
    end
    %add all the durations in the previous runs 
    onset_S3_so = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_so_S3_onset_win_cat);
    duration_S3_so = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_so_S3_duration_win);
    %S2 only
    nrem_times_part2(1).hn_so_S2_onset_win_cat = nrem_times_part2(1).hn_so_S2_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part2)
        nrem_times_part2(j).hn_so_S2_onset_win_cat = nrem_times_part2(j).hn_so_S2_onset_win +sum([nrem_times_part2(1:j-1).duration])
    end
    onset_S2_so = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_so_S2_onset_win_cat);
    duration_S2_so = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_so_S2_duration_win);
    %nrem only
    nrem_times_part2(1).hn_sp_onset_win_cat = nrem_times_part2(1).hn_sp_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part2)
        nrem_times_part2(j).hn_sp_onset_win_cat = nrem_times_part2(j).hn_sp_onset_win + sum([nrem_times_part2(1:j-1).duration])
    end
    onset_sp = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_sp_onset_win_cat);
    [onset_sp,idx] = sort(onset_sp);
    duration_sp = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_sp_duration_win);
    duration_sp = duration_sp(idx);
    
    %sws only
    nrem_times_part2(1).hn_sp_S3_onset_win_cat = nrem_times_part2(1).hn_sp_S3_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part2)
        nrem_times_part2(j).hn_sp_S3_onset_win_cat = nrem_times_part2(j).hn_sp_S3_onset_win + sum([nrem_times_part2(1:j-1).duration])
    end
    onset_S3_sp = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_sp_S3_onset_win_cat);
    duration_S3_sp = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_sp_S3_duration_win);
    %s2 only
    nrem_times_part2(1).hn_sp_S2_onset_win_cat = nrem_times_part2(1).hn_sp_S2_onset_win; %copy marker to add duration
    for j=2:length(nrem_times_part2)
        nrem_times_part2(j).hn_sp_S2_onset_win_cat = nrem_times_part2(j).hn_sp_S2_onset_win + sum([nrem_times_part2(1:j-1).duration])
    end
    onset_S2_sp = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_sp_S2_onset_win_cat);
    duration_S2_sp = cat(1,nrem_times_part2(1:length(nrem_times_part2)).hn_sp_S2_duration_win);
    

for j=1:length(nrem_times_part2)
    nrem_times_part2(j).hn_so_onset_win_cat=nrem_times_part2(j).hn_so_onset_win_cat + sum([nrem_times_part1(1:end).duration])
    nrem_times_part2(j).hn_so_S3_onset_win_cat=nrem_times_part2(j).hn_so_S3_onset_win_cat + sum([nrem_times_part1(1:end).duration])
    nrem_times_part2(j).hn_so_S2_onset_win_cat=nrem_times_part2(j).hn_so_S2_onset_win_cat + sum([nrem_times_part1(1:end).duration])

    nrem_times_part2(j).hn_sp_onset_win_cat=nrem_times_part2(j).hn_sp_onset_win_cat + sum([nrem_times_part1(1:end).duration])
    nrem_times_part2(j).hn_sp_S3_onset_win_cat=nrem_times_part2(j).hn_sp_S3_onset_win_cat + sum([nrem_times_part1(1:end).duration])
    nrem_times_part2(j).hn_sp_S2_onset_win_cat=nrem_times_part2(j).hn_sp_S2_onset_win_cat + sum([nrem_times_part1(1:end).duration])
end
nrem_times_merged = [nrem_times_part1, nrem_times_part2]

onset_so = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_so_onset_win_cat);
[onset_so,idx] = sort(onset_so);
duration_so = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_so_duration_win);
duration_so = duration_so(idx);

onset_S3_so = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_so_S3_onset_win_cat);
duration_S3_so = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_so_S3_duration_win);

onset_S2_so = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_so_S2_onset_win_cat);
duration_S2_so = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_so_S2_duration_win);

onset_sp = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_sp_onset_win_cat);
[onset_sp,idx] = sort(onset_sp);
duration_sp = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_sp_duration_win);
duration_sp = duration_sp(idx);

onset_S3_sp = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_sp_S3_onset_win_cat);
duration_S3_sp = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_sp_S3_duration_win);

onset_S2_sp = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_sp_S2_onset_win_cat);
duration_S2_sp = cat(1,nrem_times_merged(1:length(nrem_times_merged)).hn_sp_S2_duration_win);


onsets = {onset_so', onset_S3_so', onset_S2_so', onset_sp', onset_S3_sp', onset_S2_sp'};%add other events later
names = {'so_nrem','so_S3','so_S2','sp_nrem','sp_S3','sp_S2'};
durations = {duration_so', duration_S3_so', duration_S2_so', duration_sp', duration_S3_sp', duration_S2_sp'};
filename=['onsets_' name(1:end-6) 'merged'];
save(filename, 'names', 'durations','onsets')
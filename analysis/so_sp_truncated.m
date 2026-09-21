clear 
close all
id='149';
visit = 2;
run = '1';
name = '149_V2';
offset = 18.012; %seconds %see vmrk for sleep starts to V1
ch=4;
%transform everything to seconds
hz=250; %sampling rate
tr=2.24;

load (['nrem_truncated/fmri_nrem_spindles_chunks_sub-' id '_ses' num2str(visit*2-1) '_run' run '.mat'])
%files = dir(['so_sp/' 'events_nrem_so_sp_*'])
% for file_i = 3%:length(files)
%     filename = files(file_i).name
%     id = filename(23:25)
%     visit = round(str2num(filename(30))/2)
%     name = [id '_V' num2str(visit) 'part3']
%     run='3';
%    load (['so_sp/' filename])
    load (['OUT/HN_SO/' name '_SO.mat'])
    load (['OUT/HN_spindle/' name '_spindle.mat'])
    nrem_times(1).offset = offset;
    offset=nrem_times(1).offset;
    for i = 1:length(nrem_times)
        events_slow_second = cat(1,events_slow_S2{ch},events_slow_S3{ch})/hz -offset;
        idx = find (events_slow_second(:,1) > nrem_times(i).start_times & events_slow_second(:,2) <= nrem_times(i).end_times)
        nrem_times(i).hn_so_onset_win = events_slow_second(idx,1)-nrem_times(i).start_times%-offset;
        nrem_times(i).hn_so_duration_win = events_slow_second(idx,2) - events_slow_second(idx,1);

        events_slow_second_S2 = events_slow_S2{ch}/hz -offset;;
        idx = find (events_slow_second_S2(:,1) > nrem_times(i).start_times & events_slow_second_S2(:,2) <= nrem_times(i).end_times)
        nrem_times(i).hn_so_S2_onset_win = events_slow_second_S2(idx,1)-nrem_times(i).start_times%-offset;
        nrem_times(i).hn_so_S2_duration_win = events_slow_second_S2(idx,2) - events_slow_second_S2(idx,1);

        events_slow_second_S3 = events_slow_S3{ch}/hz -offset;
        idx = find (events_slow_second_S3(:,1) > nrem_times(i).start_times & events_slow_second_S3(:,2) <= nrem_times(i).end_times)
        nrem_times(i).hn_so_S3_onset_win = events_slow_second_S3(idx,1)-nrem_times(i).start_times%-offset;
        nrem_times(i).hn_so_S3_duration_win = events_slow_second_S3(idx,2) - events_slow_second_S3(idx,1);

        events_sp_second = cat(1,spindle_intrv_stg2{ch},spindle_intrv_stg3{ch})/hz -offset;
        idx = find (events_sp_second(:,1) > nrem_times(i).start_times & events_sp_second(:,2) <= nrem_times(i).end_times)
        nrem_times(i).hn_sp_onset_win = events_sp_second(idx,1)-nrem_times(i).start_times%-offset;
        nrem_times(i).hn_sp_duration_win = events_sp_second(idx,2) - events_sp_second(idx,1);

        events_sp_second_S2 = spindle_intrv_stg2{ch}/hz-offset;
        idx = find (events_sp_second_S2(:,1) > nrem_times(i).start_times & events_sp_second_S2(:,2) <= nrem_times(i).end_times)
        nrem_times(i).hn_sp_S2_onset_win = events_sp_second_S2(idx,1)-nrem_times(i).start_times%-offset;
        nrem_times(i).hn_sp_S2_duration_win = events_sp_second_S2(idx,2) - events_sp_second_S2(idx,1);

        events_sp_second_S3 = spindle_intrv_stg3{ch}/hz-offset;
        idx = find (events_sp_second_S3(:,1) > nrem_times(i).start_times & events_sp_second_S3(:,2) <= nrem_times(i).end_times)
        nrem_times(i).hn_sp_S3_onset_win = events_sp_second_S3(idx,1)-nrem_times(i).start_times%-offset;
        nrem_times(i).hn_sp_S3_duration_win = events_sp_second_S3(idx,2) - events_sp_second_S3(idx,1);
    end

    load (['OUT/MN_SO/' name '_SO.mat'])
    load (['OUT/MN_spindle/' name '_spindle.mat'])
    for i = 1:length(nrem_times)
        events_slow_second = cat(1,events_slow_S2{ch},events_slow_S3{ch})/hz-offset;
        idx = find (events_slow_second(:,1) > nrem_times(i).start_times & events_slow_second(:,2) <= nrem_times(i).end_times)
        nrem_times(i).mn_so_onset_win = events_slow_second(idx,1)-nrem_times(i).start_times%-offset;
        nrem_times(i).mn_so_duration_win = events_slow_second(idx,2) - events_slow_second(idx,1);

        events_slow_second_S2 = events_slow_S2{ch}/hz-offset;
        idx = find (events_slow_second_S2(:,1) > nrem_times(i).start_times & events_slow_second_S2(:,2) <= nrem_times(i).end_times)
        nrem_times(i).mn_so_S2_onset_win = events_slow_second_S2(idx,1)-nrem_times(i).start_times%-offset;
        nrem_times(i).mn_so_S2_duration_win = events_slow_second_S2(idx,2) - events_slow_second_S2(idx,1);

        events_slow_second_S3 = events_slow_S3{ch}/hz-offset;
        idx = find (events_slow_second_S3(:,1) > nrem_times(i).start_times & events_slow_second_S3(:,2) <= nrem_times(i).end_times)
        nrem_times(i).mn_so_S3_onset_win = events_slow_second_S3(idx,1)-nrem_times(i).start_times%-offset;
        nrem_times(i).mn_so_S3_duration_win = events_slow_second_S3(idx,2) - events_slow_second_S3(idx,1);

        if ~isempty(spindle_intrv_stg3)
            events_sp_second = cat(1,spindle_intrv_stg2{ch},spindle_intrv_stg3{ch})/hz-offset;
            idx = find (events_sp_second(:,1) > nrem_times(i).start_times & events_sp_second(:,2) <= nrem_times(i).end_times)
            nrem_times(i).mn_sp_onset_win = events_sp_second(idx,1)-nrem_times(i).start_times%-offset;
            nrem_times(i).mn_sp_duration_win = events_sp_second(idx,2) - events_sp_second(idx,1);
        else
            events_sp_second = spindle_intrv_stg2{ch}/hz-offset;
            idx = find (events_sp_second(:,1) > nrem_times(i).start_times & events_sp_second(:,2) <= nrem_times(i).end_times)
            nrem_times(i).mn_sp_onset_win = events_sp_second(idx,1)-nrem_times(i).start_times%-offset;
            nrem_times(i).mn_sp_duration_win = events_sp_second(idx,2) - events_sp_second(idx,1);
        end
        events_sp_second_S2 = spindle_intrv_stg2{ch}/hz-offset;
        idx = find (events_sp_second_S2(:,1) > nrem_times(i).start_times & events_sp_second_S2(:,2) <= nrem_times(i).end_times)
        nrem_times(i).mn_sp_S2_onset_win = events_sp_second_S2(idx,1)-nrem_times(i).start_times%-offset;
        nrem_times(i).mn_sp_S2_duration_win = events_sp_second_S2(idx,2) - events_sp_second_S2(idx,1);

        if ~isempty(spindle_intrv_stg3)
            events_sp_second_S3 = spindle_intrv_stg3{ch}/hz-offset;
            idx = find (events_sp_second_S3(:,1) > nrem_times(i).start_times & events_sp_second_S3(:,2) <= nrem_times(i).end_times)
            nrem_times(i).mn_sp_S3_onset_win = events_sp_second_S3(idx,1)-nrem_times(i).start_times%-offset;
            nrem_times(i).mn_sp_S3_duration_win = events_sp_second_S3(idx,2) - events_sp_second_S3(idx,1);
        else
            nrem_times(i).mn_sp_S3_onset_win = [];
            nrem_times(i).mn_sp_S3_duration_win = [];
        end
    end
    save(['so_sp/new/events_good/events_nrem_so_sp_sub-' id '_ses-' num2str(visit*2-1) '_run-0' run '.mat'], 'nrem_times')
% end
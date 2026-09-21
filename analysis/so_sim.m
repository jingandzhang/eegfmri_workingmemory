
clear
addpath /mnt/tambinidata/scripts/
data_dir = '/mnt/tambinidata/sleepstudy/analysis/so_sp_events_newsub/';
save_dir = '/mnt/tambinidata/sleepstudy/analysis/so_sp_events_updown_sim/';


fls = glob('*nrem.mat', data_dir);
for ifl = length(fls)
   
    fl = fls{ifl};
    sel = fl(findstr('sub-', fl): end);
    ss = sel(1: findstr('_', sel)-1);
    
    ses = sel(findstr('ses-', sel) : findstr('ses-', sel)+4);
    
    load(fl)
    
    [ons_ud, dur_ud] = define_segments(durations, onsets);

    onsets = ons_ud;
    durations = dur_ud;

    new_fl = [save_dir 'onsets_updown_sim_' ss '_' ses '_nrem.mat'];
    if ~isdir(save_dir); mkdir(save_dir); end
    
    
    names = {'up';'down';'spindle'};
    save(new_fl, 'names', 'onsets', 'durations');
end

%%
% ss = 'sub-105';
% ses = 'ses-3';
% run = 'run-01';
% load ([data_dir 'onsets_' ss '_' ses '_' run '_nrem.mat'])

%%
% 
% names = {'up';'down'};
% [ons_ud, dur_ud] = define_segments(durations, onsets);
% 
% onsets = ons_ud;
% durations = dur_ud;
% 
% new_fl = [save_dir 'onsets_updown_sim_' ss '_' ses '_nrem.mat'];
% if ~isdir(save_dir); mkdir(save_dir); end
% save(new_fl, 'names', 'onsets', 'durations');

%%
function [ons_ud, dur_ud, ev_id] = define_segments(durations, onsets)
ireg = 1;

Nevs = length(durations{ireg});

Ntypes = 2;
ons_ud = cell(Ntypes,1);
dur_ud = ons_ud;
ev_id = ons_ud;
for itype = 1:Ntypes
    ons_ud{itype} = [];
    dur_ud{itype} = [];
    ev_id{itype} = [];
end

s_dur = .5; % assuming 1 Hz
for iev = 1:Nevs
   
    st = onsets{ireg}(iev);
    d = durations{ireg}(iev);
    ed =  st + d;
    curr{1} = [st : (s_dur*2) : ed];
    curr{2} = [st + s_dur : (s_dur*2) : ed];
    
    ons_ud{1} = [ons_ud{1}; curr{1}'];
    ons_ud{2} = [ons_ud{2}; curr{2}'];
    for itype = 1:Ntypes
        c_dur = zeros(length(curr{itype}),1);
        for icycle = 1:length(curr{itype})
            c_dur(icycle) = min(s_dur, ed - curr{itype}(icycle));
%             if curr{itype} + s_dur > ed
%                 c_dur(icycle) = 
        end
        dur_ud{itype} = [dur_ud{itype}; c_dur];
        ev_id{itype} = [ev_id{itype}; iev*ones(length(curr{itype}),1) ...
            durations{ireg}(iev)*ones(length(curr{itype}),1)];
    end
end

for itype = 1:Ntypes
   
    idx = dur_ud{itype} >= .1;
    dur_ud{itype} = dur_ud{itype}(idx);
    ons_ud{itype} = ons_ud{itype}(idx);    
    ev_id{itype} = ev_id{itype}(idx,:);

    
end

% also add in spindle events for model
dur_ud{Ntypes+1} = durations{2};
ons_ud{Ntypes+1} = onsets{2};

end
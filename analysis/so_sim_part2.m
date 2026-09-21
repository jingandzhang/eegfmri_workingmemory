
clear all
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts/
addpath /tmp/yassamri/Software/spm12

ev_dir = '/mnt/tambinidata/sleepstudy/analysis/so_sp_events_updown_sim/';

spm_name = 'spm_nrem_model1_updownsim';
sz = [];

TR = 2.24;
% hrf = spm_hrf(TR);
mt = 16;

der_dir = [data_dir 'derivatives/mriprep/fmriprep/'];
for iss = 1%length(ss_list)
    ss = ss_list{iss};
    for iises = 1:length(ses_list{iss})
        ses = ['ses-' num2str(ses_list{iss}(iises))];
        ev_file = glob(['*' ss '*' ses '*.mat'], ev_dir);
        
        load(ev_file{1})
        
        sz = [sz; iss iises length(onsets{1}) length(onsets{2}) length(onsets{3})];
        
      
        time = (TR/mt):(TR/mt):onsets{1}(end)+100;
        y = zeros(length(time),1);
        for iev = 1:length(onsets{1})
            curr = onsets{1}(iev);
            curr_ed = onsets{1}(iev)+durations{1}(iev);
            bg = find(min(abs(time-curr))==abs(time-curr));
            ed = find(min(abs(time-curr_ed))==abs(time-curr_ed));
            
            
            idx = (time>= curr) & (time <= (curr+durations{1}(iev)));
            y(idx) = 1;
        end
        
        spm_dir = [der_dir ss '/' ses '/' spm_name];
        load([spm_dir '/SPM.mat'])

        pre = conv(y, SPM.xBF.bf);
        
        k = SPM.nscan; %%% change to actual # of TRs;
        fMRI_T = 16;
        fMRI_T0 = 8;
        X = pre((0:(k - 1))*fMRI_T + fMRI_T0 + 32);
    end
    
end

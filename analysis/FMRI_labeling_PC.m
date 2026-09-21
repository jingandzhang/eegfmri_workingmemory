clc
clear 
close all

%transform everything to seconds
REM_stage_label=5;
NREM_stage_label=8;
hz=250; %sampling rate
tr=2.24;
win_len= 100; % # of tr per scan
%win_step = 100;
chunk=win_len*tr; %continuous chunk in seconds

load ss_info.mat;

for iss=1:length(ss_list)
    %open the subject directory and count session files 
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss];
    sleep_mrk_dir = [data_dir 'sleep_mrk'];
    for i_ses= 1:2:3 %loop session 1 and 3
        func_dir = [ss_dir '/ses-' num2str(i_ses) '/func/'];
        file_str = ['*task-sleep' '*MNI152NLin2009cAsym_desc-preproc_bold_S1.nii'];
        fls = glob([file_str], func_dir);
        spindle_fls = glob([ss(5:7) '_V' num2str(round(i_ses/2)) '*filter_eegfmri_spindle_no_plus_spindles.mat'], [sleep_mrk_dir '/spindle/']);
        stages_fls = glob([ss(5:7) '_V' num2str(round(i_ses/2)) '*PC.mat'], [sleep_mrk_dir '/stage/']);
        v1_fls = glob([ss(5:7) '_V' num2str(round(i_ses/2)) '*.txt'], [sleep_mrk_dir '/v1/']);
        if length(fls) ~= length(spindle_fls) || length(fls) ~= length(stages_fls) || length(fls) ~= length(v1_fls)
            error('check # of fMRI files, Spindles, Stage, and V1 files')
        end
        for i_run = 1:length(fls)
            Name=[ss '_ses' num2str(i_ses) '_run' num2str(i_run)];
            fmri_file = fls(i_run);
            fmri_timing = v1_fls(i_run);
            v1_file = v1_fls(i_run);
            load(char(stages_fls(i_run)));
            load(char(spindle_fls(i_run)));
            fmri_Time=importdata(char(v1_file));
            fmri_Time=fmri_Time(3:end);
            for i=1:length(fmri_Time)
                fmri_Time{i}=str2num(strrep(strrep(fmri_Time{i},', 1, All',''),'Volume, V  1, ',''));
            end
            fmri_Time=cell2mat(fmri_Time);
            fmri_Time(end)=[];
            fmri_Vol_Info=[];
            fmri_Vol_Info.Time=fmri_Time;
            info = spm_vol(char(fmri_file));
            data = spm_read_vols(info);
            if size(data,4) ~= length(fmri_Vol_Info.Time)
                error('timing is not match to fmri volumes')
            end
            clear data;

            Stages=stageData.stages;
            Stages=repmat(Stages,1,30*hz); % one stage per sample
            Stages=reshape(Stages',1,size(Stages,1)*size(Stages,2));
            if fmri_Vol_Info.Time(end)>length(Stages)
                warning(['Stage length = ' num2str(length(Stages))])
                warning(['volume length = ' num2str(fmri_Vol_Info.Time(end))])
                Stages(length(Stages):fmri_Vol_Info.Time(end))= Stages(length(Stages));
            end

            if fmri_Vol_Info.Time(end)<length(Stages)
                warning(['Stage length = ' num2str(length(Stages))])
                warning(['volume length = ' num2str(fmri_Vol_Info.Time(end))])
                Stages(fmri_Vol_Info.Time(end)+1:length(Stages))= [];
            end

            Stages=Stages(fmri_Vol_Info.Time); %sample timing & 1 stage per tr
            fmri_Vol_Info.Stage=Stages';
            fmri_Vol_Info.REM=(Stages==REM_stage_label)';
            fmri_Vol_Info.NREM=((Stages==2)|(Stages==3))';
            fmri_Vol_Info.SWS=(Stages==3)';
            fmri_Vol_Info.Stg2=(Stages==2)';

            %find NREM stage
            Stages_NREM = Stages;
            Stages_NREM(Stages_NREM==3)=NREM_stage_label;
            Stages_NREM(Stages_NREM==2)=NREM_stage_label;
            t=find((Stages_NREM(2:end)-Stages_NREM(1:end-1))~=0);
            t=cat(2,0,t);
            t=cat(2,t,length(Stages_NREM));
            bnd=zeros(length(t)-1,2); %volume
            for i=1:length(t)-1
                bnd(i,:)=[t(i)+1 t(i+1)];
            end
            bndstg=Stages_NREM(bnd(:,1));
            bmn=(bnd(:,2)-bnd(:,1)+1).*tr;%seconds
            mintof=find(bmn>(chunk/tr));
            analepochs_dur=bmn(mintof); %seconds
            analepochs_intrv=bnd(mintof,:);
            analepochs_stg=bndstg(mintof);
            analepochs_intrv_nrem=analepochs_intrv(analepochs_stg==8,:); %tr index

            %find chunks of NREM stage with the same duration
            nrem_times=struct;
            for j = 1:length(analepochs_intrv_nrem)
                start_time=analepochs_intrv_nrem(j,1):win_step:analepochs_intrv_nrem(j,2)-win_len;
                nrem_times(j).start_times= start_time.*tr; % in seconds
                end_time=analepochs_intrv_nrem(j,1)+win_len:win_step:analepochs_intrv_nrem(j,2);
                nrem_times(j).end_times= end_time.*tr; % in seconds
            end

            spindle=[];
            % for ch=1:8 % find mid point of each spindle
            %     spindle{ch}=[(spindle_intrv_stg2{ch}(:,1)+spindle_intrv_stg2{ch}(:,2))/2; (spindle_intrv_stg3{ch}(:,1)+spindle_intrv_stg3{ch}(:,2))/2];
            % end

            % find spindle onset and duration
            for ch=1:8 % spindle timing in sample, transformed to second
                spindle_onset{ch}=[spindle_intrv_stg2{ch}(:,1); spindle_intrv_stg3{ch}(:,1)]./hz;
                spindle_duration{ch}=[spindle_intrv_stg2{ch}(:,2)-spindle_intrv_stg2{ch}(:,1); spindle_intrv_stg3{ch}(:,2)-spindle_intrv_stg3{ch}(:,1)]./hz;
            end
            %use C4 for now
            ch=4;
            % all times in seconds
            all_win=0;
            for j = 1:length(analepochs_intrv_nrem)
                nrem_times(j).sp_per_win = zeros(length(spindle_onset{ch}),length(nrem_times(j).start_times))
                all_win=all_win+length(nrem_times(j).start_times);
                for sp = 1:length(nrem_times(j).start_times)
                    nrem_times(j).sp_per_win(:,sp) = spindle_onset{ch}>=nrem_times(j).start_times(sp) & (spindle_onset{ch} + spindle_duration{ch}) <=nrem_times(j).end_times(sp);
                    nrem_times(j).sp_n_per_win(sp) = sum(nrem_times(j).sp_per_win(:,sp));
                    nrem_times(j).sp_onset_per_win(1:nrem_times(j).sp_n_per_win(sp),sp) = spindle_onset{ch}(nrem_times(j).sp_per_win(:,sp)==1);
                    nrem_times(j).sp_duration_per_win(1:nrem_times(j).sp_n_per_win(sp),sp) = spindle_duration{ch}(nrem_times(j).sp_per_win(:,sp)==1);
                end
                nrem_times(j).sp_onset_new_win = nrem_times(j).sp_onset_per_win-nrem_times(j).start_times
                nrem_times(j).sp_onset_per_win(nrem_times(j).sp_onset_per_win==0)=nan
                nrem_times(j).sp_onset_new_win(nrem_times(j).sp_onset_new_win<=0)=nan
            end
            fmri_label=struct;
            fmri_label.nrem_times = nrem_times
            fmri_label.paras=struct;
            fmri_label.paras.hz=hz; %sampling rate
            fmri_label.paras.tr=tr;
            fmri_label.paras.win_len= win_len; % # of tr per scan
            fmri_label.paras.win_step = win_step;
            fmri_label.paras.chunk_duration=chunk;
            fmri_label.paras.chunk_numbers=sum(all_win);

            save([Name '/fmri_stage_info_' Name '.mat'],'fmri_Vol_Info')
            save([Name '/fmri_nrem_spindles_chunks_'  Name '.mat'],'-v7.3','-struct','fmri_label')
        end
    end
end
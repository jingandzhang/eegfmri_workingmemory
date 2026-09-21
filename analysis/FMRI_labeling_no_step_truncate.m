%%%% need to add offsets
clc
clear 
close all
addpath /mnt/tambinidata/scripts/
offset =13.828; %seconds %see vmrk for sleep starts to V1
%transform everything to seconds
REM_stage_label=5;
NREM_stage_label=8;
hz=250; %sampling rate
tr=2.24;
win_len= 100; % # of tr per scan
%win_step = 100;
chunk=win_len*tr; %continuous chunk in seconds

load ss_info.mat;

for iss=27%1:length(ss_list)
    %open the subject directory and count session files 
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss];
    sleep_mrk_dir = [data_dir 'sleep_mrk'];
    for i_ses= 3%1:2:3 %loop session 1 and 3
        func_dir = [ss_dir '/ses-' num2str(i_ses) '/func/'];
        file_str = ['*task-sleep' '*MNI152NLin2009cAsym_desc-preproc_bold_S1.nii'];
        fls = glob([file_str], func_dir);
        spindle_fls = glob([ss(5:7) '_V' num2str(round(i_ses/2)) '*filter_eegfmri_spindle_no_plus_spindles.mat'], [sleep_mrk_dir '/spindle/']);
        stages_fls = glob([ss(5:7) '_V' num2str(round(i_ses/2)) '*PC.mat'], [sleep_mrk_dir '/stage/']);
        v1_fls = glob([ss(5:7) '_V' num2str(round(i_ses/2)) '*.txt'], [sleep_mrk_dir '/v1/']);
        if length(fls) ~= length(spindle_fls) || length(fls) ~= length(stages_fls) || length(fls) ~= length(v1_fls)
            error('check # of fMRI files, Spindles, Stage, and V1 files')
        end
        for i_run = 1%1:length(fls) %If the # of runs doesn't match the index, need to change Name
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
            %data = data(:,:,:,3:2088);
            %info = info(3:2088);
            if size(data,4) ~= length(fmri_Vol_Info.Time)
                error('timing is not match to fmri volumes')
            end
            

            Stages=stageData.stages;
            Stages=repmat(Stages,1,30*hz); % one stage per sample
            Stages=reshape(Stages',1,size(Stages,1)*size(Stages,2));
            Stages=Stages(offset*hz+1:end); %offset cut all the no scan EEG
            if fmri_Vol_Info.Time(end)> (length(Stages))
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
            start_time_tr =[];
            end_time_tr = [];
            for j = 1:size(analepochs_intrv_nrem,1)
                start_time_tr(j)=analepochs_intrv_nrem(j,1);
                nrem_times(j).start_times= start_time_tr(j).*tr - tr; % in seconds
                end_time_tr(j)=analepochs_intrv_nrem(j,2);
                nrem_times(j).end_times = end_time_tr(j).*tr; % in seconds
                nrem_times(j).duration = nrem_times(j).end_times - nrem_times(j).start_times;
                nrem_times(j).selected_tr = [start_time_tr(j):end_time_tr(j)];
            end
           

            % select time points to write out
            selected_time_points = [cat(2,nrem_times(:).selected_tr)];
            Ntrs = length(selected_time_points);

            % create new data to write out
            data_new = data(:,:,:,selected_time_points);
            info_new = info(selected_time_points);
            disp(size(data_new))
            if size(data_new,4) ~= length(cat(2,nrem_times(:).selected_tr)) || size(data_new,4) ~= round(sum(cat(2,nrem_times(:).duration))/tr)
               error('truncated scans not match labels') 
            end

            %truncated_id = ['_' num2str(j)];
            write_dir = [func_dir '/truncate/'];
            mkdir(write_dir)
            append = ['_nrem_truncated'];

            % write new truncated data to file
            for itr = 1:Ntrs
                [~,f,e] = fileparts(info_new(itr).fname);
                info_new(itr).fname = [write_dir '/' f append e];
                info_new(itr).n = [itr 1];
                info_new(itr).private.dat.dim = size(data_new);
                spm_write_vol(info_new(itr), data_new(:,:,:,itr));
            end

            %Spindle Timing
            spindle=[];
            % find spindle onset and duration
            if isempty(spindle_intrv_stg3)
                for ch=1:8 % spindle timing in sample, transformed to second
                    spindle_onset{ch}=[spindle_intrv_stg2{ch}(:,1)]./hz;
                    spindle_duration{ch}=[spindle_intrv_stg2{ch}(:,2)-spindle_intrv_stg2{ch}(:,1)]./hz;
                    spindle_onset{ch}= spindle_onset{ch}-offset; 
                end
            else
                for ch=1:8 % spindle timing in sample, transformed to second
                    spindle_onset{ch}=[spindle_intrv_stg2{ch}(:,1); spindle_intrv_stg3{ch}(:,1)]./hz;
                    spindle_duration{ch}=[spindle_intrv_stg2{ch}(:,2)-spindle_intrv_stg2{ch}(:,1); spindle_intrv_stg3{ch}(:,2)-spindle_intrv_stg3{ch}(:,1)]./hz;
                    spindle_onset{ch}= spindle_onset{ch}-offset; 
                end
            end
            %use C4 for now
            ch=4;
            % all times in seconds
            for j = 1:size(analepochs_intrv_nrem,1)
                nrem_times(j).sp_per_win = spindle_onset{ch}>=nrem_times(j).start_times & (spindle_onset{ch} + spindle_duration{ch}) <=nrem_times(j).end_times;
                nrem_times(j).sp_n_per_win = sum(nrem_times(j).sp_per_win);
                nrem_times(j).sp_onset_per_win(1:nrem_times(j).sp_n_per_win) = spindle_onset{ch}(nrem_times(j).sp_per_win==1);
                nrem_times(j).sp_duration_per_win(1:nrem_times(j).sp_n_per_win) = spindle_duration{ch}(nrem_times(j).sp_per_win==1);
                nrem_times(j).sp_onset_new_win = nrem_times(j).sp_onset_per_win-nrem_times(j).start_times
            end
            
            fmri_label=struct;
            fmri_label.nrem_times = nrem_times
            fmri_label.paras=struct;
            fmri_label.paras.hz=hz; %sampling rate
            fmri_label.paras.tr=tr;
            fmri_label.paras.min_win_len= win_len; % # of tr per scan
            fmri_label.paras.min_chunk_duration=chunk;

            save([sleep_mrk_dir '/truncate/fmri_stage_info_' Name '.mat'],'fmri_Vol_Info')
            save([sleep_mrk_dir '/truncate/fmri_nrem_spindles_chunks_'  Name '.mat'],'-v7.3','-struct','fmri_label')

         
        end
    end
end
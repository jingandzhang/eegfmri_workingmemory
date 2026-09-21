% clc
% clear
% close all
% edf_file='121_V1part2_clean.edf';
% score_file='121_V1part2_PC.mat';



% addpath('/pub/hniknaza/eeglab2020_0')
eeglab
burst_band=[.7 1.4];

Data_dir='DataForHamid/';
Out_dir='OUT/HN_SO/';

mrk=load([Data_dir score_file]);

stages=mrk.stageData.stages(:);  % *** update this


[header,record] = edfread([Data_dir edf_file]);


Channels=header.label;

% size of the epochs used for staging [sec]:
epoch_size = 30;

% go through all available electrodes from the header:
for CH = 1:length(Channels)




            freq = header.samples(CH);      % frequency of data acquisition
            stages_Otime=reshape(repmat(stages,1,epoch_size*freq)',epoch_size*freq*length(stages),1);
            EEG_data=record(:,CH)';
            EEG = pop_importdata('dataformat','array','nbchan',0,'data','EEG_data','setname','test','srate',freq,'pnts',0,'xmin',0);
            EEG = pop_eegfiltnew(EEG, 'locutoff',burst_band(1),'hicutoff',burst_band(2),'plotfreqz',0);
            filtered_data=EEG.data;
            [starts,ends]=HN_EEG_burst(filtered_data,freq,0,2,burst_band,10,0,1,.5);
            slow_events=[starts',ends'];
            transformed = hilbert(filtered_data);
            Pha=angle(transformed);
            if length(stages_Otime)<length(filtered_data)
                stages_Otime(length(stages_Otime)+1:length(stages_Otime)+(length(filtered_data)-length(stages_Otime)))=7;
            end
            SO_stages=stages_Otime(floor((starts+ends)/2));

            events_slow_S2_temp=slow_events(SO_stages==2,:);
            events_slow_S3_temp=slow_events(SO_stages==3,:);
            

            min_trough_S2=[];
            S2_to_remove=[];
            for i =1:size(events_slow_S2_temp,1)
                pha_temp=Pha(events_slow_S2_temp(i,1):events_slow_S2_temp(i,2));

                pha_dif=pha_temp(1:end-1)-pha_temp(2:end);
                troughs=find(pha_dif>6);
                if length(troughs)>=1

                    for j=1:length(troughs)
                        min_trough_S2=[min_trough_S2;events_slow_S2_temp(i,1)+troughs(j)];
                    end

                else
                    S2_to_remove=[S2_to_remove;i];
                end
            end

            if not(isempty(S2_to_remove))
                events_slow_S2_temp(S2_to_remove,:)=[];
                length(S2_to_remove)
            end



            min_trough_S3=[];
            S3_to_remove=[];
            for i =1:size(events_slow_S3_temp,1)
                pha_temp=Pha(events_slow_S3_temp(i,1):events_slow_S3_temp(i,2));

                pha_dif=pha_temp(1:end-1)-pha_temp(2:end);
                troughs=find(pha_dif>6);
                if length(troughs)>=1

                    for j=1:length(troughs)
                        min_trough_S3=[min_trough_S3;events_slow_S3_temp(i,1)+troughs(j)];
                    end

                else
                    S3_to_remove=[S3_to_remove;i];
                end
            end

            if not(isempty(S3_to_remove))
                events_slow_S3_temp(S3_to_remove,:)=[];
                length(S3_to_remove)
            end


            

            events_slow_S2{CH,:} = events_slow_S2_temp;
            events_slow_S3{CH,:} = events_slow_S3_temp;

            trough_S2{CH,:} = min_trough_S2;
            trough_S3{CH,:} = min_trough_S3;


            density_S2{CH,:} = length(trough_S2{CH,:})/(sum(stages==2)*0.5);
            density_S3{CH,:} = length(trough_S3{CH,:})/(sum(stages==3)*0.5);


            duration_stage_S2 = sum(stages==2)*0.5;
            duration_stage_S3 = sum(stages==3)*0.5;

end
save([Out_dir strrep(edf_file,'_clean.edf','') '_SO.mat'],...
        'Channels',...
        'events_slow_S2','events_slow_S3',...
        'density_S2','density_S3',...
        'duration_stage_S2','duration_stage_S3',...
        'trough_S2','trough_S3')

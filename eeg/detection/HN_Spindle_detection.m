% clc
% clear
% close all
% edf_file='105_V2_clean.edf';
% score_file='105_V2_PC.mat';




% addpath('/pub/hniknaza/eeglab2020_0')
eeglab
burst_band=[12 16];

Data_dir='DataForHamid/';
Out_dir='OUT/HN_spindle/';

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
            [starts,ends]=HN_EEG_burst(filtered_data,freq,1,2,burst_band,10,2,5,.5);
            spindle_events=[starts',ends'];
            
            if length(stages_Otime)<length(filtered_data)
                stages_Otime(length(stages_Otime)+1:length(stages_Otime)+(length(filtered_data)-length(stages_Otime)))=7;
            end
            spindle_stages=stages_Otime(floor((starts+ends)/2));

            events_spindle_S2_temp=spindle_events(spindle_stages==2,:);
            events_spindle_S3_temp=spindle_events(spindle_stages==3,:);
            



            

            spindle_intrv_stg2{CH,:} = events_spindle_S2_temp;
            spindle_intrv_stg3{CH,:} = events_spindle_S3_temp;

            spN_stg2(CH)=size(events_spindle_S2_temp,1);
            spN_stg3(CH)=size(events_spindle_S3_temp,1);

            spDns_stg2(CH) = spN_stg2(CH)/(sum(stages==2)*0.5);
            spDns_stg3(CH) = spN_stg3(CH)/(sum(stages==3)*0.5);



end
save([Out_dir strrep(edf_file,'_clean.edf','') '_spindle.mat'],...
        'Channels',...
        'spindle_intrv_stg2','spindle_intrv_stg3',...
        'spN_stg2','spN_stg3',...
        'spDns_stg2','spDns_stg3')

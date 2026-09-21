clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
addpath /mnt/tambinidata/scripts/
%sessions undefined?? see line 26
%set parameters used in every subject / session 
task_list = ["os"; 2; 216];%["os" "fsttest"; 2 1; 216 268];%matrix that holds tasks and trs and # of scans
[row_num,col_num]=size(task_list);
append = '_S1'; % to add to new filename
smo_k = 5; %4;% parameter for spatial smoothing (mm)  

%for loop for subjects 
for iss= length(ss_list)
    %open the subject directory and count session files 
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss];
    sessions = glob('ses*', ss_dir);
    if isempty(sessions)
        warning('Warning, no sessions found. Please check subject IDs and the paths are correct.');
    end

    for i_ses= 1:length(sessions) %only need session 1 and 3 for sleep
        %for each row check a different task and change parameters accordingly
        for i_col = 1:col_num
            task = char(task_list(1, i_col)); %change task string
            [filepath,name] = fileparts(char(sessions(i_ses)));
            ses = name; %session is equal to the name of the folder
            %check number of sessions to put correct amount of 0s 
            %num2str
            Nscans = int8(str2double(task_list(2, i_col))); %cchange # scans

            % Number of TRs is specific to each scan type
            Ntrs = str2double(task_list(3, i_col)); %change # trs
            % parameters for performing filtering
            filtparam = struct('RT',2, 'HParam',1/0.009, 'row',1:Ntrs);

            % path to files for subject, session
            func_dir = [preproc_dir ss '/' ses '/func/'];

            %file_str = ['*task-' task '*bold'];
            file_str = ['*task-' task '*MNI152NLin2009cAsym_desc-preproc_bold'];

            % check if there are zipped files that need to be unzipped
            fls_zip = glob([file_str '.nii.gz'], func_dir);
            if not(isempty(fls_zip))
                for ifile = 1:length(fls_zip)
                    unix(['gunzip ' fls_zip{ifile}]) %need permission
                end
            else %if you do not find any of these files move onto next task
                warning(['No task-' task ' files were found, continuing to next task.']);
            end

            % do processing on unzipped files
            fls = glob([file_str '.nii'], func_dir);

            % correct number of scans found?
            if length(fls)~=Nscans
                warning(['Incorrect # of ' task ' scan found for ' ss ' ' ses]); 
            end

            for ifile = 1:length(fls)

                % file information
                fl = fls{ifile};
                [p,f,e] = fileparts(fl);
                new_file = [p '/' f append e];

                % spatial smoothing
                spm_smooth(fl, new_file, smo_k)

                % performing temporal filtering
                % read in data
                 info = spm_vol(new_file);
                 data = spm_read_vols(info);
%                 data_sz = size(data);

                % data needs to be reshaped to 2D matrix, time x space before filter is applied
%                 data = reshape(data, [numel(data)/Ntrs Ntrs])';
%                 filt_data = spm_filter(filtparam, data); clear data

                % resize again before writing new file
%                 new_data = reshape(filt_data', data_sz); clear filt_data

                % write new filtered data to file
                for itr = 1:Ntrs
                    spm_write_vol(info(itr), data(:,:,:,itr)); %skip the filtering part
                end

                % zip original file
                unix(['gzip ' fl])
            end
        end
    end
end
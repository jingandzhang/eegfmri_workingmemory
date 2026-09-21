clear
load ss_info.mat
addpath /mnt/tambinidata/scripts/
%set parameters used in every subject / session 
task_list = ["sleep"; 1; 1];%matrix that holds tasks, # of runs, and # of trs 
%264 can be any number here since we will replace it later
[row_num,col_num]=size(task_list);
append = '_S1'; % to add to new filename
smo_k = 5; %4;% parameter for spatial smoothing (mm)  

%for loop for subjects 
for iss=34%:length(ss_list)
    %open the subject directory and count session files 
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss];
    sessions = glob('ses*', ss_dir);
    if isempty(sessions)
        warning('Warning, no sessions found. Please check subject IDs and the paths are correct.');
    end

    for i_ses = 3%1:2:length(sessions) %only need session 1 and 3 for sleep
        %for each row check a different task and change parameters accordingly
        for i_col = 1:col_num
            task = char(task_list(1, i_col)); %change task string
            [filepath,name] = fileparts(char(sessions(i_ses)));
            ses = name; %session is equal to the name of the folder
            %check number of sessions to put correct amount of 0s 
            %num2str
            Nscans = int8(str2double(task_list(2, i_col))); %change # scans % will update this when read the # of runs
            % Number of TRs is specific to each scan type
            Ntrs = str2double(task_list(3, i_col)); %change # trs % will update this when read the # of runs
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
                warning(['No task-' task ' files were found.']);
            end

            % do processing on unzipped files
            fls = glob([file_str '.nii'], func_dir);

            % correct number of runs found?
            if length(fls)~=Nscans
                warning(['Incorrect # of ' task ' scan found for ' ss ' ' ses 'reset Nscans']); 
                Nscans = length(fls);
            end
            
            
            for ifile = 1:length(fls) %within each run
                % check # of trs
                info = spm_vol(fls{ifile});
                %data = spm_read_vols(info); Not working Not sure why
                size_trs = size(info);
                Ntrs = size_trs(1);
                filtparam.row=1:Ntrs;
                
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
                data_sz = size(data);

                % data needs to be reshaped to 2D matrix, time x space before filter is applied
                data = reshape(data, [numel(data)/Ntrs Ntrs])';
                filt_data = spm_filter(filtparam, data); clear data

                % resize again before writing new file
                new_data = reshape(filt_data', data_sz); clear filt_data

                % write new filtered data to file
                for itr = 1:Ntrs
                    spm_write_vol(info(itr), new_data(:,:,:,itr));
                end
                clear new_data info

                % zip original file
                unix(['gzip ' fl])
            end
        end
    end
end
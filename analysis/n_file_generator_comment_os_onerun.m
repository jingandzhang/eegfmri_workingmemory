clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info_os.mat
addpath /mnt/tambinidata/sleepstudy/

%set parameters used in every subject / session and initializer other
%variables
append = '_task-os_nuisance_test'; % to add to new filename 
num_files=1; % # of scans / runs to concatenate together
Ndummy = 4; % # of dummy scans to create nuisance regressors for

% column names to extract from fmriprep .tsv file
der = '_derivative1';
cols =  {'trans_x', 'trans_y', 'trans_z', 'rot_x', 'rot_y', 'rot_z', ... % 6 motion parameters
    ['trans_x' der], ['trans_y' der], ['trans_z' der], ...
    ['rot_x' der], ['rot_y' der], ['rot_z' der], ... % 6 motion parameters 1st derivative
    'a_comp_cor_00','a_comp_cor_01','a_comp_cor_02','a_comp_cor_03', ... % anatomical compcor (WM, CSF) components (top 8)
    'a_comp_cor_04','a_comp_cor_05','a_comp_cor_06','a_comp_cor_07'};

FD_thr = .5; % threshold for FD timeseries
Ntrs = 216; % # of time points in each scan acquisition

% most likely dont need this 
% filtparam = struct('RT',2, 'HParam',1/0.009, 'row',1:Ntrs);

%for loop for subjects 
for iss=36

    %open the subject directory and count session files 
    ss = ss_list{iss};
    ss_dir = [preproc_dir ss];
    sessions_info = dir(fullfile([ss_dir '/ses*'])); %glob('ses*', ss_dir);
    ses_dir=sessions_info.folder;
    cd(ses_dir);
    sessions=struct2cell(sessions_info);
    sessions=sessions(1,:)';
    if isempty(sessions)
        warning('Warning, no sessions found. Please check subject IDs and the paths are correct.');
    end

    for i_ses=2 % loop over sessions
        [filepath,name] = fileparts(char(sessions(i_ses)));
        ses = name; %session is equal to the name of the folder 
        
        % path to .tsv files for subject, session
        func_dir = [preproc_dir ss '/' ses '/func/'];
        cd(func_dir);
        disp(func_dir);
        new_file_n = [func_dir '/' ss '_' ses append]; % new file name for nuisance regressors
        
        % gather .tsv files from fmriprep output - in correct order
        tsv_files=cell(1,num_files);
        for i=2 %find which run to include
            %find the localizer mat files to open and extract onset times
            file_str = [ss '_' ses '_' 'task-os_run-0' num2str(i) '_*'];
            tmp=struct2cell(dir(['*task-os_run-0' num2str(i) '*.tsv*'])); %tmp = glob([file_str '.tsv'], func_dir);
            tsv_files{1} = tmp(1);
        end
        x=1; y=1;
        comb_data = cell(1,length(cols)); % to hold all nuisance regressors
        rd_files = cell(1,num_files);
        % if the right amount of files are found begin importing data 
        if length(tsv_files)==num_files
            for ifile=1:length(tsv_files)
                %load tsv file
                rd_files{ifile} = tdfread(char(tsv_files{ifile}));
            end
            %fill the cell array with data 
            for i=1:length(cols) % each of the main data types specified in cols
                %temp cell matrix to hold importated data for each scan
                tmp = cell(1,num_files);
                %for each tsv file 
                for ifile=1:length(tsv_files)
                    %read in data from current tsv file importing into cell array
                    curr_data = getfield(rd_files{ifile}, cols{i});

                    if ischar(curr_data)
                        % remove n/a values
                        assert( strmatch(curr_data(1), 'n/a')==1 )
                        curr_data(1,1:end) = '0';
                        curr_data = str2num(curr_data);
                        assert( ~isempty(curr_data) )
                        
                    end
                        
                    tmp{ifile} = curr_data;
                        
                    % perform high pass filtering on mp parameters
                    % This only needs to be done if fMRI data has already been high pass filtered prior to running model
                    % if i<=13 
                    %    tmp{ifile} = spm_filter(filtparam, tmp{ifile}); 
                    % end
                end
                %combine data across multiple files into a single collumn and add it to the
                %matrix to output
                comb_data{i} = cat(1, tmp{:});
            end   

            % create regressors for dummy scans the rows of 0s with 1s in the correct locations 
            dummy = zeros(Ntrs*num_files, num_files*Ndummy);
            for ifile = 1:num_files
                for idummy = 1:Ndummy
                    %dummy(idummy + ((ifile-1)*Ntrs), idummy + ((ifile-1)*num_files) ) = 1;
                    % should be:
                    dummy(idummy + ((ifile-1)*Ntrs), idummy + ((ifile-1)*Ndummy) ) = 1;

                end
            end

            %convert to a matrix
            data=[cell2mat(comb_data) dummy];

            % check framewise displacement
            % add in 'spike' regressors for time points around motion (1 timepoint before, 2 after)
            tmp=cell(1,num_files);
            for ifile=1:length(tsv_files)
                %read in data from current tsv file importing into cell
                %array
                tmp{ifile} =rd_files{ifile}.framewise_displacement; 
                tmp{ifile} = [0;str2num(tmp{ifile}(2:end,:))];
                scrub = find(tmp{ifile} > FD_thr);
                if ~isempty(scrub)
                    list = [];
                    for ipt = 1:length(scrub)
                        list = [list; scrub(ipt)-1:scrub(ipt)+2];
                    end
                    % list of volumes (time points) that are motion-contaminated
                    list = unique(list);
                    list = list(list > Ndummy & list <= Ntrs); % dummy scans are already modeled
                    disp(['run ' num2str(ifile) ' volumes around motion:'])
                    disp(list)
                    list = list+(Ntrs*(ifile-1)); % adjust timing since runs are concatenated
                    
                    %matrix containiing 1's around motion
                    scrubvols = zeros(Ntrs*num_files, length(list));
                    for ipt = 1:length(list)
                       scrubvols(list(ipt),ipt) =1; 
                    end
                    data=cat(2,data,scrubvols);
                end
            end
            % save out in delimited text file (1 per session)
            % add subject id to name
            writematrix(data, new_file_n, 'Delimiter', ',');
            % to remove incorrect files
            % to_delete = [func_dir '/' name '_n.txt'];
            % delete(to_delete)
        else
            % warn user if wrong # of tsv files are found
            warning('Incorrect number of .tsv files were found in ' + ss + ' ' + ses + '.');
        end
   end
end
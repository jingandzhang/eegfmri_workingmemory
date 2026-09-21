clear
load /mnt/tambinidata/sleepstudy/analysis/ss_info.mat
addpath /mnt/tambinidata/scripts/
addpath /mnt/tambinidata/sleepstudy/analysis
iss=34%:length(ss_list)
ss = ss_list{iss};
i_ses= 1%:length(sessions) % loop over sessions
%i_run= 1%index of the scans
run_list=[1]
%set parameters used in every subject / session and initializer other
%variables
append = '_task-sleep_nuisance_nrem'; % to add to new filename 
num_files=length(run_list); % # of scans / runs to concatenate together %check for each subject
Ndummy = 0; % # of dummy scans to create nuisance regressors for

% column names to extract from fmriprep .tsv file
der = '_derivative1';
cols =  {'trans_x', 'trans_y', 'trans_z', 'rot_x', 'rot_y', 'rot_z', ... % 6 motion parameters
    ['trans_x' der], ['trans_y' der], ['trans_z' der], ...
    ['rot_x' der], ['rot_y' der], ['rot_z' der], ... % 6 motion parameters 1st derivative
    'a_comp_cor_00','a_comp_cor_01','a_comp_cor_02','a_comp_cor_03', ... % anatomical compcor (WM, CSF) components (top 8)
    'a_comp_cor_04','a_comp_cor_05','a_comp_cor_06','a_comp_cor_07'};

FD_thr = .5; % threshold for FD timeseries

%open the subject directory and count session files 
ss_dir = [preproc_dir ss];
sessions_info = dir(fullfile([ss_dir '/ses*'])); %glob('ses*', ss_dir);
ses_dir=sessions_info.folder;
cd(ses_dir);
sessions=struct2cell(sessions_info);
sessions=sessions(1,:)';
if isempty(sessions)
    warning('Warning, no sessions found. Please check subject IDs and the paths are correct.');
end

[filepath,name] = fileparts(char(sessions(i_ses)));
ses = name; %session is equal to the name of the folder 

% path to .tsv files for subject, session
func_dir = [preproc_dir ss '/' ses '/func/'];
cd(func_dir);
disp(func_dir);
new_file_n = [func_dir 'truncate/' ss '_' ses append]; % new file name for nuisance regressors

% gather .tsv files from fmriprep output - in correct order
tsv_files=cell(1,num_files);
selected_trs=cell(1,num_files);
Ntrs=cell(1,num_files);
for i=1:length(run_list)
    %find the localizer mat files to open and extract onset times
    file_str = [ss '_' ses '_' 'task-sleep_run-0' num2str(run_list(i)) '_*'];
    tmp = glob([file_str '.tsv'], func_dir);
    tsv_files{i} = tmp;
    sp_mrk = ['/mnt/tambinidata/sleepstudy/data/sleep_mrk/truncate/fmri_nrem_spindles_chunks_' (ss) '_ses' num2str(i_ses) '_run' num2str(run_list(i)) '.mat'];
    load(sp_mrk);
    selected_trs{i} = [cat(2,nrem_times(:).selected_tr)];
    Ntrs{i} = length(selected_trs{i}); % # of time points in each scan acquisition
end

x=1; y=1;
comb_data = cell(1,length(cols)); % to hold all nuisance regressors
%load tsv file
for ifile=1:length(tsv_files)
    rd_files{ifile} = tdfread(char(tsv_files{ifile}));
end

%%%%% arielle insert
your_TR = 2.24 % Not sure if this is correct
for ifile = 1:length(tsv_files)
    filtparam{ifile} = struct('RT',your_TR, 'HParam',1/0.009, 'row',1:length(rd_files{ifile}.csf));
end

%%%here
%fill the cell array with data
for i=1:length(cols) % each of the main data types specified in cols
    %temp cell matrix to hold importated data for each scan
    tmp = cell(1,num_files);
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
        
        
        %%% arielle insert
        if i < 7 % motion parameters
            curr_data = spm_filter(filtparam{ifile},curr_data);
        end
        tmp{ifile} = curr_data;
        
%        if ifile == 2
%            tmp{ifile} = tmp{ifile}(11:1852)          %123 run3
%        end
%           if ifile == 2
%               tmp{ifile} = tmp{ifile}(3:2088)  %124 run3
%           end
        %tmp{ifile} = tmp{ifile}(2140:3614); %123 v1 run1
        %tmp{ifile} = tmp{ifile}(58:4096); %133 v1 run1
        %tmp{ifile} = tmp{ifile}(5:2192); %116 v1 run3
        tmp{ifile} = tmp{ifile}(selected_trs{ifile});
    end
    comb_data{i} = cat(1, tmp{:});
end

%convert to a matrix
data=[cell2mat(comb_data)];

% check framewise displacement
% add in 'spike' regressors for time points around motion (1 timepoint before, 2 after)
    %read in data from current tsv file importing into cell
    %array
% check framewise displacement
% add in 'spike' regressors for time points around motion (1 timepoint before, 2 after)
tmp=cell(1,num_files);
for ifile=1:length(tsv_files)
    %read in data from current tsv file importing into cell    
    % Arielle mod
    tmp{ifile} = [0; str2num(rd_files{ifile}.framewise_displacement(2:end,:))];
    tmp{ifile} = tmp{ifile}(selected_trs{ifile});
    scrub = find(tmp{ifile} > FD_thr);
    if ~isempty(scrub)
        list = [];
        for ipt = 1:length(scrub)
            list = [list; scrub(ipt)-1:scrub(ipt)+2];
        end
        % list of volumes (time points) that are motion-contaminated
        list = unique(list);
        disp(['run ' num2str(ifile) ' volumes around motion:'])
        disp(list)
        disp(length(list))
        disp(selected_trs)
        if ifile==2 %pinchun added this
            list = list+Ntrs{ifile-1}; %cumsum % adjust timing since runs are concatenated %only work if two parts
        end
        % matrix containing 1's around motion events
        scrubvols = zeros(sum(cat(1,Ntrs{:})), length(list));
        for ipt = 1:length(list)
            scrubvols(list(ipt),ipt) = 1;
        end
        data=cat(2,data,scrubvols(1:length(data),:));
    else
        disp('framewise displacement all good')
    end
end

% save out in delimited text file (1 per session)
% add subject id to name
writematrix(data, new_file_n, 'Delimiter', ',');
cd /mnt/tambinidata/sleepstudy/analysis
% to remove incorrect files
% to_delete = [func_dir '/' name '_n.txt'];
% delete(to_delete)
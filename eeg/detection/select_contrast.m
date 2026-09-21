onsets_files = dir('onsets*');
for i=1:length(onsets_files)
    load(onsets_files(i).name);
    filename = onsets_files(i).name;
    filename = strrep(filename, '.mat', '');
    names = {names{:,[1,4]}};
    onsets = {onsets{:,[1,4]}};
    durations = {durations{:,[1,4]}};
    save([filename '_nrem.mat'], 'names', 'durations','onsets')
end
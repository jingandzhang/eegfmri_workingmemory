
load os_onsets.mat

names_new = {'math_math', 'os_math', 'baseline'};
onsets_new = {[],[]};
durations_new = {3, 3, 28};

Nitems = 7;
% math blocks - math equations
Nblocks = length(onsets{3});
for iblock = 1:Nblocks
    st = onsets{3}(iblock);
    for iitem = 1:Nitems
        onsets_new{1} = [onsets_new{1}, st + ((iitem-1)*4)];
    end
end

% ospan blocks - math equations
Nblocks = length(onsets{1});
for iblock = 1:Nblocks
    st = onsets{1}(iblock);
    for iitem = 1:Nitems
        onsets_new{2} = [onsets_new{2}, st + ((iitem-1)*4)];
    end
end

% baseline
onsets_new{3} = onsets{2};

% ospan - items
encoding_items_onsets = cell(1, Nblocks*Nitems);
encoding_items_durations = cell(1, Nblocks*Nitems);
encoding_items_names = cell(1, Nblocks*Nitems);
ret_items_onsets = cell(1, Nblocks*Nitems);
ret_items_durations = cell(1, Nblocks*Nitems);
ret_items_names = cell(1, Nblocks*Nitems);

cntr_e = 0; cntr_r = 0;
for iblock = 1:Nblocks

    st = onsets{1}(iblock);
    for iitem = 1:Nitems
        cntr_e = cntr_e+1;
        encoding_items_onsets{cntr_e} = st + 3 + (iitem-1)*4;
        encoding_items_durations{cntr_e} = 1;
        encoding_items_names{cntr_e} = ['E_block' num2str(iblock) '_item' num2str(iitem)];
    end

    st = onsets{4}(iblock);
    for iitem = 1:Nitems
        cntr_r = cntr_r+1;
        ret_items_onsets{cntr_r} = st + (iitem-1)*3;
        ret_items_durations{cntr_r} = 3;
        ret_items_names{cntr_r} = ['R_block' num2str(iblock) '_item' num2str(iitem)];
    end

end

onsets = cat(2, onsets_new, encoding_items_onsets, ret_items_onsets);
names = cat(2, names_new, encoding_items_names, ret_items_names);
durations = cat(2, durations_new, encoding_items_durations, ret_items_durations);

save('os_onsets_peritem.mat', 'names', 'durations', 'onsets')
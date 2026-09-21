
load /mnt/tambinidata/scripts/colormap_red-to-blue.mat

%top = [128 0 128]/256; % purple

middle = [.2 0 .8]; %blue

%bottom = [.8 0 .2]; %red
bottom = [.2 0 .8]; %change bottom to blue
top = [.2 0 .8]; % blue


idx = 33;
cmap(1:idx,:) = repmat(top,[idx 1]);

cmap(idx+1:(2*idx),:) = repmat(middle,[idx 1]);
cmap((2*idx)+1:end,:) = repmat(bottom,[idx+1 1]);

cmap = flipud(cmap);

load /mnt/tambinidata/ScanTrain/analysis/brainnet_opt_map_mean.mat
EC.vol.CMt = cmap;
EC.vol.CM = cmap;
save('brainnet_options_PurpleColorMap_forfig5.mat','EC') % options file to load into brainnet viewer

colormap(cmap)
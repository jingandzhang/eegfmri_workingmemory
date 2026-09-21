
clear
addpath /mnt/tambinidata/scripts/
data_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/';

ss_list = glob('sub-*', data_dir);
ss_list = ss_list(~contains(ss_list, 'html'));


Ns = length(ss_list);
Nses = 4;
FD_thr = .5;

scan_nms = {'os';};
Nscan_per = [2];

Ntrs = 216;
remove = NaN(Ntrs, Nscan_per, Nses, Ns);

Ntypes = length(scan_nms);

mean_fd = cell(Ntypes,1);
% Ntrs = mean_fd; 
Rem = mean_fd; Rem_n = mean_fd;
for itype = 1:Ntypes
    mean_fd{itype} = NaN(Nses, Nscan_per(itype), Ns);
%     Ntrs{itype} = mean_fd{itype};
    Rem{itype} = mean_fd{itype};
    Rem_n{itype} = mean_fd{itype};
   
end

for iss = 1:Ns
    ss_dir = ss_list{iss}
    for ises = 1:Nses
        ses = ['ses-' num2str(ises)];
        
        c_dir = [ss_dir '/' ses '/func/'];
        
        for itype = 1:Ntypes
           
            fls = glob(['*' scan_nms{itype} '*.tsv'], c_dir);
            if ~iscell(fls); tmp = fls; clear fls; fls{1} = tmp; end
            
            for ifl = 1:length(fls)
            
                dat = tdfread(fls{ifl});
                if isfield(dat, 'framewise_displacement')
                    fdstr = dat.framewise_displacement; clear dat;
                    fd = [0;str2num(fdstr(2:end,:))];
                else
                    mp = [dat.trans_x dat.trans_y dat.trans_z dat.rot_x dat.rot_y dat.rot_z];
                    fd = [0;compute_fd(mp, 1)];
                end
                
                scrub = find(fd > FD_thr);
                list = [];
                if ~isempty(scrub)
                    for ipt = 1:length(scrub)
                        list = [list; scrub(ipt)-1:scrub(ipt)+2];
                    end
                    list = unique(list);
                    list = list(list > 0 & list <= length(fd));
                    scrubvols = zeros(length(fd), length(list));
                    for ipt = 1:length(list)
                        scrubvols(list(ipt),ipt) = 1;
                    end
                    if size(list,1)==1; list = list'; end
%                     scruball = [scruball; list iscan*ones(length(list),1) ises*ones(length(list),1)];

                end
                
                remove(list, ifl, ises, iss) = 1;
                remove(setdiff(1:Ntrs, list), ifl, ises, iss) = 0;
                
                mean_fd{itype}(ises,ifl,iss) = nanmean(fd);
%                 Ntrs{itype}(ises,ifl,iss) = length(fd);
                Rem{itype}(ises,ifl,iss) = length(~isnan(list))/length(~isnan(fd));
                Rem_n{itype}(ises,ifl,iss) = length(~isnan(list));
            end
        end
    end
end

%save('motion_info.mat','remove','FD_thr','data','ss_l')


%%

data_types = {mean_fd; Rem};
data_names = {'Mean FD';'Prop. Volumes Removed'};

for itype = 1:length(data_types)

    all = [];
    ss_key = [];
    data = data_types{itype};
    data_name = data_names{itype};

    for iss = 1:Ns

        ss_dir = ss_list{iss};
        ss_l(iss) = str2double(ss_dir(end-2:end));
        curr = data{1}(:,:,iss);
        all = [all; curr(:)];
        ss_key = [ss_key; ss_l(iss)*ones(size(curr(:)))];
    end

    avg_fd = nanmean(all);
    twosigma = 2*nanstd(all);
    upperbound = avg_fd + twosigma;
    disp([data_name ': ' num2str(avg_fd)])
    disp(['upper thresh ' data_name ': ' num2str(upperbound)])

    figure;scatter(ss_key, all)
    hold on;
    ylabel([data_name ' per scan'])
    xl = xlim;
    plot(xl, upperbound*ones(1,2),'r--')
    
    data = data{1};
    pmam(:,1) = squeeze(nanmean(data(1,:,:),2)-nanmean(data(2,:,:),2));
    pmam(:,2) = squeeze(nanmean(data(3,:,:),2)-nanmean(data(4,:,:),2));
    
end
%find the scans to be deleted
%idx=find(all>0.5) %find the index of the scan removed
% session=repmat([1,3,5,7,2,4,6,8]',40,1);
%sid=ss_key(idx);
%ses=session(idx);
%session number dictionary 
%1 v1s1r1
%2 v1s1r2
%3 v1s2r1
%4 v1s2r2
%5 v2s1r1
%6 v2s1r2
%7 v2s2r1
%8 v2s2r2

%%
% 
% 
% %%
% to_fix = 0;
% to_save = 1;
% 
% data = Rem;
% save_nm = ['Prop_remove_fd_' num2str(FD_thr)];
% title_str = ['Prop. of time points to remove (thr = ' num2str(FD_thr) ')'];
%

% % clim = [0 .35];
% % data = mean_fd;
% % save_nm = 'mean_fd';
% % title_str = 'Mean FD';
% 
% xlbl{1} = {'R1';'Loc1';'Loc2';'Loc3';'LB1';'LB2';'LB3';'R2';'Loc4';'WM1';'WM2';'WM3';'WM4'};
% xlbl{2} = {'R1';'Loc1';'Loc2';'Loc3';'Loc4';'LB1';'LB2';'LB3';'R2';'Loc5';'Loc6';'WM1';'WM2';'WM3';'WM4'};
% 
% if to_fix==1; append = '_fixscale'; else; append = ''; end
% round_name = {'First';'Second'};
% %%
% for iss = 1:3
%     ss = ['sub-00' num2str(iss)];
% 
%     for iround = 1:2
%     
%         if iround==1
%             s_idx = 1:Nses(iss);
%             d = [data{1}(s_idx,1,iss) data{2}(s_idx,1:3,iss) data{3}(s_idx,:,iss) data{1}(s_idx,2,iss) ...
%                 data{2}(s_idx,4,iss) data{4}(s_idx,1:4,iss)];
%         else; s_idx = sr_st(iss):Nses_t(iss);
%             
%             d = [data{1}(s_idx,1,iss) data{2}(s_idx,1:4,iss) data{3}(s_idx,:,iss) data{1}(s_idx,2,iss) ...
%                 data{2}(s_idx,5:6,iss) data{4}(s_idx,1:4,iss)];
%         end
%         figure; set_figsize([900 600])
%         if to_fix==1
%             imagesc(d,clim)
%         else; imagesc(d)
%         end
%         hold on;colorbar
%         for ises = 1:size(d,1)
%             for iscan = 1:size(d,2)
%                 if isnan(d(ises,iscan)); plot(iscan,ises,'kp','MarkerFaceColor','k'); end
%             end
%         end
% 
%         title([ss ' ; ' title_str ' ; ' round_name{iround} 'Round'])
%         ylabel('Session #')
%         set(gca,'XTick',1:length(xlbl{iround}),'XTickLabel',xlbl{iround},'FontSize',14)
%         if iround==2
%             set(gca,'YTick',1:length(s_idx),'YTickLabel',s_idx)
%         end
% 
%         if to_save==1;
%             saveas(gcf,['motion/' save_nm '_' ss append '_round' num2str(iround) '.tiff'],'tiff')
%             close gcf
%         end
%     end
%     
%     
% end
           
%%
iss=2;
d = [];
for itype = 1:Ntypes
    d = [d Rem{itype}(:,:,iss)];% Ntrs{itype}(:,:,iss)];
end

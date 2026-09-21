
addpath /mnt/tambinidata/scripts/
Nsub = 38;
T_crit = -tinv(.01, Nsub); %0.01


roi_dir = '/mnt/tambinidata/atlas/Yeo_JNeurophysiol11_MNI152/100parcels/';
Nrois = 100;
tvalue_avg = zeros(Nrois,1);

for iroi = 1:Nrois

% iroi = 1; % loop through ROIs 1 - X

    roi_file = [roi_dir 'roi_' num2str(iroi) '.nii'];

    assert(exist(roi_file)==2)

    % Step 1: Isolate ROIs that show OSPAN > MATH activation

    group_data_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/positive/';

    tstat_map = [group_data_dir 'OneSampT_tstat1.nii'];

    assert(exist(tstat_map)==2)

    tvalue_avg(iroi) = rex(tstat_map, roi_file, 'select_clusters', 0);%, 'level', 'voxels');

end

%%

roi_list = find(tvalue_avg > T_crit);
Nrois_sig = length(roi_list);

% eventually loop over ROIs
%ss_list = glob('sub-*', '/mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/');
%ss_list = ss_list(~contains(ss_list,'html'));

load ss_info_os.mat

Nsub=38;
T_subj_thr = -tinv(.01, 384);
Prop = NaN(Nsub, 4, Nrois_sig); Mean = Prop;
for iroi_sig = 1:Nrois_sig
    iroi_loop = roi_list(iroi_sig);
    roi_file = [roi_dir 'roi_' num2str(iroi_loop) '.nii'];

    for iss = 1:length(ss_list)%Nsub
        ss = ss_list{iss};
        ss_dir = [preproc_dir ss];
        ses_dirs = ses_list{iss};
        for ises = ses_dirs;
            spm_dir = [ss_dir '/ses-' num2str(ises) '/spm_os_model1_test/']

            if isdir(spm_dir)
                tstat_file = glob('sub*spmT_ospan_vs_math.nii', spm_dir);
                assert(length(tstat_file)==1)

                data = rex(tstat_file{1}, roi_file, 'level','voxels','select_clusters',0);

                Mean(iss, ises, iroi_sig) = nanmean(data);
                Prop(iss, ises, iroi_sig) = nanmean(data > T_subj_thr);

            end

        end

    end
end
save('voxel_num_p01_100parcel.mat','tvalue_avg','Mean', 'Prop','roi_list');
%%
Nrois_sig=30
tval=NaN(1,Nrois_sig);
pval=NaN(1,Nrois_sig);
for i=1:Nrois_sig
   data_roi=Prop(:,:,i);
   %[H,P,ci,stat]=ttest(nanmean(data_roi(:,1:2:3),2),nanmean(data_roi(:,2:2:4),2)) %session 1 and 3 avg & 2 4 avg
   %[H,P,ci,stat]=ttest(nanmean(data_roi(:,1),2),nanmean(data_roi(:,2),2))
   %[H,P,ci,stat]=ttest(nanmean(data_roi(:,3),2),nanmean(data_roi(:,4),2))
   %[H,P,ci,stat]=ttest(mean(data_roi(:,1:2:3),2),mean(data_roi(:,2:2:4),2))
   %[H,P,ci,stat]=ttest(mean(data_roi(:,1:2:3),2))
   [H,P,ci,stat]=ttest(data_roi(:,1),data_roi(:,2))
   tval(i)=stat.tstat;
   pval(i)=P;
end

%%
FDR = mafdr(pval,'BHFDR',true)

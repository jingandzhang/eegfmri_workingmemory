
%load cluster data
cluster_fl= '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_vs_ampm_corr/cluster_index_fdr_xaxisso_neg.nii';
info_cluster = spm_vol(cluster_fl);  
cluster_data = spm_read_vols(info_cluster);

cluster_data_cleaned_index = (cluster_data>4);
cluster_data_cleaned = cluster_data(cluster_data_cleaned_index);

addpath /mnt/tambinidata/scripts/
load ss_info.mat
load ss_info_os.mat


so_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/so_indiv/';
so_ss_fls = glob('v*.nii', so_dir);

for i=1:length(so_ss_fls)
    sid=so_ss_fls{i}(end-14:end-11);
    visit=so_ss_fls{i}(end-20);
    so_ss_list{i}=strcat(sid,visit);
end  

os_dir = '/mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/';
os_ss_fls = glob('v*am-pm_ospan_vs_math.nii', os_dir);

for i=1:length(os_ss_fls)
    sid=os_ss_fls{i}(end-26:end-23);
    visit=os_ss_fls{i}(end-32);
    os_ss_list{i}=strcat(sid,visit);
end  
ss_ospan= os_ss_fls(find(ismember(os_ss_list,so_ss_list)));
ss_so= so_ss_fls(find(ismember(so_ss_list,os_ss_list)));

reshaped_os_data=nan(length(ss_ospan),240120); %initiate hardcoded voxel num
reshaped_so_data=nan(length(ss_ospan),240120); 

for j=1:length(ss_ospan)
    info_os = spm_vol(ss_ospan{j}); %(so_map{1});
    os_data = spm_read_vols(info_os);
    dims_os=size(os_data);
    reshaped_os_data(j, :)=reshape(os_data,1,[]);
    info_so = spm_vol(ss_so{j}); %(so_map{1});
    so_data = spm_read_vols(info_so);
    dims_so=size(so_data);
    reshaped_so_data(j, :)=reshape(so_data,1,[]);

end 

reshaped_index = reshape(cluster_data_cleaned_index, [1,240120]);
averaged_os_data=mean(reshaped_os_data(:,reshaped_index),2);
averaged_so_data=mean(reshaped_so_data(:,reshaped_index),2);

%averaged_os_data_nooutlier =averaged_os_data (averaged_os_data>-5);
%averaged_so_data_nooutlier =averaged_so_data (averaged_os_data>-5);


[coeff,stats,r] = arobustfit(averaged_so_data,averaged_os_data);
figure(1)
linregplotdata_robust_corrtext(averaged_so_data,averaged_os_data)
ylim([-0.5 0.5])
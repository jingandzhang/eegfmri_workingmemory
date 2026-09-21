#!/bin/bash
################################ OS vs math
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/complete2v/positive/
cluster -i fdr_vox_p_tstat1.nii.gz -t .95 -o cluster_index_fdr > cluster_info_fdr.txt
for i_clust in 13 12 11 10 9 8 7
	do
	fslmaths -dt int cluster_index_fdr.nii.gz -thr ${i_clust} -uthr ${i_clust} -bin cluster_fdr_mask${i_clust}
done

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/positive/
cluster -i fdr_vox_p_tstat1.nii.gz -t .95 -o cluster_index_fdr > cluster_info_fdr.txt
for i_clust in 19 18 17 16 15 14 13 12 11 10
	do
	fslmaths -dt int cluster_index_fdr.nii.gz -thr ${i_clust} -uthr ${i_clust} -bin cluster_fdr_mask${i_clust}
done

fslmaths -dt int cluster_index_fdr.nii.gz -thr 19 18 16 15 13 10 -uthr 19 18 16 15 13 10 -bin cluster_fdr_mask_merged

fslmaths cluster_fdr_mask19 -add cluster_fdr_mask18 -add cluster_fdr_mask16 -add cluster_fdr_mask15 -add cluster_fdr_mask13 -add cluster_fdr_mask10 cluster_fdr_mask_merged

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math_load/allsessions/allsub/visualize/

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/fir_so/visualize/beta3
cluster -i pos_fdr_03_vox_p_tstat1.nii.gz -t .95 -o cluster_fdr_03_pos
fslmaths -dt int cluster_fdr_03_pos.nii.gz -bin cluster_fdrmask_03_pos
cluster -i neg_fdr_03_vox_p_tstat1.nii.gz -t .95 -o cluster_fdr_03_neg
fslmaths -dt int cluster_fdr_03_neg.nii.gz -bin cluster_fdrmask_03_neg
fslmaths cluster_fdrmask_03_pos -add cluster_fdrmask_03_neg cluster_fdrmask_03_both
fslmaths cluster_fdrmask_03_both -mul OneSampT_03_tstat1.nii.gz OneSampT_03_fdrmask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/fir_so/visualize/beta4
cluster -i pos_fdr_04_vox_p_tstat1.nii.gz -t .95 -o cluster_fdr_04_pos
fslmaths -dt int cluster_fdr_04_pos.nii.gz -bin cluster_fdrmask_04_pos
cluster -i neg_fdr_04_vox_p_tstat1.nii.gz -t .95 -o cluster_fdr_04_neg
fslmaths -dt int cluster_fdr_04_neg.nii.gz -bin cluster_fdrmask_04_neg
fslmaths cluster_fdrmask_04_pos -add cluster_fdrmask_04_neg cluster_fdrmask_04_both
fslmaths cluster_fdrmask_04_both -mul pos_OneSampT_04_tstat1.nii.gz OneSampT_04_fdrmask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_nrem/fir_so/visualize/beta5
cluster -i pos_fdr_05_vox_p_tstat1.nii.gz -t .95 -o cluster_fdr_05_pos
fslmaths -dt int cluster_fdr_05_pos.nii.gz -bin cluster_fdrmask_05_pos
cluster -i neg_fdr_05_vox_p_tstat1.nii.gz -t .95 -o cluster_fdr_05_neg
fslmaths -dt int cluster_fdr_05_neg.nii.gz -bin cluster_fdrmask_05_neg
fslmaths cluster_fdrmask_05_pos -add cluster_fdrmask_05_neg cluster_fdrmask_05_both
fslmaths cluster_fdrmask_05_both -mul pos_OneSampT_05_tstat1.nii.gz OneSampT_05_fdrmask


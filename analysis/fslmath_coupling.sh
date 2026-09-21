#!/bin/bash
#105 106 107 108 111 112 113
#105 106 107 108 111 112 113 114 115 116 118 121 123 124 125 126 127 130 131 132 133 135 136 137 138 142 #144
#106 107 108 111 112 113 114 115 116 118 123 124 125 126 127 130 132 133 135 136 137 138 142 144
for subj in 106 107 108 111 112 113 114 115 116 118 123 124 125 126 127 130 132 133 135 136 137 138 142 144 148 149 
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-1/spm_nrem_coupling_model1_test/sub-${subj}_ses-1_con_coupled_vs_uncoupled_so_nrem.nii -nan ../../../group/coupled_vs_uncoupled/v1_sub-${subj}_coupled_vs_uncoupled

	fslmaths ses-3/spm_nrem_coupling_model1_test/sub-${subj}_ses-3_con_coupled_vs_uncoupled_so_nrem.nii -nan ../../../group/coupled_vs_uncoupled/v2_sub-${subj}_coupled_vs_uncoupled

	fslmaths ses-1/spm_nrem_coupling_model1_test/sub-${subj}_ses-1_con_coupled_vs_uncoupled_so_nrem.nii -add ses-3/spm_nrem_coupling_model1_test/sub-${subj}_ses-3_con_coupled_vs_uncoupled_so_nrem.nii -div 2 -nan ../../../group/coupled_vs_uncoupled/average_sub-${subj}_coupled_vs_uncoupled

done



for subj in 105 121
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-3/spm_nrem_coupling_model1_test/sub-${subj}_ses-3_con_coupled_vs_uncoupled_so_nrem.nii -nan ../../../group/coupled_vs_uncoupled/v2_sub-${subj}_coupled_vs_uncoupled

	fslmaths ses-3/spm_nrem_coupling_model1_test/sub-${subj}_ses-3_con_coupled_vs_uncoupled_so_nrem.nii -nan ../../../group/coupled_vs_uncoupled/average_sub-${subj}_coupled_vs_uncoupled


done

for subj in 131
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-1/spm_nrem_coupling_model1_test/sub-${subj}_ses-1_con_coupled_vs_uncoupled_so_nrem.nii -nan ../../../group/sp_nrem/v1_sub-${subj}_coupled_vs_uncoupled

	fslmaths ses-1/spm_nrem_coupling_model1_test/sub-${subj}_ses-1_con_coupled_vs_uncoupled_so_nrem.nii -nan ../../../group/coupled_vs_uncoupled/average_sub-${subj}_coupled_vs_uncoupled


done


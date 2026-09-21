#!/bin/bash
#105 106 107 108 111 112 113 138 142 144 148 149 152 153 154 156 160
#105 106 107 108 111 112 113 114 115 116 118 121 123 124 125 126 127 130 131 132 133 135 136 137 138 142 #144
#106 107 108 111 112 113 114 115 116 118 123 124 125 126 127 130 132 133 135 136 137 138 142 144 148 149 152 153 154 156 160
for subj in  138 142 144 148 149 152 153 154 156 160
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_upstate.nii -nan ../../../group/so_up/v1_sub-${subj}_upstate

	fslmaths ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_upstate.nii -nan ../../../group/so_up/v2_sub-${subj}_upstate

	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_upstate.nii -add ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_upstate.nii -div 2 -nan ../../../group/so_up/average_sub-${subj}_upstate

done

for subj in 106 107 108 111 112 113 114 115 116 118 123 124 125 126 127 130 132 133 135 136 137 138 142 144 148 149 152 153 154 156 160
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_downstate.nii -nan ../../../group/so_down/v1_sub-${subj}_downstate

	fslmaths ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_downstate.nii -nan ../../../group/so_down/v2_sub-${subj}_downstate

	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_downstate.nii -add ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_downstate.nii -div 2 -nan ../../../group/so_down/average_sub-${subj}_downstate


done

for subj in 106 107 108 111 112 113 114 115 116 118 123 124 125 126 127 130 132 133 135 136 137 138 142 144 148 149 152 153 154 156 160
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_upvsdown.nii -nan ../../../group/so_upvsdown/v1_sub-${subj}_upvsdown

	fslmaths ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_upvsdown.nii -nan ../../../group/so_upvsdown/v2_sub-${subj}_upvsdown

	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_upvsdown.nii -add ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_upvsdown.nii -div 2 -nan ../../../group/so_upvsdown/average_sub-${subj}_upvsdown

done

for subj in 105 121
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_upstate.nii -nan ../../../group/so_up/v2_sub-${subj}_upstate

	fslmaths ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_upstate.nii -nan ../../../group/so_up/average_sub-${subj}_upstate

	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_downstate.nii -nan ../../../group/so_down/v2_sub-${subj}_downstate

	fslmaths ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_downstate.nii -nan ../../../group/so_down/average_sub-${subj}_downstate

	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_upvsdown.nii -nan ../../../group/so_upvsdown/v2_sub-${subj}_upvsdown

	fslmaths ses-3/spm_nrem_model1_phase/sub-${subj}_ses-3_con_upvsdown.nii -nan ../../../group/so_upvsdown/average_sub-${subj}_upvsdown

done

for subj in 131
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_upstate.nii -nan ../../../group/so_up/v1_sub-${subj}_upstate

	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_upstate.nii -nan ../../../group/so_up/average_sub-${subj}_upstate

	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_downstate.nii -nan ../../../group/so_down/v1_sub-${subj}_downstate

	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_downstate.nii -nan ../../../group/so_down/average_sub-${subj}_downstate

	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_upvsdown.nii -nan ../../../group/so_upvsdown/v1_sub-${subj}_upvsdown

	fslmaths ses-1/spm_nrem_model1_phase/sub-${subj}_ses-1_con_upvsdown.nii -nan ../../../group/so_upvsdown/average_sub-${subj}_upvsdown

done


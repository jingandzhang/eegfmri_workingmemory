#!/bin/bash
#105 106 107 108 111 112 113
#105 106 107 108 111 112 113 114 115 116 118 121 123 124 125 126 127 130 131 132 133 135 136 137 138 142 144
for subj in 105 106 107 108 111 112 113 114 115 116 118 121 123 124 125 126 127 130 131 132 133 135 136 137 138 142 144 148 149
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	for areai in Post_L_Hipp Post_R_Hipp L_Caud R_Caud
		do 
	
		# AM - PM 
		fslmaths ses-2/spm_os_model1_ppi_${areai}/con_0001.nii -sub ses-1/spm_os_model1_ppi_${areai}/con_0001.nii -add ses-4/spm_os_model1_ppi_${areai}/con_0001.nii -sub ses-3/spm_os_model1_ppi_${areai}/con_0001.nii -div 2 -nan ../../../group/ppi_os/sub-${subj}_am-pm_${areai}


		# Average all sessions 
		fslmaths ses-1/spm_os_model1_ppi_${areai}/con_0001.nii -add ses-2/spm_os_model1_ppi_${areai}/con_0001.nii -add ses-3/spm_os_model1_ppi_${areai}/con_0001.nii -add ses-4/spm_os_model1_ppi_${areai}/con_0001.nii -div 4 -nan ../../../group/ppi_os/sub-${subj}_allsessions_${areai}

		# AM average
		fslmaths ses-2/spm_os_model1_ppi_${areai}/con_0001.nii -add ses-4/spm_os_model1_ppi_${areai}/con_0001.nii -div 2 -nan ../../../group/ppi_os/sub-${subj}_amaverage_${areai}

	
		# PM average 
		fslmaths ses-1/spm_os_model1_ppi_${areai}/con_0001.nii -add ses-3/spm_os_model1_ppi_${areai}/con_0001.nii -div 2 -nan ../../../group/ppi_os/sub-${subj}_pmaverage_${areai}

	done 
done

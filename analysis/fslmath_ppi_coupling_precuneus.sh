#!/bin/bash
#105 106 107 108 111 112 113
#105 106 107 108 111 112 113 114 115 116 118 121 123 124 125 126 127 130 131 132 133 135 136 137 138 142 144107 108 111 112 113 114 115 116 118 121 123 124 125 126 
for subj in 106 107 108 111 112 113 114 115 116 118 123 124 125 126 127 130 131 132 133 135 136 137 138 142 144 148 149 152 153 154 156 160
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	for areai in precuneus
		do 

		# Average all sessions 
		fslmaths ses-1/spm_nrem_indiv_so_model1_ppi_${areai}/con_0001.nii -add ses-3/spm_nrem_coupling_model1_ppi_${areai}/con_0001.nii -div 2 -nan ../../../group/ppi_indiv_so_precuneus/sub-${subj}_allsessions_${areai}

		# v1 average
		fslmaths ses-1/spm_nrem_indiv_so_model1_ppi_${areai}/con_0001.nii -nan ../../../group/ppi_indiv_so_precuneus/sub-${subj}_v1average_${areai}

	
		# v2 average 
		fslmaths ses-3/spm_nrem_indiv_so_model1_ppi_${areai}/con_0001.nii -nan ../../../group/ppi_indiv_so_precuneus/sub-${subj}_v2average_${areai}

	done 
done


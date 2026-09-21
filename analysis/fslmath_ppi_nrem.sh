#!/bin/bash
#105 106 107 108 111 112 113
#105 106 107 108 111 112 113 114 115 116 118 121 123 124 125 126 127 130 131 132 133 135 136 137 138 142 144
for subj in  107 108 111 112 113 114 115 116 118 123 124 125 126 127 130 131 132 133 135 136 137 138 142 144 #148 149 106
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}
	for areai in vmPFC R_Hipp L_Hipp R_Thal L_Thal 

# R_Hipp L_Hipp R_Thal L_Thal vmPFC P nremt_R_Hipp P nremt_L_Hipp Mid_R_Hipp Mid_L_Hipp Ant_R_Hipp Ant_L_Hipp L_Puta R_Puta L_Stri R_Stri R_Hipp L_Hipp # R_Accu L_Accu R_Pall L_Pall R_Lc L_Lc 
		do 
	
		# Average all sessions 
		fslmaths ses-1/spm_nrem_model1_ppi_${areai}/con_0001.nii -add ses-3/spm_nrem_model1_ppi_${areai}/con_0001.nii -div 2 -nan ../../../group/ppi_nrem/sub-${subj}_allsessions_${areai}

		# v1 average
		fslmaths ses-1/spm_nrem_model1_ppi_${areai}/con_0001.nii -nan ../../../group/ppi_nrem/sub-${subj}_v1average_${areai}

	
		# v2 average 
		fslmaths ses-3/spm_nrem_model1_ppi_${areai}/con_0001.nii -nan ../../../group/ppi_nrem/sub-${subj}_v2average_${areai}

	done 
done

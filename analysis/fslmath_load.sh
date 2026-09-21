#!/bin/bash
#105 106 107 108 111 112 113
#105 106 108 111 112 113 114 115 116 118 121 123 124 125 126 127 130 131 132 133 135 136 137 138 142 144
#102 103 105 106 107 108 111 112 113 114 115 116 118 121 123 124 125 126 130 131 132 133 135 137 138 142 144 148 149 154 156 157
for subj in 120
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}

	# AM - PM  Ospen vs Math
	fslmaths ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -sub ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -add ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -sub ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -div 2 -nan ../../../group/ospan_vs_math_load/sub-${subj}_am-pm_ospan_vs_math_load



	# Average all sessions Ospen vs Math
	fslmaths ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -add ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -add ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -add ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -div 4 -nan ../../../group/ospan_vs_math_load/sub-${subj}_allsessions_ospan_vs_math_load


	# AM average Ospen vs Math
	fslmaths ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -add ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -div 2 -nan ../../../group/ospan_vs_math_load/sub-${subj}_amaverage_ospan_vs_math_load


	# PM average Ospen vs Math
	fslmaths ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -add ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -div 2 -nan ../../../group/ospan_vs_math_load/sub-${subj}_pmaverage_ospan_vs_math_load




#####V1 only
	# AM - PM  Ospen vs Math
	fslmaths ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -sub ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/v1_sub-${subj}_am-pm_ospan_vs_math_load


	# Average all sessions Ospen vs Math
	fslmaths ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -add ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -div 2 -nan ../../../group/ospan_vs_math_load/v1_sub-${subj}_allsessions_ospan_vs_math_load


	# AM average Ospen vs Math
	fslmaths ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/v1_sub-${subj}_amaverage_ospan_vs_math_load


	# PM average Ospen vs Math
	fslmaths ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/v1_sub-${subj}_pmaverage_ospan_vs_math_load

#####V2 only
	# AM - PM  Ospen vs Math
	fslmaths ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -sub ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/v2_sub-${subj}_am-pm_ospan_vs_math_load


	# Average all sessions Ospen vs Math
	fslmaths ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -add ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -div 2 -nan ../../../group/ospan_vs_math_load/v2_sub-${subj}_allsessions_ospan_vs_math_load


	# AM average Ospen vs Math
	fslmaths ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/v2_sub-${subj}_amaverage_ospan_vs_math_load


	# PM average Ospen vs Math
	fslmaths ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/v2_sub-${subj}_pmaverage_ospan_vs_math_load


done

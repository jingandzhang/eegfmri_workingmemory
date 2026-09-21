
for subj in 107 #removed v1 due to motion
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}

	# AM - PM  Ospen vs Math
	fslmaths ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -sub ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/sub-${subj}_am-pm_ospan_vs_math_load


	# Average all sessions Ospen vs Math
	fslmaths ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -add ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -div 2 -nan ../../../group/ospan_vs_math_load/sub-${subj}_allsessions_ospan_vs_math_load


	# AM average Ospen vs Math
	fslmaths ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/sub-${subj}_amaverage_ospan_vs_math_load

	# PM average Ospen vs Math
	fslmaths ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -add ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -div 2 -nan ../../../group/ospan_vs_math_load/sub-${subj}_pmaverage_ospan_vs_math_load

done

for subj in 127 #removed session 3 due to motion
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}

	# AM - PM  Ospen vs Math
	fslmaths ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -sub ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/sub-${subj}_am-pm_ospan_vs_math_load

	# Average all sessions Ospen vs Math
	fslmaths ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -add ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -add ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -div 3 -nan ../../../group/ospan_vs_math_load/sub-${subj}_allsessions_ospan_vs_math_load

	# AM average Ospen vs Math
	fslmaths ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -add ses-4/spm_os_model1_load/sub-${subj}_ses-4_con_ospanL_vs_mathL.nii -div 2 -nan ../../../group/ospan_vs_math_load/sub-${subj}_amaverage_ospan_vs_math_load

	# PM average Ospen vs Math
	fslmaths ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/sub-${subj}_pmaverage_ospan_vs_math_load
done

for subj in 136 #removed session 4 due to motion
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}

	# AM - PM  Ospen vs Math
	fslmaths ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -sub ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/sub-${subj}_am-pm_ospan_vs_math_load

	# Average all sessions Ospen vs Math
	fslmaths ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -add ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -add ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -div 3 -nan ../../../group/ospan_vs_math_load/sub-${subj}_allsessions_ospan_vs_math_load

	# AM average Ospen vs Math
	fslmaths ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/sub-${subj}_amaverage_ospan_vs_math_load


	# PM average Ospen vs Math
	fslmaths ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -add ses-3/spm_os_model1_load/sub-${subj}_ses-3_con_ospanL_vs_mathL.nii -div 2 -nan ../../../group/ospan_vs_math_load/sub-${subj}_pmaverage_ospan_vs_math_load

done

for subj in 145 #removed session 3 due to motion
	do
	cd /mnt/tambinidata/sleepstudy/data/derivatives/mriprep/fmriprep/sub-${subj}

	# AM - PM  Ospen vs Math
	fslmaths ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -sub ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/sub-${subj}_am-pm_ospan_vs_math_load

	# Average all sessions Ospen vs Math
	fslmaths ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -add ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -div 2 -nan ../../../group/ospan_vs_math_load/sub-${subj}_allsessions_ospan_vs_math_load


	# AM average Ospen vs Math
	fslmaths ses-2/spm_os_model1_load/sub-${subj}_ses-2_con_ospanL_vs_mathL.nii -div 1 -nan ../../../group/ospan_vs_math_load/sub-${subj}_amaverage_ospan_vs_math_load

	# PM average Ospen vs Math
	fslmaths ses-1/spm_os_model1_load/sub-${subj}_ses-1_con_ospanL_vs_mathL.nii -nan ../../../group/ospan_vs_math_load/sub-${subj}_pmaverage_ospan_vs_math_load

done




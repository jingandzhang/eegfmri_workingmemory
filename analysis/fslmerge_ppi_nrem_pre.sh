#!/bin/bash

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_nrem_precuneus/
for areai in precuneus
	do

	fslmerge -t group_v2average_${areai}_complete2V sub-106_v2average_${areai}.nii.gz sub-107_v2average_${areai}.nii.gz sub-108_v2average_${areai}.nii.gz sub-111_v2average_${areai}.nii.gz sub-112_v2average_${areai}.nii.gz sub-114_v2average_${areai}.nii.gz sub-115_v2average_${areai}.nii.gz sub-116_v2average_${areai}.nii.gz sub-118_v2average_${areai}.nii.gz sub-123_v2average_${areai}.nii.gz sub-124_v2average_${areai}.nii.gz sub-125_v2average_${areai}.nii.gz sub-126_v2average_${areai}.nii.gz sub-127_v2average_${areai}.nii.gz sub-130_v2average_${areai}.nii.gz sub-132_v2average_${areai}.nii.gz sub-133_v2average_${areai}.nii.gz sub-135_v2average_${areai}.nii.gz sub-136_v2average_${areai}.nii.gz sub-137_v2average_${areai}.nii.gz sub-138_v2average_${areai}.nii.gz sub-142_v2average_${areai}.nii.gz sub-144_v2average_${areai}.nii.gz sub-148_v2average_${areai}.nii.gz sub-149_v2average_${areai}.nii.gz sub-152_v2average_${areai}.nii.gz sub-153_v2average_${areai}.nii.gz sub-154_v2average_${areai}.nii.gz sub-156_v2average_${areai}.nii.gz 

	

#create negative contrast

	fslmaths group_v2average_${areai}_complete2V.nii.gz -mul -1 -nan group_v2average_${areai}_complete2V_neg.nii
	#fslmaths group_pmaverage_${areai}_complete2V.nii.gz -mul -1 -nan group_pmaverage_${areai}_complete2V_neg.nii
	#fslmaths group_amaverage_${areai}_complete2V.nii.gz -mul -1 -nan group_amaverage_${areai}_complete2V_neg.nii
done 


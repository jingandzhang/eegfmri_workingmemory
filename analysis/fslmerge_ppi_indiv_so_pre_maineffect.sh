#!/bin/bash

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_indiv_so_precuneus_maineffect/
for areai in precuneus
	do
	fslmerge -t group_allsessions_${areai}_complete2V average_sub-106_${areai}.nii.gz average_sub-107_${areai}.nii.gz average_sub-108_${areai}.nii.gz average_sub-111_${areai}.nii.gz average_sub-112_${areai}.nii.gz average_sub-113_${areai}.nii.gz average_sub-114_${areai}.nii.gz average_sub-115_${areai}.nii.gz average_sub-116_${areai}.nii.gz average_sub-118_${areai}.nii.gz average_sub-123_${areai}.nii.gz average_sub-124_${areai}.nii.gz average_sub-125_${areai}.nii.gz average_sub-126_${areai}.nii.gz average_sub-127_${areai}.nii.gz average_sub-130_${areai}.nii.gz average_sub-131_${areai}.nii.gz average_sub-132_${areai}.nii.gz average_sub-133_${areai}.nii.gz average_sub-135_${areai}.nii.gz average_sub-136_${areai}.nii.gz average_sub-137_${areai}.nii.gz average_sub-138_${areai}.nii.gz average_sub-142_${areai}.nii.gz average_sub-144_${areai}.nii.gz average_sub-148_${areai}.nii.gz average_sub-149_${areai}.nii.gz average_sub-152_${areai}.nii.gz average_sub-153_${areai}.nii.gz average_sub-154_${areai}.nii.gz average_sub-156_${areai}.nii.gz average_sub-160_${areai}.nii.gz 

	

#create negative contrast

	fslmaths group_allsessions_${areai}_complete2V.nii.gz -mul -1 -nan group_allsessions_${areai}_complete2V_neg.nii
	#fslmaths group_pmaverage_${areai}_complete2V.nii.gz -mul -1 -nan group_pmaverage_${areai}_complete2V_neg.nii
	#fslmaths group_amaverage_${areai}_complete2V.nii.gz -mul -1 -nan group_amaverage_${areai}_complete2V_neg.nii
done 


#!/bin/bash

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ppi_os_precuneus/
for areai in precuneus
	do

	fslmerge -t group_allsessions_${areai}_complete2V sub-106_allsessions_${areai}.nii.gz sub-108_allsessions_${areai}.nii.gz sub-111_allsessions_${areai}.nii.gz sub-112_allsessions_${areai}.nii.gz sub-113_allsessions_${areai}.nii.gz sub-114_allsessions_${areai}.nii.gz sub-115_allsessions_${areai}.nii.gz sub-116_allsessions_${areai}.nii.gz sub-118_allsessions_${areai}.nii.gz sub-121_allsessions_${areai}.nii.gz sub-123_allsessions_${areai}.nii.gz sub-124_allsessions_${areai}.nii.gz sub-125_allsessions_${areai}.nii.gz sub-126_allsessions_${areai}.nii.gz sub-127_allsessions_${areai}.nii.gz sub-130_allsessions_${areai}.nii.gz sub-131_allsessions_${areai}.nii.gz sub-132_allsessions_${areai}.nii.gz sub-133_allsessions_${areai}.nii.gz sub-135_allsessions_${areai}.nii.gz sub-136_allsessions_${areai}.nii.gz sub-137_allsessions_${areai}.nii.gz sub-138_allsessions_${areai}.nii.gz sub-144_allsessions_${areai}.nii.gz sub-148_allsessions_${areai}.nii.gz sub-149_allsessions_${areai}.nii.gz sub-152_allsessions_${areai}.nii.gz sub-154_allsessions_${areai}.nii.gz sub-156_allsessions_${areai}.nii.gz 
	

#create negative contrast

	fslmaths group_allsessions_${areai}_complete2V.nii.gz -mul -1 -nan group_allsessions_${areai}_complete2V_neg.nii
	#fslmaths group_allsessions_${areai}_complete2V.nii.gz -mul -1 -nan group_allsessions_${areai}_complete2V_neg.nii
	#fslmaths group_allsessions_${areai}_complete2V.nii.gz -mul -1 -nan group_allsessions_${areai}_complete2V_neg.nii
done 


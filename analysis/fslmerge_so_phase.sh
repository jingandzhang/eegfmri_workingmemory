#!/bin/bash

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_up/allvisits/
fslmerge -t group_so_up /mnt/tambinidata/sleepstudy/data/derivatives/group/so_up/v*

fslmaths group_so_up.nii.gz -mul -1 -nan group_so_up_neg.nii

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_down/allvisits/
fslmerge -t group_so_down /mnt/tambinidata/sleepstudy/data/derivatives/group/so_down/v*

fslmaths group_so_down.nii.gz -mul -1 -nan group_so_down_neg.nii

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_upvsdown/allvisits/
fslmerge -t group_so_upvsdown /mnt/tambinidata/sleepstudy/data/derivatives/group/so_upvsdown/v*
fslmaths group_so_upvsdown.nii.gz -mul -1 -nan group_so_upvsdown_neg.nii

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_up/average/
fslmerge -t group_so_up /mnt/tambinidata/sleepstudy/data/derivatives/group/so_up/average_*
fslmaths group_so_up.nii.gz -mul -1 -nan group_so_up_neg.nii

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_down/average/
fslmerge -t group_so_down /mnt/tambinidata/sleepstudy/data/derivatives/group/so_down/average_*
fslmaths group_so_down.nii.gz -mul -1 -nan group_so_down_neg.nii

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/so_upvsdown/average/
fslmerge -t group_so_upvsdown /mnt/tambinidata/sleepstudy/data/derivatives/group/so_upvsdown/average_*
fslmaths group_so_upvsdown.nii.gz -mul -1 -nan group_so_upvsdown_neg.nii

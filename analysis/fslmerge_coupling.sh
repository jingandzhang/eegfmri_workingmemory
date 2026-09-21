#!/bin/bash

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/coupled_vs_uncoupled/allvisits/
fslmerge -t group_coupled_vs_uncoupled /mnt/tambinidata/sleepstudy/data/derivatives/group/coupled_vs_uncoupled/v*


cd /mnt/tambinidata/sleepstudy/data/derivatives/group/coupled_vs_uncoupled/average/
fslmerge -t group_coupled_vs_uncoupled /mnt/tambinidata/sleepstudy/data/derivatives/group/coupled_vs_uncoupled/average_*

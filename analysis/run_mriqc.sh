#!/bin/bash

#User inputs:
bids_root_dir=/mnt/tambinidata/sleepstudy/data/nifti-bids
data_dir=/mnt/tambinidata/sleepstudy/data
sing_img=/mnt/tambinidata/singularity/mriqc-0-16-0.simg
subj=125
nthreads=4
mem=10 #gb

#Make mriqc directory and participant directory in derivatives folder
if [ ! -d $data_dir/derivatives/mriqc ]; then
mkdir $data_dir/derivatives/mriqc
fi

if [ ! -d $data_dir/derivatives/mriqc/sub-${subj} ]; then
mkdir $data_dir/derivatives/mriqc/sub-${subj}
fi

#Run MRIQC
echo ""
echo "Running MRIQC on participant $s"
echo ""

singularity run -B /mnt/tambinidata/sleepstudy:/mnt/tambinidata/sleepstudy $sing_img \
  $bids_root_dir $data_dir/derivatives/mriqc/sub-${subj} \
  participant --participant-label ${subj} \
  --n_proc $nthreads \
  --correct-slice-timing \
  --mem_gb $mem \
  --float32 \
  --ants-nthreads $nthreads \
  -w $data_dir/derivatives/mriqc/sub-${subj}

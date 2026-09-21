#!/bin/bash
################################ OS vs math
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/positive/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/negative/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v/positive/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v/negative/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask


cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/positive/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/negative/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/complete2v/positive/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/complete2v/negative/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/allsub/positive/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/allsub/negative/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/complete2v/positive/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/complete2v/negative/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/allsub/positive/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/allsub/negative/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/complete2v/positive/

fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/complete2v/negative/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

################################ OS vs baseline
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/allsub/positive/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask
  

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/allsub/negative/
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/complete2v/positive/

fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/complete2v/negative/

fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/allsub/positive/

fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask


################################ math vs baseline
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/allsessions/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/am-pm/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

################################ OS vs baseline
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask
  
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask


################################ math vs baseline
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/positive/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/negative/
fslmaths cluster_index_fwe -bin cluster_index_fwe_mask
fslmaths cluster_index_tfce_fdr -bin cluster_index_tfce_fdr_mask
fslmaths cluster_index_fdr -bin cluster_index_fdr_mask
fslmaths cluster_index_tfce -bin cluster_index_tfce_mask



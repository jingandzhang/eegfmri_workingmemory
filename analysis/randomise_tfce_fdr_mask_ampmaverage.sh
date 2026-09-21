#!/bin/bash
################################ OS vs math
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/v1only/positive/
##randomise -i group_pmaverage_ospan_vs_math_v1only_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
##randomise -i group_pmaverage_ospan_vs_math_v1only_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/v1only/negative/
##randomise -i group_pmaverage_ospan_vs_math_v1only_neg.nii.gz -o OneSampT -1 -T -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
##randomise -i group_pmaverage_ospan_vs_math_v1only_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/allsub/positive/
##randomise -i group_pmaverage_ospan_vs_math_allsub_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
##randomise -i group_pmaverage_ospan_vs_math_allsub_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/allsub/negative/
#randomise -i group_pmaverage_ospan_vs_math_allsub_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_ospan_vs_math_allsub_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/complete2v/positive/
#randomise -i group_pmaverage_ospan_vs_math_complete2v_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_ospan_vs_math_complete2v_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/pmaverage/complete2v/negative/
#randomise -i group_pmaverage_ospan_vs_math_complete2v_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_ospan_vs_math_complete2v_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/v1only/positive/
#randomise -i group_amaverage_ospan_vs_math_v1only_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_math_v1only_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/v1only/negative/
#randomise -i group_amaverage_ospan_vs_math_v1only_neg.nii.gz -o OneSampT -1 -T -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_math_v1only_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/allsub/positive/
#randomise -i group_amaverage_ospan_vs_math_allsub_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_math_allsub_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/allsub/negative/
#randomise -i group_amaverage_ospan_vs_math_allsub_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_math_allsub_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/complete2v/positive/
#randomise -i group_amaverage_ospan_vs_math_complete2v_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_math_complete2v_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_math/amaverage/complete2v/negative/
#randomise -i group_amaverage_ospan_vs_math_complete2v_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_math_complete2v_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
################################ OS vs baseline
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/v1only/positive/
#randomise -i group_pmaverage_ospan_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_ospan_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/v1only/negative/
#randomise -i group_pmaverage_ospan_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -T -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_ospan_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/allsub/positive/
#randomise -i group_pmaverage_ospan_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_ospan_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/allsub/negative/
#randomise -i group_pmaverage_ospan_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_ospan_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/complete2v/positive/
#randomise -i group_pmaverage_ospan_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_ospan_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/pmaverage/complete2v/negative/
#randomise -i group_pmaverage_ospan_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_ospan_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/v1only/positive/
#randomise -i group_amaverage_ospan_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/v1only/negative/
#randomise -i group_amaverage_ospan_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -T -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/allsub/positive/
#randomise -i group_amaverage_ospan_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/allsub/negative/
#randomise -i group_amaverage_ospan_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/complete2v/positive/
#randomise -i group_amaverage_ospan_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/amaverage/complete2v/negative/
#randomise -i group_amaverage_ospan_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_ospan_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz



################################ math vs baseline
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/v1only/positive/
#randomise -i group_pmaverage_math_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_math_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/v1only/negative/
#randomise -i group_pmaverage_math_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -T -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_math_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/positive/
randomise -i group_pmaverage_math_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
randomise -i group_pmaverage_math_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/allsub/negative/
#randomise -i group_pmaverage_math_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_math_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/positive/
#randomise -i group_pmaverage_math_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_math_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/pmaverage/complete2v/negative/
#randomise -i group_pmaverage_math_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_pmaverage_math_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/v1only/positive/
#randomise -i group_amaverage_math_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_math_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/v1only/negative/
#randomise -i group_amaverage_math_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -T -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_math_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/positive/
randomise -i group_amaverage_math_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
randomise -i group_amaverage_math_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/allsub/negative/
#randomise -i group_amaverage_math_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_math_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/positive/
#randomise -i group_amaverage_math_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_math_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/amaverage/complete2v/negative/
#randomise -i group_amaverage_math_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_amaverage_math_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

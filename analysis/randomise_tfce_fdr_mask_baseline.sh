#!/bin/bash
################################ OS vs baseline
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/v1only/positive/
#randomise -i group_allsessions_ospan_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_ospan_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/v1only/negative/
#randomise -i group_allsessions_ospan_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -T -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_ospan_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/allsub/positive/
randomise -i group_allsessions_ospan_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
randomise -i group_allsessions_ospan_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/allsub/negative/
#randomise -i group_allsessions_ospan_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_ospan_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/complete2v/positive/
#randomise -i group_allsessions_ospan_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_ospan_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/allsessions/complete2v/negative/
#randomise -i group_allsessions_ospan_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_ospan_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/v1only/positive/
#randomise -i group_am-pm_ospan_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_ospan_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/v1only/negative/
#randomise -i group_am-pm_ospan_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -T -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_ospan_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/allsub/positive/
#randomise -i group_am-pm_ospan_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_ospan_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/allsub/negative/
#randomise -i group_am-pm_ospan_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_ospan_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/complete2v/positive/
#randomise -i group_am-pm_ospan_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_ospan_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/ospan_vs_baseline/am-pm/complete2v/negative/
#randomise -i group_am-pm_ospan_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_ospan_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz



################################ math vs baseline
cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only/positive/
#randomise -i group_allsessions_math_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_math_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/v1only/negative/
#randomise -i group_allsessions_math_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -T -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_math_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/positive/
#randomise -i group_allsessions_math_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_math_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/allsub/negative/
#randomise -i group_allsessions_math_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_math_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/positive/
#randomise -i group_allsessions_math_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_math_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/allsessions/complete2v/negative/
#randomise -i group_allsessions_math_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_allsessions_math_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/positive/
#randomise -i group_am-pm_math_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_math_vs_baseline_v1only_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/v1only/negative/
#randomise -i group_am-pm_math_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -T -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_math_vs_baseline_v1only_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/positive/
#randomise -i group_am-pm_math_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_math_vs_baseline_allsub_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/allsub/negative/
#randomise -i group_am-pm_math_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_math_vs_baseline_allsub_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v/positive/
#randomise -i group_am-pm_math_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_math_vs_baseline_complete2v_pos.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

cd /mnt/tambinidata/sleepstudy/data/derivatives/group/math_vs_baseline/am-pm/complete2v/negative/
#randomise -i group_am-pm_math_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -T  -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
#randomise -i group_am-pm_math_vs_baseline_complete2v_neg.nii.gz -o OneSampT -1 -x --uncorrp -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz
fdr -i OneSampT_vox_p_tstat1 --oneminusp -q 0.05 -a fdr_vox_p_tstat1 --othresh=fdr_vox_p_tstat1 -m /mnt/tambinidata/sleepstudy/data/derivatives/group/MNI_brainmask_ds.nii.gz

# Analysis workflow and manuscript mapping

This guide provides an analysis-family map; it does not certify a single final script for each panel. All script names below are in `analysis/` unless stated otherwise.

## Ordered workflow

1. **Prepare MRI data.** Inspect `bids_anat.py` and `bids_func.py` for DICOM conversion, `run_mriqc.sh` for quality control, and `run_fmriprep.txt` for the historical fMRIPrep invocation. Configure participants, visits, paths, and tool locations. Conversion scripts move dummy DICOM scans and remove matching prior outputs; use a working copy of data. The commands are Linux/lab examples, not portable launchers.
2. **Preprocess and define confounds.** `create_masks.py` constructs combined masks; `example_preproc_S1_ehlert_task.m` and `example_preproc_S1_ehlert_sleepscan.m` handle further processing. `motion_info_ospan.m` and `n_file_generator_comment_os.m` support motion assessment and task nuisance regressors. Establish the final inclusion table before proceeding.
3. **Model the WM task.** `model_1_comments_os.m` is a block-model candidate. 
4. **Build group contrasts.**  `fslmath.txt`, `fslmerge_ospan_vs_math_ampm.m`, `fslmerge_ret_baseline.m`, and related contrast scripts represent per-session, within-visit differences, or averages across visits. `randomise_tfce_fdr_mask_allsessions.sh`, `randomise_tfce_fdr_mask_ampmaverage.sh`, and `randomise_tfce_fdr_mask_baseline.sh` are for group-analysis. 
5. **Prepare sleep events.** Start with artifact-corrected, scored EEG. See `eeg/detection/README.md`; `HN_SO_detection.m`, `HN_EEG_burst.m`, and the supplied `edfread.m` generate the upstream HN SO detections. `FMRI_labeling_no_step_truncate_PC.m` supports stable-NREM timing; `truncate_scan_nrem_pc.m` extracts fMRI chunks. `so_sp_truncated.m` aligns existing SO/spindle detections to NREM chunks, `events_so_sp.m` creates event vectors, and `merge_onsets.m` joins runs. `so_sp_truncated.m` loads `OUT/HN_SO` and `OUT/HN_spindle` results and uses an explicitly supplied EEG–MRI time offset. `events_so_sp.m`.
6. **Model SO-related activity.** `n_file_generator_comment_nrem_PC.m` ,  `model_1_comments_nrem_indiv_so.m` and `model_1_comments_nrem.m`. The individual-SO model expects filenames beginning `onsets_events_indiv_so_`; verify that the selected event-generation workflow produces the required names and regressors. `fslmath_indiv_so.sh`, `fslmath_nrem.txt`, and `fslmerge_nrem.txt` support group preparation.
7. **Run reinstatement and association analyses.** Choose the manuscript-matched ROI, item-model outputs, participant set, and contrast sign before running the candidates below. Do not run every variant as a sequence.
8. **Generate figures and validate.** `create_colormap_Purple_brainnetViewer*.m` support brain-map presentation. 

## Figure and result map

| Supplied manuscript result | Available code |
| --- | --- | 
| Figure 1: task and overnight accuracy/RT | `task/working_memory/*` |
| Figure 2: task activation and AM–PM change | `model_1_comments_os.m`, `fslmerge_ospan_vs_math_ampm.m`, `fslmerge_ret_baseline.m`, `randomise_tfce_fdr_mask_*.sh` | 
| Reliability of AM–PM patterns across visits | `pattern_similarity.ipynb`, `_v2.ipynb`, `_v3.ipynb` | 
| Figure 3: encoding–retrieval similarity | `os_onsets_peritem.m`, `reinstate.ipynb`, `reinstate_jz.ipynb`, `reinstate_pc.ipynb`, `reinstate_jz_pc.ipynb` | 
| Figure 4: SO activity | EEG event scripts above, `model_1_comments_nrem_indiv_so.m`, `fslmath_indiv_so.sh`, `run_rex_nrem_indiv_so.m` | 
| Figure 5: across-session SO/WM associations | `voxwise_correlation_rex.m`, `voxwise_correlation_ret_vs_base.m`, `voxwise_correlation_percluster.m`, regression variants | 
| Figure 6: attention-network spatial associations | `so_versus_ampm_100parcel_network.m`, `so_versus_ampm_permutation_100parcel_network_jz.m`, `permutation_test_generate_tstatmaps.m`, `_math_vs_base.m` |


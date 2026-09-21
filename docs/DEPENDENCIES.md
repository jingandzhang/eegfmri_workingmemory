# Software and inputs

## Historical software evidence

| Software | Evidence in supplied material |
| --- | --- |
| MATLAB and SPM12 | Task/UI and analysis sources; exact MATLAB release and SPM revision not recorded |
| MATLAB Statistics and Machine Learning Toolbox | `robustfit`, statistical tests; `mafdr` also requires the appropriate Bioinformatics Toolbox installation |
| fMRIPrep 1.4.0 | Manuscript and `run_fmriprep_jz.txt` container filename |
| FSL 5.0.9 | Manuscript preprocessing description; separate group-analysis FSL version must be confirmed |
| AFNI 20160207 | Manuscript preprocessing description; `3dresample` used by atlas scripts |
| Nilearn 0.5.2 | Manuscript describes the fMRIPrep internal dependency, not necessarily the analysis-notebook environment |
| Python/Jupyter | Imports include NumPy, pandas, SciPy, nibabel, statsmodels, matplotlib, seaborn, nilearn, and nipype; exact analysis versions not supplied |
| dcm2niix, MRIQC, Singularity | Conversion and preprocessing scripts; exact versions/container hashes not supplied |
| EEGLAB, Signal Processing Toolbox, `smooth` implementation | HN detection uses `eeglab`, `pop_importdata`, `pop_eegfiltnew`, `hilbert`, and `smooth`; exact releases not supplied |
| REX, BrainNet Viewer | ROI extraction and brain visualization sources; obtain compatible releases |
| BrainVision RecView 1.2 / Analyzer 2.0 | Manuscript EEG artifact correction; processing histories/settings must accompany this manual stage |

`requirements.in` lists observed Python packages only; it is not a tested or pinned environment. Several notebooks use historical `nibabel.get_data()` calls. Restore the original working environment or validate a compatibility migration rather than assuming current package releases reproduce the analyses.

## Required inputs not bundled

- DICOM or BIDS MRI, preprocessed BOLD, fMRIPrep confounds, and anatomical/functional masks.
- Participant/session inclusion information (`ss_info.mat`, `ss_info_os.mat`, `info_python.mat`), with field definitions and exclusions. These exist in the source archive but were not included as public data.
- Block and item onsets (`os_onsets.mat`, `os_onsets_peritem.mat`) and sleep onsets; document units, ordering, dummy-volume handling, and concatenation offsets.
- `job_spec.mat` and `job_est.mat` templates referenced by first-level models. These are in the source archive; inspect and convert to portable templates or code before release.
- Artifact-corrected/scored EEG, stable NREM timings, EEG–MRI offsets, and SO/spindle detections loaded by `so_sp_truncated.m`.
- Correct-trial indices under `os_correct_trials_index` and the fitted item-level beta maps required by reinstatement notebooks.
- Brain/gray-matter masks, `fusi_letter_ROI.nii.gz`, WM activation masks, significant-cluster masks, and Yeo network/parcel masks. Some source masks exist, others are only referenced by external paths. Record atlas provenance, thresholds, resampling, orientation, and dimensions.
- BrainNet configuration files and color maps for matching visualization; binary settings are present in the source archive but have not been inspected for portable release.
- Custom helpers `arobustfit.m` and `linregplotdata_robust_corrtext.m`, referenced by network analyses but absent from the supplied folder. Do not substitute a different implementation without validating the statistics.


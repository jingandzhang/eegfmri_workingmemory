import os
from glob import glob
from os.path import join as pjoin
import nipype

script_dir = '/mnt/tambinidata/scripts/denoiser/'
script = script_dir + 'run_denoise_light.py'

new_data_dir = '/mnt/tambinidata/sleepstudy/data_denoised'
base_dir = '/mnt/tambinidata/sleepstudy'
out_fig_dir = pjoin(base_dir, 'data', 'derivatives', 'mriprep', 'fmriprep', 'denoise_figs')

random_sub_dir = pjoin(base_dir, 'data', 'derivatives', 'mriprep', 'fmriprep', 'sub-123', 'ses-1', 'func')
example_file = glob(pjoin(random_sub_dir, 'sub-123_ses-1_task-rswake_run-01_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz'))
tsv_file = glob(pjoin(random_sub_dir, 'sub-123_ses-1_task-rswake_run-01_desc-confounds_regressors.tsv'))

# anatomical compcor (top 8), 6 MPs (motion parameters), 6 MP derivatives
col_names = '--col_names ' + \
    'a_comp_cor_00 a_comp_cor_01 a_comp_cor_02 a_comp_cor_03 ' + \
    'a_comp_cor_04 a_comp_cor_05 a_comp_cor_06 a_comp_cor_07 ' + \
    'trans_x trans_y trans_z rot_x rot_y rot_z '  + \
    'trans_x_derivative1 trans_y_derivative1 trans_z_derivative1 ' + \
    'rot_x_derivative1 rot_y_derivative1 rot_z_derivative1'
hp_filter = '--hp_filter .009'
out_fig_path = '--out_figure_path ' + out_fig_dir

os.chdir(script_dir)
# subprocess.run(['python', script, col_names, hp_filter, out_fig_path, example_file[0], tsv_file[0], data_dir])
cmd = 'python ' + script + ' ' + col_names + ' ' + hp_filter + ' ' + out_fig_path + ' ' + example_file[0] + \
    ' ' + tsv_file[0] + ' ' + new_data_dir
print(cmd)
os.system(cmd)
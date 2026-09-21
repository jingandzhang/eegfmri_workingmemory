from os.path import join as pjoin
from glob import glob
import numpy as np
import os, shutil, pdb, json
import nibabel as nib

home_dir = os.getenv('HOME')
data_dir = pjoin(home_dir, 'hp-tms-mri', 'data')

# Here I'm specifying a long path to dcm2niix, which you don't need to do. 
# You can just use dcm2niix followed by these options afterwards
dcm_convert = pjoin(home_dir, 'software', 'dcm2niix-master', 'console', 'dcm2niix')
dcm_convert += ' -m y -b y -z n -f '

# I was looping through subjects & sessions
ss_list = ['241', '242', '243', '244', '247', '248', '249', '250', '251']
sess_list = ['ses-tms-ipl', 'ses-tms-con']

# specifying difference scans to look for and how to name them
func_types = ['ep2d_neuro_encode', 'ep2d_neuro_rest', 'PCASL_1500ms']
func_names = ['encode', 'rest', 'rest']
suffix_list = ['_bold', '_bold', '_asl']

# can ignore this!
Nvol_discard = 4

for ss in ss_list:
    sub = 'sub-' + ss

    for sess in sess_list:
        cmds = []

        dcm_dir = pjoin(data_dir, 'dicom', ss, sess)
        nifti_dir = pjoin(data_dir, 'nifti-bids', sub)
        discard_dir = pjoin(dcm_dir, 'discard')

        # set up new folder names for each session
        sess_dir_base = pjoin(nifti_dir, sess)
        # func data goes in here:
        sess_dir_base_func = pjoin(sess_dir_base, 'func')

        # FUNC files - create folders if they don't already exist
        if not os.path.exists(sess_dir_base_func):
            os.makedirs(sess_dir_base_func)
        if not os.path.exists(discard_dir):
            os.makedirs(discard_dir)

        # loop over scan types
        for idx, func_flag in enumerate(func_types):

            func_dir_dcm = glob(pjoin(dcm_dir, func_flag + '*'))
            # I was pulling out the # of each scan from the folder - so I could sort by this later
            num_idx = np.zeros(len(func_dir_dcm))
            for idx_dir, dir_nm in enumerate(func_dir_dcm):
                dir_base = os.path.basename(dir_nm)
                temp_idx = dir_base.find(func_flag)
                num_idx[idx_dir] = int(dir_base[temp_idx+len(func_flag)+1:])
                
            # make sure folders are sorted in chronological order (by number)
            order_idx = sorted(range(len(num_idx)), key=num_idx.__getitem__)
            order_idx = np.asarray(order_idx)
            func_dir_dcm_reorder = [func_dir_dcm[i] for i in order_idx]

            func_name = func_names[idx]
            suffix = suffix_list[idx]
            print(func_flag + ' is ' + func_name + ' and ' + suffix)

            # can ignore - discarding dummy scans
            if not func_flag.startswith('PCASL'):
                for irun, scan_dir in enumerate(func_dir_dcm_reorder):
                    curr_discard_dir = pjoin(discard_dir, os.path.basename(scan_dir))
                    if not os.path.exists(curr_discard_dir):
                        os.makedirs(curr_discard_dir)

                    for iscan in range(1, Nvol_discard+1):
                        dcm = glob(pjoin(scan_dir, '*000' + str(iscan) + '.dcm'))
                        if len(dcm) == 1:
                            print('Discarding file: ' + os.path.basename(dcm[0]))
                            shutil.move(dcm[0], curr_discard_dir)
                        else:
                            print('No dummy scans found in ' + scan_dir)

            # actually doing conversion
            for irun, scan_dir in enumerate(func_dir_dcm_reorder):
                # specify new file name for nifti file in BIDS format
                func_nifti = sub + '_' + sess + '_task-' + func_name + '_run-0' + str(irun+1) + suffix
               
                # removing file in case one exists already
                cmd = 'rm ' + pjoin(sess_dir_base_func, func_nifti + '*')
                os.system(cmd)

                # setup dcm2niix command and run it
                cmd = (dcm_convert + func_nifti + ' -o ' + sess_dir_base_func + ' ' + scan_dir)
                os.system(cmd)

                # can ignore - I added in extra into to .json file
                obj = nib.load(glob(pjoin(sess_dir_base_func, func_nifti + '.nii*'))[0])
                obj_sz = obj.get_data().shape
                json_file = pjoin(sess_dir_base_func, func_nifti + '.json')
                json_obj = json.loads(open(json_file).read())
                json_obj["original_dcm"] = scan_dir
                json_obj["scan_length"] = str(obj_sz[-1])
                json.dump(json_obj, open(json_file, 'w'))

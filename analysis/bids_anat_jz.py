from os.path import join as pjoin
from glob import glob
import numpy as np
import os, shutil, pdb, json
import nibabel as nib

home_dir = r'/mnt/tambinidata'
data_dir = pjoin(home_dir, 'sleepstudy', 'data')

# Here I'm specifying a long path to dcm2niix, which you don't need to do. 
# You can just use dcm2niix followed by these options afterwards

dcm_convert = '/mnt/tambinidata/scripts/dcm2niix -m y -b y -z n -f '

# I was looping through subjects & sessions
ss_list = ['999']
sess_list = ['ses-3']


# specifying difference scans to look for and how to name them
anat_types = ['ANAT-T1']

suffix_list = ['_T1w']


for ss in ss_list:
    sub = 'sub-' + ss

    for sess in sess_list:
        cmds = []

        dcm_dir = pjoin(data_dir, 'dicom', ss, sess)
        nifti_dir = pjoin(data_dir, 'nifti-bids', sub)

        # set up new folder names for each session
        sess_dir_base = pjoin(nifti_dir, sess)
        # t1 data goes in here:
        sess_dir_base_anat = pjoin(sess_dir_base, 'anat')

        # T1 files - create folders if they don't already exist
        if not os.path.exists(sess_dir_base_anat):
            os.makedirs(sess_dir_base_anat)


        # loop over scan types
        for idx, anat_flag in enumerate(anat_types):
                
            file_dir=pjoin(dcm_dir, anat_flag + '*')
            anat_dir_dcm = glob(pjoin(dcm_dir, anat_flag + '*'))

            suffix = suffix_list[idx]


            # actually doing conversion
            for irun, scan_dir in enumerate(anat_dir_dcm):
                # specify new file name for nifti file in BIDS format
                anat_nifti = sub + '_' + sess + '_run-0' + str(irun+1) + suffix
               
                # removing file in case one exists already
                cmd = 'rm ' + pjoin(sess_dir_base_anat, anat_nifti + '*')
                os.system(cmd)

                # setup dcm2niix command and run it
                cmd = (dcm_convert + anat_nifti + ' -o ' + sess_dir_base_anat + ' ' + scan_dir)
                os.system(cmd)

                # can ignore - I added in extra into to .json file
                obj = nib.load(glob(pjoin(sess_dir_base_anat, anat_nifti + '.nii*'))[0])
                obj_sz = obj.get_data().shape
                json_file = pjoin(sess_dir_base_anat, anat_nifti + '.json')
                json_obj = json.loads(open(json_file).read())
                json_obj["original_dcm"] = scan_dir
                json_obj["scan_length"] = str(obj_sz[-1])
                json.dump(json_obj, open(json_file, 'w'))



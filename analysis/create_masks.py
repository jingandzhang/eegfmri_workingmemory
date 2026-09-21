import nibabel as nb
from glob import glob
from os.path import join as pjoin
import numpy as  np
import pdb
from nilearn import image


ss_list = ['sub-001', 'sub-002', 'sub-003']
ss_list = ['sub-003']
main_dir = '/mnt/tambinidata/ScanTrain/data'
anat_roi_dir = pjoin(main_dir, 'rois', 'anatomical')

for ss in ss_list:

    data_dir = pjoin(main_dir, 'derivatives', ss)
    new_name = ss + '_combined-mask.nii.gz'
    
    mask_files = glob(pjoin(data_dir, 'ses*', 'func', '*T1w*brain_mask*'))
    for ifile in mask_files:
        print(image.load_img(ifile).get_data().shape)
        
    masks = image.load_img(mask_files)
    mask_data_all = masks.get_data().astype(float)
    print('Nmasks: ' + str(mask_data_all.shape))
    mask_data = np.sum(mask_data_all, axis=3)
    print(np.mean(mask_data>0))
    
    roi_files = glob(pjoin(anat_roi_dir, ss + '*downsample*'))
    print(roi_files)
    for iroi, roi_file in enumerate(roi_files):
        roi = image.load_img(roi_file)
        if roi.get_data().ndim == 4:
            curr_data = roi.get_data()[:,:,:,0]  
        else:
            curr_data = roi.get_data()
            
        if iroi==0:
            roi_data = curr_data
        else:
            roi_data = roi_data + curr_data
            
    print('Nrois: ' + str(roi_data.shape))
    print(np.mean(roi_data))
    
    mask = np.array((mask_data + roi_data)>0).astype(float)
    print(mask.shape)
    print(str(np.sum(mask)) + ' ; ' + str(np.mean(mask)))
    
    affine = masks.affine
    new_img = nb.Nifti1Image(mask, affine)
    nb.save(new_img, pjoin(data_dir, new_name))
#
#for ises in np.arange(1, Nses+1):
#    if ises < 10:
#        pad = '00'
#    else: 
#        pad = '0'
#    ses_str = 'ses-' + pad + str(ises)
#    ses_dir = glob(pjoin(data_dir, ses_str, 'func'))
#    assert(len(ses_dir)==1)
#    
#    mask_files = glob(pjoin(ses_dir[0], '*brain_mask*'))
#    print(mask_files)
    
    
    
    #pdb.set_trace()
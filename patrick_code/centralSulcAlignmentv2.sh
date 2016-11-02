#! /bin/bash

for subject in 0006 0012 0273 0192 0490 0491 0269 0464 0494 0495 0549 0550 0557 0558 0559 0604 0605 0627
do
  #BB registration
  #mri_convert -i /data/r2d4/subjects/${subject}_1/perm_test/searchlight_Hpca_pre -it nifti1 -ot nii -o /data/r2d4/subjects/${subject}_1/perm_test/searchlight_Hpca_pre.nii

  #cp /data/r2d4/subjects/${subject}_1/RER_Run1_01/aurRER_Run1_01.nii /data/r2d4/subjects/${subject}_1/perm_test/aurRER_Run1_01.nii

  #bbregister --s ${subject} --mov  /data/r2d4/subjects/${subject}_1/perm_test/aurRER_Run1_01.nii --init-spm --bold --reg /usr/local/freesurfer/subjects/${subject}/bb.dat


 #These commands performn spherical registration
  #mri_vol2surf --src /data/r2d4/subjects/${subject}_1/perm_test/searchlight_Hpca_pre.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/lhpreHpca_bb.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi lh


  #mri_vol2surf --src /data/r2d4/subjects/${subject}_1/perm_test/searchlight_Hpca_pre.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/rhpreHpca_bb.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi rh

  #mri_vol2surf --src /data/r2d4/subjects/${subject}_1/perm_test/searchlight_Hpca_post.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/lhpostHpca_bb.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi lh


  #mri_vol2surf --src /data/r2d4/subjects/${subject}_1/perm_test/searchlight_Hpca_post.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/rhpostHpca_bb.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi rh
for tmap in 1 2 3 4
do
  mri_vol2surf --src /data/r2d4/subjects/${subject}_1/complexGLM/spmT_000${tmap}.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/lhspmT_000${tmap}.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi lh

  mri_vol2surf --src /data/r2d4/subjects/${subject}_1/complexGLM/spmT_000${tmap}.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/rhspmT_000${tmap}.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi rh
done
done

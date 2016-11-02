#! /bin/bash
SUBJECT_ROOT="/Volumes/coax_lab/patrick_project/subjects/subjects/"
FREESURFER_SUBJECT_ROOT="/Volumes/coax_lab/patrick_project/freesurfer/subjects/"
PAT_FREESURFER_SUBJECT_ROOT="/usr/local/freesurfer/subjects/"
R2D4MEAN_LABEL=$FREESURFER_SUBJECT_ROOTr2d4mean/label/
SUBS_ROOT="/Volumes/coax_lab/patrick_project/subjects/subjects/"
export FREESURFER_HOME=/Applications/freesurfer
export SUBJECTS_DIR=/Volumes/coax_lab/patrick_project/freesurfer/subjects/
source $FREESURFER_HOME/SetUpFreeSurfer.sh

#0012 0273 0192 0490 0491 0269 0464 0494 0495 0549 0550 0557 0558 0559 0604 0605 0627
for subject in 0006
do
  for session in _1 
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
  mri_vol2surf --src $SUBJECT_ROOT${subject}${session}/complexGLM/spmT_000${tmap}.img --projfrac -.1 --out $FREESURFER_SUBJECT_ROOT${subject}/lhspmT_000${tmap}.nii  --out_type paint --trgsubject r2d4mean --srcreg  $FREESURFER_SUBJECT_ROOT${subject}/bb.dat  --hemi lh

  mri_vol2surf --src $SUBJECT_ROOT${subject}${session}/complexGLM/spmT_000${tmap}.img --projfrac -.1 --out $FREESURFER_SUBJECT_ROOT${subject}/rhspmT_000${tmap}.nii  --out_type paint --trgsubject r2d4mean --srcreg  $FREESURFER_SUBJECT_ROOT${subject}/bb.dat  --hemi rh
done
done
done

#! /bin/bash

export COAX_EXT="/home/clarknoah/coax_external"
export SUBJECT_ROOT=$COAX_EXT/patrick_project/subjects
export FREESURFER_SUBJECT_ROOT=$COAX_EXT/patrick_project/freesurfer/subjects
export R2D4MEAN_LABEL=$FREESURFER_SUBJECT_ROOT/r2d4mean/label
export SUBS_ROOT=$COAX_EXT/patrick_project/subjects/subjects
export FREESURFER_HOME="/usr/local/freesurfer"
export SUBJECTS_DIR=$COAX_EXT/patrick_project/freesurfer/subjects
source $FREESURFER_HOME/SetUpFreeSurfer.sh
export SUBJECTS_DIR=$COAX_EXT/patrick_project/freesurfer/subjects
#0012 0273 0192 0490 0491 0269 0464 0494 0495 0549 0550 0557 0558 0559 0604 0605 0627
for subject in 0006
do
  #BB registration
  #mri_convert -i $SUBS_ROOT/${subject}_1/perm_test/searchlight_Hpca_pre -it nifti1 -ot nii -o $SUBS_ROOT/${subject}_1/perm_test/searchlight_Hpca_pre.nii

  #cp $SUBS_ROOT/${subject}_1/RER_Run1_01/aurRER_Run1_01.nii $SUBS_ROOT/${subject}_1/perm_test/aurRER_Run1_01.nii

  #bbregister --s ${subject} --mov  $SUBS_ROOT/${subject}_1/perm_test/aurRER_Run1_01.nii --init-spm --bold --reg /usr/local/freesurfer/subjects/${subject}/bb.dat


 #These commands performn spherical registration
  #mri_vol2surf --src $SUBS_ROOT/${subject}_1/perm_test/searchlight_Hpca_pre.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/lhpreHpca_bb.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi lh


  #mri_vol2surf --src $SUBS_ROOT/${subject}_1/perm_test/searchlight_Hpca_pre.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/rhpreHpca_bb.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi rh

  #mri_vol2surf --src $SUBS_ROOT/${subject}_1/perm_test/searchlight_Hpca_post.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/lhpostHpca_bb.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi lh


  #mri_vol2surf --src $SUBS_ROOT/${subject}_1/perm_test/searchlight_Hpca_post.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/rhpostHpca_bb.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi rh
for tmap in 1 2 3 4
do
  mri_vol2surf --src $SUBS_ROOT/${subject}_1/complexGLM/spmT_000${tmap}.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/lhspmT_000${tmap}.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi lh

  mri_vol2surf --src $SUBS_ROOT/${subject}_1/complexGLM/spmT_000${tmap}.img --projfrac -.1 --out /usr/local/freesurfer/subjects/${subject}/rhspmT_000${tmap}.nii  --out_type paint --trgsubject r2d4mean --srcreg  /usr/local/freesurfer/subjects/${subject}/bb.dat  --hemi rh
done
done

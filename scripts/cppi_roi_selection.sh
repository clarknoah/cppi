#!/bin/sh
#sudo umount /home/clarknoah/coax_external/
#sudo mount -t hfsplus -o force,rw /dev/sdb2 /home/clarknoah/coax_external/
export COAX_EXT="/home/clarknoah/coax_external"
SUBJECT_ROOT=$COAX_EXT/patrick_project/subjects
FREESURFER_SUBJECT_ROOT=$COAX_EXT/patrick_project/freesurfer/subjects
PAT_FREESURFER_SUBJECT_ROOT="/usr/local/freesurfer/subjects"
R2D4MEAN_LABEL=$FREESURFER_SUBJECT_ROOT/r2d4mean/label
SUBS_ROOT=$COAX_EXT/patrick_project/subjects/subjects

export COAX_EXT="/home/clarknoah/coax_external"
export FREESURFER_HOME="/usr/local/freesurfer"
export SUBJECTS_DIR=$COAX_EXT/patrick_project/freesurfer/subjects
source $FREESURFER_HOME/SetUpFreeSurfer.sh
export SUBJECTS_DIR=$COAX_EXT/patrick_project/freesurfer/subjects
SUB_LIST="0006 0273 0192 0490 0491 0269 0464 0494 0495 0549 0550 0557 0558 0559 0604 0605 0627"

#to add PPC
for subject in 0012
  do
    for session in _1 _2
      do
        for roi in hand_knob_lh lh mfg_crest_lh
          do
            mri_label2label --srcsubject r2d4mean --srclabel $R2D4MEAN_LABEL/${roi}.label --trgsubject ${subject}  --trglabel $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.label --regmethod surface --hemi lh

            mri_label2vol --label $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.label --subject ${subject} --hemi lh --identity --temp $FREESURFER_SUBJECT_ROOT/${subject}/mri/T1.mgz --o $SUBS_ROOT/${subject}${session}/perm_test/${roi}.nii --proj frac 0 1 0.1
          done

        for roi in hand_knob_rh mfg_crest_rh
          do
            mri_label2label --srcsubject r2d4mean --srclabel $R2D4MEAN_LABEL/${roi}.label --trgsubject ${subject}  --trglabel $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.label --regmethod surface --hemi rh

            mri_label2vol --label $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.label --subject ${subject} --hemi rh --identity --temp $FREESURFER_SUBJECT_ROOT/${subject}/mri/T1.mgz --o $SUBS_ROOT/${subject}${session}/perm_test/${roi}.nii --proj frac 0 1 0.1
          done

        for roi in rh lh
          do
            mri_label2vol --label $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.BA6.thresh.label --subject ${subject} --hemi ${roi} --identity --temp $FREESURFER_SUBJECT_ROOT/${subject}/mri/T1.mgz --o $SUBS_ROOT/${subject}${session}/perm_test/${roi}BA6.nii --proj frac 0 1 0.1

            mri_label2vol --label $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.BA4p.thresh.label --label $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.BA4a.thresh.label --subject ${subject} --hemi ${roi} --identity --temp $FREESURFER_SUBJECT_ROOT/${subject}/mri/T1.mgz --o $SUBS_ROOT/${subject}${session}/perm_test/${roi}BA4.nii --proj frac 0 1 0.1

            mri_label2vol --label $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.BA3a.thresh.label --label $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.BA3b.thresh.label --label $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.BA1.thresh.label --label $FREESURFER_SUBJECT_ROOT/${subject}/label/${roi}.BA2.thresh.label --subject ${subject} --hemi ${roi} --identity --temp $FREESURFER_SUBJECT_ROOT/${subject}/mri/T1.mgz --o $SUBS_ROOT/${subject}${session}/perm_test/${roi}BA123.nii --proj frac 0 1 0.1

          done
        #the files below need to be copied each time because it is overwritten during the registration process.

        cp $FREESURFER_SUBJECT_ROOT/${subject}/mri/brain.mgz $SUBS_ROOT/${subject}${session}/perm_test/brain.mgz

        mri_convert $SUBS_ROOT/${subject}${session}/perm_test/brain.mgz  $SUBS_ROOT/${subject}${session}/perm_test/brain.nii

        cp $SUBS_ROOT/${subject}${session}/RER_Run1_01/aurRER_Run1_01.nii $SUBS_ROOT/${subject}${session}/perm_test/aurRER_Run1_01.nii
      done
  #Get primary auditory cortex
#  mri_annotation2label --subject ${subject} --annotation $FREESURFER_SUBJECT_ROOT${subject}/label/lh.aparc.a2009s.annot --hemi lh --outdir $FREESURFER_SUBJECT_ROOT${subject}/label

#  mri_label2vol --label $FREESURFER_SUBJECT_ROOT${subject}/label/lh.G_temp_sup-G_T_transv.label    --subject ${subject} --hemi lh --identity --temp $FREESURFER_SUBJECT_ROOT${subject}/mri/T1.mgz --o $SUBS_ROOT${subject}_2/rois/A1.nii --proj frac 0 1 0.1

  #Get putamen and caudate
#  mri_convert $FREESURFER_SUBJECT_ROOT${subject}/mri/aseg.mgz $FREESURFER_SUBJECT_ROOT${subject}/mri/aseg.nii.gz

#  fslmaths $FREESURFER_SUBJECT_ROOT${subject}/mri/aseg.nii.gz -uthr 11 -thr 11 $SUBS_ROOT${subject}_2/perm_test/l#_caudate.nii

#  fslmaths $FREESURFER_SUBJECT_ROOT${subject}/mri/aseg.nii.gz -uthr 12 -thr 12 $SUBS_ROOT${subject}_2/perm_test/l_putamen.nii

#  gunzip < $SUBS_ROOT${subject}_2/perm_test/l_putamen.nii.gz > $SUBS_ROOT${subject}_2/perm_test/l_putamen.nii

#  gunzip < $SUBS_ROOT${subject}_2/perm_test/l_caudate.nii.gz > $SUBS_ROOT${subject}_2/perm_test/l_caudate.nii


  done

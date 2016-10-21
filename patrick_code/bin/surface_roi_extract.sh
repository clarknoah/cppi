#! /bin/bash
#to add PPC
for subject in 0006 0012 0273 0192 0490 0491 0269 0464 0494 0495 0549 0550 0557 0558 0559 0604 0605 0627
do

  for roi in hand_knob_lh lh mfg_crest_lh
  do
    mri_label2label --srcsubject r2d4mean --srclabel /usr/local/freesurfer/subjects/r2d4mean/label/${roi}.label --trgsubject ${subject}  --trglabel /usr/local/freesurfer/subjects/${subject}/label/${roi}.label --regmethod surface --hemi lh

    mri_label2vol --label /usr/local/freesurfer/subjects/${subject}/label/${roi}.label --subject ${subject} --hemi lh --identity --temp /usr/local/freesurfer/subjects/${subject}/mri/T1.mgz --o /data/r2d4/subjects/${subject}_1/perm_test/${roi}.nii --proj frac 0 1 0.1
  done

  for roi in hand_knob_rh mfg_crest_rh
  do
    mri_label2label --srcsubject r2d4mean --srclabel /usr/local/freesurfer/subjects/r2d4mean/label/${roi}.label --trgsubject ${subject}  --trglabel /usr/local/freesurfer/subjects/${subject}/label/${roi}.label --regmethod surface --hemi rh

    mri_label2vol --label /usr/local/freesurfer/subjects/${subject}/label/${roi}.label --subject ${subject} --hemi rh --identity --temp /usr/local/freesurfer/subjects/${subject}/mri/T1.mgz --o /data/r2d4/subjects/${subject}_1/perm_test/${roi}.nii --proj frac 0 1 0.1
  done

  for roi in rh lh
  do
    mri_label2vol --label /usr/local/freesurfer/subjects/${subject}/label/${roi}.BA6.thresh.label --subject ${subject} --hemi ${roi} --identity --temp /usr/local/freesurfer/subjects/${subject}/mri/T1.mgz --o /data/r2d4/subjects/${subject}_1/perm_test/${roi}BA6.nii --proj frac 0 1 0.1

    mri_label2vol --label /usr/local/freesurfer/subjects/${subject}/label/${roi}.BA4p.thresh.label --label /usr/local/freesurfer/subjects/${subject}/label/${roi}.BA4a.thresh.label --subject ${subject} --hemi ${roi} --identity --temp /usr/local/freesurfer/subjects/${subject}/mri/T1.mgz --o /data/r2d4/subjects/${subject}_1/perm_test/${roi}BA4.nii --proj frac 0 1 0.1

    mri_label2vol --label /usr/local/freesurfer/subjects/${subject}/label/${roi}.BA3a.thresh.label --label /usr/local/freesurfer/subjects/${subject}/label/${roi}.BA3b.thresh.label --label /usr/local/freesurfer/subjects/${subject}/label/${roi}.BA1.thresh.label --label /usr/local/freesurfer/subjects/${subject}/label/${roi}.BA2.thresh.label --subject ${subject} --hemi ${roi} --identity --temp /usr/local/freesurfer/subjects/${subject}/mri/T1.mgz --o /data/r2d4/subjects/${subject}_1/perm_test/${roi}BA123.nii --proj frac 0 1 0.1

  done
  #Get primary auditory cortex
  mri_annotation2label --subject ${subject} --annotation /usr/local/freesurfer/subjects/${subject}/label/lh.aparc.a2009s.annot --hemi lh --outdir /usr/local/freesurfer/subjects/${subject}/label

  mri_label2vol --label /usr/local/freesurfer/subjects/${subject}/label/lh.G_temp_sup-G_T_transv.label    --subject ${subject} --hemi lh --identity --temp /usr/local/freesurfer/subjects/${subject}/mri/T1.mgz --o /data/r2d4/subjects/${subject}_1/rois/A1.nii --proj frac 0 1 0.1

  #Get putamen and caudate
  mri_convert /usr/local/freesurfer/subjects/${subject}/mri/aseg.mgz /usr/local/freesurfer/subjects/${subject}/mri/aseg.nii.gz

  fslmaths /usr/local/freesurfer/subjects/${subject}/mri/aseg.nii.gz -uthr 11 -thr 11 /data/r2d4/subjects/${subject}_1/perm_test/l_caudate.nii

  fslmaths /usr/local/freesurfer/subjects/${subject}/mri/aseg.nii.gz -uthr 12 -thr 12 /data/r2d4/subjects/${subject}_1/perm_test/l_putamen.nii

  gunzip < /data/r2d4/subjects/${subject}_1/perm_test/l_putamen.nii.gz > /data/r2d4/subjects/${subject}_1/perm_test/l_putamen.nii

  gunzip < /data/r2d4/subjects/${subject}_1/perm_test/l_caudate.nii.gz > /data/r2d4/subjects/${subject}_1/perm_test/l_caudate.nii
  #the files below need to be copied each time because it is overwritten during the registration process.

  cp /usr/local/freesurfer/subjects/${subject}/mri/brain.mgz /data/r2d4/subjects/${subject}_1/perm_test/brain.mgz

  mri_convert /data/r2d4/subjects/${subject}_1/perm_test/brain.mgz  /data/r2d4/subjects/${subject}_1/perm_test/brain.nii

  cp /data/r2d4/subjects/${subject}_1/RER_Run1_01/aurRER_Run1_01.nii /data/r2d4/subjects/${subject}_1/perm_test/aurRER_Run1_01.nii
done

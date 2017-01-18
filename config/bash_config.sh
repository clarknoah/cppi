#!/bin/sh

export COAX_EXT="/home/noah/coax_external"
export SUBJECT_ROOT=$COAX_EXT/patrick_project/subjects
export FREESURFER_SUBJECT_ROOT=$COAX_EXT/patrick_project/freesurfer/subjects
export R2D4MEAN_LABEL=$FREESURFER_SUBJECT_ROOT/r2d4mean/label
export SUBS_ROOT=$COAX_EXT/patrick_project/subjects/subjects
export FREESURFER_HOME="/usr/local/freesurfer"
export SUBJECTS_DIR=$COAX_EXT"patrick_project/freesurfer/subjects/"
source $FREESURFER_HOME/SetUpFreeSurfer.sh
export SUBJECTS_DIR=$COAX_EXT"patrick_project/freesurfer/subjects/"

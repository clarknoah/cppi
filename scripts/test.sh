#!/bin/sh
SUBJECT_ROOT="/Volumes/coax_lab/patrick_project/subjects/"
FREESURFER_SUBJECT_ROOT="/Volumes/coax_lab/patrick_project/freesurfer"
printf "Hello, please select which areas your would like (use spaces between Numbers) \n"
printf "Area 1: 1 \n"
printf "Area 1: 1 \n"
printf "Area 1: 1 \n"
printf "Area 1: 1 \n"
printf "Area 1: 1 \n"
printf "Area 1: 1 \n"
printf "Area 1: 1 \n"

read NAME
echo $NAME
for subject in 0006 0012 0273 0192 0490 0491 0269 0464 0494 0495 0549 0550 0557 0558 0559 0604 0605 0627
do
  echo $SUBJECT_ROOT${subject}
done

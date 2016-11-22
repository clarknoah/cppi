#
#
#  This is a shell script designed to use scp to import
#  the files I need from Patrick's Computer
#
alias prj_root='/Users/clarknoah/Development/Coax/Patrick_Project';
alias ppi_test='/ppi_test'
alias portNumber=43173
alias ext_drive='/Volumes/coax_lab/'
alias prj_root=ext_drive+'patrick_project/'

alias $specialPort="ssh -p 43173"
rsync -avz -e "ssh -p 43173" -a -f"+ */" -f"- *" beukema2@mach.psy.cmu.edu:/data/r2d4/subjects/ /Users/clarknoah/Development/Coax/Patrick_Project/ppi_test

ssh -p 43173 beukema2@mach.psy.cmu.edu

rsync -avz -e 'ssh -p 43173' --max-size=11MB  beukema2@mach.psy.cmu.edu:/data/r2d4/subjects/ /Users/clarknoah/Development/Coax/Patrick_Project/ppi_test/

$ rsync -a -f"+ */" -f"- *" source/ destination/

--max-size=10MB
exclude=/data/r2d4/subjects/

#Syncs Data.mat, sphere.mat, SPM.mat, eigens.mat, and subject directory structure
rsync -avz -e 'ssh -p 43173' --include='sphere.mat' --include='data.mat'
--include='mask.hdr' --include='mask.img' --include='SPM.mat' --include='eigens.mat'
--include='*/' --exclude='*' --prune-empty-dirs --max-size=15MB
beukema2@mach.psy.cmu.edu:/data/r2d4/subjects/ /Users/clarknoah/Development/Coax/Patrick_Project/ppi_test


#Syncs eigens to subject folder
rsync -avz -e 'ssh -p 43173'  --include='eigens.mat' --exclude='*' --prune-empty-dirs --max-size=1MB  beukema2@mach.psy.cmu.edu:/data/r2d4/ /Volumes/coax_lab/patrick_project /Users/clarknoah/Development/Coax/Patrick_Project/ppi_test

#Sync code used by patrick grab_eigens_batch.m, gppiextract.m, surface_roi_extract, grab_eigens, grab_eigens_batch, sphere_analysis
rsync -avz -e 'ssh -p 43173'  --include='*.m' --include='*.sh' --prune-empty-dirs beukema2@mach.psy.cmu.edu:/data/gppi/bin /Users/clarknoah/Development/Coax/Patrick_Project/patrick_code


#Sync code used by patrick  /data/r2d4/bin align_roi_to_LH & RH
rsync -avz -e 'ssh -p 43173' --include='coregToEpi.m' --include='removeOverlap.m' --include='centralSulcAlignmentv2.sh' --include='centralSulcAlignmentv2.m'  --include='align_rois.m' --include='align_rois_to_epi_RH.m' --include='align_rois_to_epi_LH_v1.m' --exclude='*' --prune-empty-dirs beukema2@mach.psy.cmu.edu:/data/r2d4/bin/  /Users/clarknoah/Development/coax_lab/cppi/patrick_code

ssh -p 43173 beukema2@mach.psy.cmu.edu

rsync -avz -e 'ssh -p 43173'  beukema2@mach.psy.cmu.edu:/data/r2d4/subjects /Volumes/coax_lab/patrick_project/subjects

include
/data/r2d4/subjects/
  rois/
  perm_test/
  SvR_GLM/

/usr/local/freesurfer/subjects/

exclude
/data/r2d4/subjects/

rsync -avz -e 'ssh -p 43173'  --exclude '15*' --exclude '16*' --exclude '14*' \
--exclude 150605114904/ \
--exclude alignedSearchlights/ \
--exclude bgRois/ \
--exclude cerebellarAnalysis/ \
--exclude complexGLM/ \
--exclude fieldmap_96_AP_2mmIsoVoxel_192FOV_66Slices/ \
--exclude fieldmap_96_AP_2mmIsoVoxel_192FOV_66Slices_01/ \
--exclude gmmask/ \
--exclude localizer/ \
--exclude MB3_DWI_CMRR_mbep2d_V253_5B0_b4K_noIPAT_PA_LBOn_bipolar_AdvShim/ \
--exclude RER_Run1/ \

--exclude RER_Run2/ \
--exclude RER_Run2_01/ \
--exclude RER_Run3/ \
--exclude RER_Run3_01/ \
--exclude RER_Run4/ \
--exclude RER_Run4_01/ \
--exclude RER_Run5/ \
--exclude RER_Run5_01/ \
--exclude RER_Run6/ \
--exclude RER_Run6_01/ \
--exclude RestingState/ \
--exclude RestingState_01/ \
--exclude Seq_v_Rand_Block/ \
--exclude t1_mpr_sag_iso_2pat_9degflip_TI900/ \
--exclude t2_spc_sag_p2_iso/ \
--exclude TrufiSag/ \
beukema2@mach.psy.cmu.edu:/data/r2d4/subjects /Volumes/coax_lab/patrick_project/subjects

rsync -avz -e 'ssh -p 43173' \
beukema2@mach.psy.cmu.edu:/usr/local/freesurfer/subjects /Volumes/coax_lab/patrick_project/freesurfer/subjects


rsync -avz -e 'ssh -p 43173' --include='aurRER_Run1_01.nii'/ \
 --include='lhBA123.nii' \
 --exclude '*' \
beukema2@mach.psy.cmu.edu:/data/r2d4/subjects /home/clarknoah/coax_external/patrick_project/subjects/subjects

rsync -avz -e 'ssh -p 43173' --include='*/' --include='aurRER_Run1_01.nii' \
--include='r_lhBA123_cropped.nii' \
--exclude='*' \
--prune-empty-dirs \
beukema2@mach.psy.cmu.edu:/data/r2d4/subjects /home/clarknoah/coax_external/test


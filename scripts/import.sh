#
#
#  This is a shell script designed to use scp to import
#  the files I need from Patrick's Computer
#
alias prj_root='/Users/clarknoah/Development/Coax/Patrick_Project';
alias ppi_test='/ppi_test'
alias portNumber=43173

alias $specialPort="ssh -p 43173"
rsync -avz -e "ssh -p 43173" -a -f"+ */" -f"- *" beukema2@mach.psy.cmu.edu:/data/r2d4/subjects/ /Users/clarknoah/Development/Coax/Patrick_Project/ppi_test

ssh -p 43173 beukema2@mach.psy.cmu.edu

rsync -avz -e 'ssh -p 43173' --max-size=11MB  beukema2@mach.psy.cmu.edu:/data/r2d4/subjects/ /Users/clarknoah/Development/Coax/Patrick_Project/ppi_test/

$ rsync -a -f"+ */" -f"- *" source/ destination/

--max-size=10MB
exclude=/data/r2d4/subjects/

#Syncs Data.mat, sphere.mat, SPM.mat, eigens.mat, and subject directory structure
rsync -avz -e 'ssh -p 43173' --include='sphere.mat' --include='data.mat' --include='mask.hdr' --include='mask.img' --include='SPM.mat' --include='eigens.mat' --include='*/' --exclude='*' --prune-empty-dirs --max-size=15MB  beukema2@mach.psy.cmu.edu:/data/r2d4/subjects/ /Users/clarknoah/Development/Coax/Patrick_Project/ppi_test


#Syncs eigens to subject folder
rsync -avz -e 'ssh -p 43173'  --include='eigens.mat' --exclude='*' --prune-empty-dirs --max-size=1MB  beukema2@mach.psy.cmu.edu:/data/r2d4/ /Users/clarknoah/Development/Coax/Patrick_Project/ppi_test

#Sync code used by patrick grab_eigens_batch.m, gppiextract.m, surface_roi_extract, grab_eigens, grab_eigens_batch, sphere_analysis
rsync -avz -e 'ssh -p 43173'  --include='*.m' --include='*.sh' --prune-empty-dirs beukema2@mach.psy.cmu.edu:/data/gppi/bin /Users/clarknoah/Development/Coax/Patrick_Project/patrick_code


#Sync code used by patrick  /data/r2d4/bin align_roi_to_LH & RH
rsync -avz -e 'ssh -p 43173'  --include='align_rois_to_epi_LH.m' --include='align_rois_to_epi_RH.m' --include='align_rois_to_epi_LH_v1.m' --exclude='*' --prune-empty-dirs beukema2@mach.psy.cmu.edu:/data/r2d4/bin/  /Users/clarknoah/Development/Coax/Patrick_Project/patrick_code

#Sync code used by patrick  /data/r2d4/bin align_roi
rsync -avz -e 'ssh -p 43173' --include='coregToEpi.m' --include='removeOverlap.m'  --include='align_rois.m' --include='align_rois_to_epi_RH.m' --include='align_rois_to_epi_LH_v1.m' --exclude='*' --prune-empty-dirs beukema2@mach.psy.cmu.edu:/data/r2d4/bin/  /Users/clarknoah/Development/Coax/Patrick_Project/patrick_code

ssh -p 43173 beukema2@mach.psy.cmu.edu

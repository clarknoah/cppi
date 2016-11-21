function [ output_args ] = cppi_coreg_to_epi(reference_image, source_image, roi_cells)
  %reference_image is the image that is not moved, in our case the aur epi
  %source_image is the image that is moved, in our case the brain.nii from fs
  clear matlabbatch
  spm_jobman('initcfg');
  matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {reference_image};
  matlabbatch{1}.spm.spatial.coreg.estwrite.source = {source_image};
  matlabbatch{1}.spm.spatial.coreg.estwrite.other = roi_cells';
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [2 2];
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 1;
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r_';
  spm_jobman('run', matlabbatch);
  
end


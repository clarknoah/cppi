function removeOverlap(roi1, roi2, intersectfn, outfn)
  %Compute overlap and remove those voxels from first roi
  clear matlabbatch

  spm_jobman('initcfg');
  matlabbatch{1}.spm.util.imcalc.input = {roi1
      roi2};
  matlabbatch{1}.spm.util.imcalc.output = intersectfn;
  matlabbatch{1}.spm.util.imcalc.outdir = {''};
  matlabbatch{1}.spm.util.imcalc.expression = 'i1 .* i2';
  matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
  matlabbatch{1}.spm.util.imcalc.options.mask = 0;
  matlabbatch{1}.spm.util.imcalc.options.interp = 1;
  matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
  spm_jobman('run', matlabbatch);
  %delete intersecting voxels
  %overlap = load_untouch_nii(outfn);
  overlap = load_untouch_nii(intersectfn);
  roi1 = load_untouch_nii(roi1);
  roi1.img(find(overlap.img(:))) = 0;
  save_untouch_nii(roi1,outfn);
end

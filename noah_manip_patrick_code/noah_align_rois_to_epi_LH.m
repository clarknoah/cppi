%This script coregisters an roi that is extracted from the average surface in freesurfer to the subjects functoinal space using spm coregistration routines.

subs = {'0006', '0012', '0192', '0273', '0490', '0491', '0464', '0494', '0495', '0269', '0549', '0550', '0557', '0558', '0559', '0604', '0605', '0627'};

for i = 1:length(subs);
    %brain.nii may have been overwritten with new transformation, recopy
    %from mgz to ensure correct alignment. 
    sub_root=sub_root '/data/r2d4/subjects/';
    perm_dir='perm_test/';
   
    sub = subs{i};
    command = sprintf(['mri_convert ' sub_root '%s_1/perm_test/brain.mgz  ' sub_root '%s_1/perm_test/brain.nii &'], sub,sub);
    system(command);

    
    wd = sprintf([sub_root '%s_1/perm_test/'], sub);
    cd(wd)

    hand_knob = load_untouch_nii(sprintf([sub_root '%s_1/perm_test/hand_knob_lh.nii'], sub));
    mfg_crest = load_untouch_nii(sprintf([sub_root '%s_1/perm_test/mfg_crest_lh.nii'], sub));
    BA4  = load_untouch_nii(sprintf([sub_root '%s_1/perm_test/lhBA4.nii'], sub));
    BA123 = load_untouch_nii(sprintf([sub_root '%s_1/perm_test/lhBA123.nii'], sub));
    BA6 = load_untouch_nii(sprintf([sub_root '%s_1/perm_test/lhBA6.nii'], sub));
    putamen = load_untouch_nii(sprintf([sub_root '%s_1/perm_test/l_putamen.nii'], sub));
    caudate = load_untouch_nii(sprintf([sub_root '%s_1/perm_test/l_caudate.nii'], sub));

    
    %Grab the hand knob coordinates
    [x,y,z] = ind2sub(size(hand_knob.img), find(hand_knob.img(:)));
    hand_knob = [x(1) y(1) z(1)];
    z_coord = max(y); % z coordinate are at y position
    z_max = z_coord + 20; %2 cm above
    z_min = z_coord - 20; %2 cm below
    x_coord = max(x);
    x_max = x_coord + 20; % 2 cm left
    x_min = x_coord - 20; % 2 cm right

    %Crop BA4 based on hand knob coordinates
    [x,y,z] = ind2sub(size(BA4.img), find(BA4.img(:)));
    BA4_cropped = BA4;
    XYZ = [x(:)';y(:)';z(:)'];
    XYZ = XYZ';
    XYZ(XYZ(:,2)>z_max,:) = [];
    XYZ(XYZ(:,2)<z_min,:) = [];

    XYZ(XYZ(:,1)<(x_min),:) = []; %-25 to avoid foot representation
    index = sub2ind(size(BA4.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    BA4_cropped.img = zeros(size(BA4.img));
    BA4_cropped.img(index) = 10;
    BA4fn = sprintf([sub_root '%s_1/rois/lhBA4_cropped.nii'], sub);
    save_untouch_nii(BA4_cropped, BA4fn);

    %Crop BA123 based on hand knob coordinates and remove voxels that are in both BA4 and BA123
    [x,y,z] = ind2sub(size(BA123.img), find(BA123.img(:)));
    BA123_cropped = BA123;
    XYZ = [x(:)';y(:)';z(:)']; clear x y z
    XYZ = XYZ';
    XYZ(XYZ(:,2)>z_max,:) = [];
    XYZ(XYZ(:,2)<z_min,:) = [];
    XYZ(XYZ(:,1)<x_min,:) = [];
    index = sub2ind(size(BA123.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    BA123_cropped.img = zeros(size(BA123.img));
    BA123_cropped.img(index) = 10;
    BA123_temp = sprintf([sub_root '%s_1/rois/lhBA123_cropped_temp.nii'], sub);
    save_untouch_nii(BA123_cropped, BA123_temp);

    %Exclude voxels that are in both rois:
    clear matlabbatch
    spm_jobman('initcfg');
    m1 = sprintf([sub_root '%s_1/rois/lhBA4_cropped.nii'], sub);
    s1 =  sprintf([sub_root '%s_1/rois/lhBA123_cropped_temp.nii'], sub);
    outfn =  sprintf([sub_root '%s_1/rois/lhBA1234.nii'], sub);
    matlabbatch{1}.spm.util.imcalc.input = {m1 s1};
    matlabbatch{1}.spm.util.imcalc.output = outfn;
    matlabbatch{1}.spm.util.imcalc.outdir = {''};
    matlabbatch{1}.spm.util.imcalc.expression = 'i1 .* i2';
    matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{1}.spm.util.imcalc.options.mask = 0;
    matlabbatch{1}.spm.util.imcalc.options.interp = 1;
    matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
    spm_jobman('run', matlabbatch);
    BA1234 = load_untouch_nii(sprintf([sub_root '%s_1/rois/lhBA1234.nii'], sub));
    BA123_cropped.img(find(BA1234.img(:))) = 0;
    BA123fn = sprintf([sub_root '%s_1/rois/lhBA123_cropped.nii'], sub);
    save_untouch_nii(BA123,BA123fn);


    %Grab the medial frontal gyrus crest coordinates
    [x,y,z] = ind2sub(size(mfg_crest.img), find(mfg_crest.img(:)));
    mfg_crest = [x(1) y(1) z(1)];
    z_coord_crest = max(y); % z coordinate are at y position
    z_max_crest = z_coord_crest + 20; %2 cm above
    z_min_crest = z_coord_crest - 20; %2 cm below
    x_coord_crest = max(x);
    x_max_crest = x_coord_crest + 20; % 2 cm left
    x_min_crest = x_coord_crest - 20; % 2 cm right
    
    BA6_pmd = BA6;
    [x,y,z] = ind2sub(size(BA6.img), find(BA6.img(:)));
    XYZ = [x(:)';y(:)';z(:)'];
    XYZ = XYZ';
    XYZ(XYZ(:,1)>x_coord_crest,:) = [];
    XYZ(XYZ(:,1)<x_coord-25,:) = [];
    index = sub2ind(size(BA6.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    BA6_pmd.img = zeros(size(BA6.img));
    BA6_pmd.img(index) = 10;
    pmdfn = sprintf([sub_root '%s_1/rois/lhBA_pmd.nii'], sub);
    save_untouch_nii(BA6_pmd, pmdfn);
    
    BA6_sma = BA6;
    [x,y,z] = ind2sub(size(BA6.img), find(BA6.img(:)));
    XYZ = [x(:)';y(:)';z(:)'];
    XYZ = XYZ';
    XYZ(XYZ(:,2)>z_coord,:) = [];
    XYZ(XYZ(:,1)>(x_coord - 25),:) = [];
    index = sub2ind(size(BA6.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    BA6_sma.img = zeros(size(BA6.img));
    BA6_sma.img(index) = 10;
    smafn = sprintf([sub_root '%s_1/rois/lhBA_sma.nii'], sub);
    save_untouch_nii(BA6_sma, smafn);

    BA6_pmv = BA6;
    [x,y,z] = ind2sub(size(BA6.img), find(BA6.img(:)));
    XYZ = [x(:)';y(:)';z(:)'];
    XYZ = XYZ';
    XYZ(XYZ(:,1)<x_coord_crest,:) = [];
    XYZ(XYZ(:,1)<x_coord-20,:) = [];
    index = sub2ind(size(BA6.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    BA6_pmv.img = zeros(size(BA6.img));
    BA6_pmv.img(index) = 10;
    pmvfn = sprintf([sub_root '%s_1/rois/lhBA_pmv.nii'], sub);
    save_untouch_nii(BA6_pmv, pmvfn);

    clear matlabbatch
    spm_jobman('initcfg');
    reference_image = sprintf([sub_root '%s_1/perm_test/aurRER_Run1_01.nii,1',sub);
    source_image = sprintf([sub_root '%s_1/perm_test/brain.nii,1',sub);

    %Rois
    m1_image = sprintf([sub_root '%s_1/rois/lhBA4_cropped.nii,1'], sub);
    s1_image = sprintf([sub_root '%s_1/rois/lhBA123_cropped.nii,1'], sub);
    pmd_image = sprintf([sub_root '%s_1/rois/lhBA_pmd.nii,1'], sub);
    sma_image = sprintf([sub_root '%s_1/rois/lhBA_sma.nii,1'], sub);
    pmv_image = sprintf([sub_root '%s_1/rois/lhBA_pmv.nii,1'], sub);
    putamen = sprintf([sub_root '%s_1/perm_test/l_putamen.nii,1'], sub);
    caudate = sprintf([sub_root '%s_1/perm_test/l_caudate.nii,1'], sub);
     = sprintf([sub_root '%s_1/rois/l_sup_parietal.nii,1'], sub);
    A1 = sprintf([sub_root '%s_1/rois/A1.nii,1'], sub);

    
    matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {reference_image};
    matlabbatch{1}.spm.spatial.coreg.estwrite.source = {source_image};
    matlabbatch{1}.spm.spatial.coreg.estwrite.other = {m1_image s1_image pmd_image sma_image pmv_image putamen caudate A1 ppc};
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [2 2];
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 1;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r_';
    spm_jobman('run', matlabbatch);

    %Below this point, this is all new from Aug 31 analysis
    %Correct for those voxels that were included in both pmd and m1:
    clear matlabbatch
    spm_jobman('initcfg');
    pmd = sprintf([sub_root '%s_1/rois/r_lhBA_pmd.nii'], sub);
    m1 =  sprintf([sub_root '%s_1/rois/r_lhBA4_cropped.nii'], sub);
    outfn =  sprintf([sub_root '%s_1/rois/r_lhBA4_pmd.nii'], sub);
    matlabbatch{1}.spm.util.imcalc.input = {pmd m1};
    matlabbatch{1}.spm.util.imcalc.output = outfn;
    matlabbatch{1}.spm.util.imcalc.outdir = {''};
    matlabbatch{1}.spm.util.imcalc.expression = 'i1 .* i2';
    matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{1}.spm.util.imcalc.options.mask = 0;
    matlabbatch{1}.spm.util.imcalc.options.interp = 1;
    matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
    spm_jobman('run', matlabbatch);
    rBA_pmd = load_untouch_nii(sprintf([sub_root '%s_1/rois/r_lhBA_pmd.nii'], sub));
    rBA4_pmd = load_untouch_nii(sprintf([sub_root '%s_1/rois/r_lhBA4_pmd.nii'], sub));
    rBA_pmd.img(find(rBA4_pmd.img(:))) = 0;
    rBA_pmdfn = sprintf([sub_root '%s_1/rois/r_lhBA_pmd.nii'], sub);
    save_untouch_nii(rBA_pmd,rBA_pmdfn);

    %Correct for those voxels that were included in both pmd and sma:
    clear matlabbatch
    spm_jobman('initcfg');
    pmd = sprintf([sub_root '%s_1/rois/r_lhBA_pmd.nii'], sub);
    sma =  sprintf([sub_root '%s_1/rois/r_lhBA_sma.nii'], sub);
    outfn =  sprintf([sub_root '%s_1/rois/r_lhBA_pmd_sma.nii'], sub);
    matlabbatch{1}.spm.util.imcalc.input = {pmd sma};
    matlabbatch{1}.spm.util.imcalc.output = outfn;
    matlabbatch{1}.spm.util.imcalc.outdir = {''};
    matlabbatch{1}.spm.util.imcalc.expression = 'i1 .* i2';
    matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{1}.spm.util.imcalc.options.mask = 0;
    matlabbatch{1}.spm.util.imcalc.options.interp = 1;
    matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
    spm_jobman('run', matlabbatch);
    rBA_pmd = load_untouch_nii(sprintf([sub_root '%s_1/rois/r_lhBA_pmd.nii'], sub));
    rBA_pmd_sma = load_untouch_nii(sprintf([sub_root '%s_1/rois/r_lhBA_pmd_sma.nii'], sub));
    rBA_pmd.img(find(rBA_pmd_sma.img(:))) = 0;
    rBA_pmdfn = sprintf([sub_root '%s_1/rois/r_lhBA_pmd.nii'], sub);
    save_untouch_nii(rBA_pmd,rBA_pmdfn);
    
    %Correct for those voxels that were included in both pmd and pmv:
    clear matlabbatch
    spm_jobman('initcfg');
    pmd = sprintf([sub_root '%s_1/rois/r_lhBA_pmv.nii'], sub);
    pmv =  sprintf([sub_root '%s_1/rois/r_lhBA_pmd.nii'], sub);
    outfn =  sprintf([sub_root '%s_1/rois/r_lhBA_pmd_pmv.nii'], sub);
    matlabbatch{1}.spm.util.imcalc.input = {pmd pmv};
    matlabbatch{1}.spm.util.imcalc.output = outfn;
    matlabbatch{1}.spm.util.imcalc.outdir = {''};
    matlabbatch{1}.spm.util.imcalc.expression = 'i1 .* i2';
    matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{1}.spm.util.imcalc.options.mask = 0;
    matlabbatch{1}.spm.util.imcalc.options.interp = 1;
    matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
    spm_jobman('run', matlabbatch);
    rBA_pmd = load_untouch_nii(sprintf([sub_root '%s_1/rois/r_lhBA_pmd.nii'], sub));
    r_lhBA_pmd_pmv = load_untouch_nii(sprintf([sub_root '%s_1/rois/r_lhBA_pmd_pmv.nii'], sub));
    rBA_pmd.img(find(r_lhBA_pmd_pmv.img(:))) = 0;
    rBA_pmdfn = sprintf([sub_root '%s_1/rois/r_lhBA_pmd.nii'], sub);
    save_untouch_nii(rBA_pmd,rBA_pmdfn);
    
    %exclude voxels in M1 that are included in S1 -- ToDo the same for S1?
    clear matlabbatch
    spm_jobman('initcfg');
    pmd = sprintf([sub_root '%s_1/rois/r_lhBA4_cropped.nii'], sub);
    pmv =  sprintf([sub_root '%s_1/rois/r_lhBA123_cropped.nii'], sub);
    outfn =  sprintf([sub_root '%s_1/rois/r_lhBA1234.nii'], sub);
    matlabbatch{1}.spm.util.imcalc.input = {pmd pmv};
    matlabbatch{1}.spm.util.imcalc.output = outfn;
    matlabbatch{1}.spm.util.imcalc.outdir = {''};
    matlabbatch{1}.spm.util.imcalc.expression = 'i1 .* i2';
    matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{1}.spm.util.imcalc.options.mask = 0;
    matlabbatch{1}.spm.util.imcalc.options.interp = 1;
    matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
    spm_jobman('run', matlabbatch);
    rBA4 = load_untouch_nii(sprintf([sub_root '%s_1/rois/r_lhBA4_cropped.nii'], sub));
    r_lhBA1234 = load_untouch_nii(sprintf([sub_root '%s_1/rois/r_lhBA1234.nii'], sub));
    rBA4.img(find(r_lhBA1234.img(:))) = 0;
    rBA4fn = sprintf([sub_root '%s_1/rois/r_lhBA4_cropped.nii'], sub);
    save_untouch_nii(rBA4,rBA4fn);

    %Below this point, this is all new from Aug 31 analysis
    %Correct for those voxels that were included in both pmd and m1:
    clear matlabbatch
    spm_jobman('initcfg');
    pmd = sprintf([sub_root '%s_1/perm_test/r_l_putamen.nii'], sub);
    m1 =  sprintf([sub_root '%s_1/perm_test/r_l_caudate.nii'], sub);
    outfn =  sprintf([sub_root '%s_1/rois/r_l_striatum.nii'], sub);
    matlabbatch{1}.spm.util.imcalc.input = {pmd m1};
    matlabbatch{1}.spm.util.imcalc.output = outfn;
    matlabbatch{1}.spm.util.imcalc.outdir = {''};
    matlabbatch{1}.spm.util.imcalc.expression = 'i1 | i2';
    matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{1}.spm.util.imcalc.options.mask = 0;
    matlabbatch{1}.spm.util.imcalc.options.interp = 1;
    matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
    spm_jobman('run', matlabbatch);
 
        
    
    %Correct for those voxels that were included in both pmv and m1:
    clear matlabbatch
    spm_jobman('initcfg');
    pmv = sprintf([sub_root '%s_1/rois/r_lhBA_pmv.nii'], sub);
    m1 =  sprintf([sub_root '%s_1/rois/r_lhBA4_cropped.nii'], sub);
    outfn =  sprintf([sub_root '%s_1/rois/r_lhBA4_pmv.nii'], sub);
    matlabbatch{1}.spm.util.imcalc.input = {pmv m1};
    matlabbatch{1}.spm.util.imcalc.output = outfn;
    matlabbatch{1}.spm.util.imcalc.outdir = {''};
    matlabbatch{1}.spm.util.imcalc.expression = 'i1 .* i2';
    matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{1}.spm.util.imcalc.options.mask = 0;
    matlabbatch{1}.spm.util.imcalc.options.interp = 1;
    matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
    spm_jobman('run', matlabbatch);
    rBA_pmv = load_untouch_nii(sprintf([sub_root '%s_1/rois/r_lhBA_pmv.nii'], sub));
    rBA4_pmv = load_untouch_nii(sprintf([sub_root '%s_1/rois/r_lhBA4_pmv.nii'], sub));
    rBA_pmv.img(find(rBA4_pmv.img(:))) = 0;
    rBA_pmvfn = sprintf([sub_root '%s_1/rois/r_lhBA_pmv.nii'], sub);
    save_untouch_nii(rBA_pmv,rBA_pmvfn); 
        
end

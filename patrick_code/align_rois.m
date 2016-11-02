%This script coregisters an roi that is extracted from the average surface in freesurfer to the subjects functoinal space using spm coregistration routines.
%Since brain.nii may have been overwritten with new transformation, must run centralSulcAlignmentv2.sh prior to executing this script

%Lst of subjects - could make this automatic by scrolling directory
% subs = [0006, 0012, 0192, 0273, 0490, 0491, 0464, 0494, 0495, 0269, 0549, 0550, 0557, 0558, 0559, 0604, 0605, 0627];
subs = [0006];

%location of rois that are generated by centralSulcAlignmentv2
input_roi_dir = '/Volumes/coax_lab/patrick_project/subjects/subjects/%d_1/perm_test';
output_roi_dir = '/Volumes/coax_lab/patrick_project/subjects/subjects/%d_1/rois';
hemis = {'lh', 'rh'};

for sub = subs;
  for hemi = hemis;
    in_roi_dir = sprintf(input_roi_dir, sub);
    out_roi_dir = sprintf(output_roi_dir, sub);

    %load the volumetric rois that have been written by centralSulcAlignmentv2
    hand_knob = load_untouch_nii(sprintf('%s/hand_knob_%s.nii',in_roi_dir, hemi));
    BA4  = load_untouch_nii(sprintf('%s/%sBA4.nii', in_roi_dir, hemi));
    BA123 = load_untouch_nii(sprintf('%s/%sBA123.nii', in_roi_dir, hemi));
    BA6 = load_untouch_nii(sprintf('%s/%sBA6.nii', in_roi_dir, hemi));

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
    switch hemi
      case 'lh'
        XYZ(XYZ(:,1)<(x_min),:) = []
      case 'rh'
        XYZ(XYZ(:,1)>(x_max),:) = []
    end
    index = sub2ind(size(BA4.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    BA4_cropped.img = zeros(size(BA4.img));
    BA4_cropped.img(index) = 10;
    BA4fn = sprintf('%s/%sBA4_cropped.nii', out_roi_dir, hemi);
    save_untouch_nii(BA4_cropped, BA4fn);

    %Crop BA123 based on hand knob coordinates
    [x,y,z] = ind2sub(size(BA123.img), find(BA123.img(:)));
    BA123_cropped = BA123;
    XYZ = [x(:)';y(:)';z(:)']; clear x y z
    XYZ = XYZ';
    XYZ(XYZ(:,2)>z_max,:) = [];
    XYZ(XYZ(:,2)<z_min,:) = [];
    switch hemi
      case 'lh'
        XYZ(XYZ(:,1)<(x_min),:) = []
      case 'rh'
        XYZ(XYZ(:,1)>(x_max),:) = []
    end
    index = sub2ind(size(BA123.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    BA123_cropped.img = zeros(size(BA123.img));
    BA123_cropped.img(index) = 10;
    BA123_temp = sprintf('%s/%sBA123_cropped_temp.nii', out_roi_dir, hemi);
    save_untouch_nii(BA123_cropped, BA123_temp);

    %Exclude voxels that are in both rois:
    intersectfn =  sprintf('%s/%sBA1234.nii', out_roi_dir, hemi);
    outfn = sprintf('%s/%sBA123_cropped.nii', out_roi_dir, hemi)
    removeOverlap(BA123_temp, BA4fn, intersectfn, outfn) %voxels are removed from first roi


    BA6_pmd = BA6;
    [x,y,z] = ind2sub(size(BA6.img), find(BA6.img(:)));
    XYZ = [x(:)';y(:)';z(:)'];
    XYZ = XYZ';
    XYZ(XYZ(:,1)>x_coord_crest,:) = [];
    switch hemi
      case 'lh'
        XYZ(XYZ(:,1)<x_coord-25,:) = [];
      case 'rh'
        XYZ(XYZ(:,1)>x_coord+25,:) = [];
    end
    index = sub2ind(size(BA6.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    BA6_pmd.img = zeros(size(BA6.img));
    BA6_pmd.img(index) = 10;
    pmdfn = sprintf('%s/%sBA_pmd.nii', out_roi_dir, hemi);
    save_untouch_nii(BA6_pmd, pmdfn);

    BA6_sma = BA6;
    [x,y,z] = ind2sub(size(BA6.img), find(BA6.img(:)));
    XYZ = [x(:)';y(:)';z(:)'];
    XYZ = XYZ';
    XYZ(XYZ(:,2)>z_coord,:) = [];
    switch hemi
      case 'lh'
        XYZ(XYZ(:,1)>(x_coord - 25),:) = [];
      case 'rh'
        XYZ(XYZ(:,1)<(x_coord + 25),:) = [];
    end
    index = sub2ind(size(BA6.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    BA6_sma.img = zeros(size(BA6.img));
    BA6_sma.img(index) = 10;
    smafn = sprintf('%s/%sBA_sma.nii', out_roi_dir, hemi);
    save_untouch_nii(BA6_sma, smafn);

    BA6_pmv = BA6;
    [x,y,z] = ind2sub(size(BA6.img), find(BA6.img(:)));
    XYZ = [x(:)';y(:)';z(:)'];
    XYZ = XYZ';
    XYZ(XYZ(:,1)<x_coord_crest,:) = [];
    switch hemi
      case 'lh'
        XYZ(XYZ(:,1)<x_coord-20,:) = [];
      case 'rh'
        XYZ(XYZ(:,1)>x_coord+20,:) = [];
    end

    index = sub2ind(size(BA6.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    BA6_pmv.img = zeros(size(BA6.img));
    BA6_pmv.img(index) = 10;
    pmvfn = sprintf('%s/%sBA_pmv.nii', out_roi_dir, hemi);
    save_untouch_nii(BA6_pmv, pmvfn);

    %Coregister rois to epi space
    epi_space = sprintf('%s/aurRER_Run1_01.nii,1',in_roi_dir);
    source_image = sprintf('%s/brain.nii,1',in_roi_dir);
    %Rois to register
    roi1 = sprintf('%s/%sBA4_cropped.nii,1', out_roi_dir,  hemi);
    roi2 = sprintf('%s/%sBA123_cropped.nii,1', out_roi_dir,  hemi);
    roi3 = sprintf('%s/%sBA_pmd.nii,1', out_roi_dir,  hemi);
    roi4 = sprintf('%s/%sBA_sma.nii,1', out_roi_dir,  hemi);
    roi5 = sprintf('%s/%sBA_pmv.nii,1', out_roi_dir,  hemi);
    roi6 = sprintf('%s/l_sup_parietal.nii,1', out_roi_dir, hemi);
    A1 = sprintf('%s/A1.nii,1', out_roi_dir, hemi);
    coregToEpi(epi_space, source_image, roi1, roi2, roi3, roi4,r5, roi6);

    %Correct for those voxels that were included in both pmd and m1:
    intersectfn =  sprintf('%s/r_%sBA4_pmd.nii', out_roi_dir, hemi);
    outfn = sprintf('%s/r_%sBA_pmd.nii', out_roi_dir, hemi);
    roi1 = sprintf('%s/r_%sBA_pmd.nii', out_roi_dir, hemi);
    roi2 = sprintf('%s/r_%sBA4_cropped.nii', out_roi_dir, hemi);
    removeOverlap(roi1,roi2, intersectfn, outfn) %voxels are removed from first roi

    %Correct for those voxels that were included in both pmd and sma:
    intersectfn =  sprintf('%s/r_%sBA_pmd_sma.nii', out_roi_dir, hemi);
    outfn = sprintf('%s/r_%sBA_pmd.nii', out_roi_dir, hemi);
    roi1 = sprintf('%s/r_%sBA_pmd.nii', out_roi_dir, hemi);
    roi2 = sprintf('%s/r_%sBA_sma.nii', out_roi_dir, hemi);
    removeOverlap(roi1,roi2, intersectfn, outfn) %voxels are removed from first roi

    %Correct for those voxels that were included in both pmd and pmv:
    intersectfn =  sprintf('%s/r_%sBA_pmd_pmv.nii', out_roi_dir, hemi);
    outfn = sprintf('%s/r_%sBA_pmd.nii', out_roi_dir, hemi);
    roi1 = sprintf('%s/r_%sBA_pmd.nii', out_roi_dir, hemi);
    roi2 = sprintf('%s/r_%sBA_pmv.nii', out_roi_dir, hemi);
    removeOverlap(roi1,roi2, intersectfn, outfn) %voxels are removed from first roi

    %exclude voxels in M1 that are included in S1 -- ToDo the same for S1
    intersectfn =  sprintf('%s/r_%sBA1234.nii', out_roi_dir, hemi);
    outfn = sprintf('%s/r_%sBA4_cropped.nii', out_roi_dir, hemi);
    roi1 = sprintf('%s/r_%sBA4_cropped.nii', out_roi_dir, hemi);
    roi2 = sprintf('%s/r_%sBA123_cropped.nii', out_roi_dir, hemi);
    removeOverlap(roi1,roi2, intersectfn, outfn) %voxels are removed from first roi

    %Exclude voxels that are in both rois:
    intersectfn =  sprintf('%s/r_%sBA4_pmv.nii', out_roi_dir, hemi);
    outfn = sprintf('%s/r_%sBA_pmv.nii', out_roi_dir, hemi);
    roi1 = sprintf('%s/r_%sBA_pmv.nii', out_roi_dir, hemi);
    roi2 = sprintf('%s/r_%sBA4_cropped.nii', out_roi_dir, hemi);
    removeOverlap(roi1,roi2, intersectfn, outfn) %voxels are removed from first roi
  end
end

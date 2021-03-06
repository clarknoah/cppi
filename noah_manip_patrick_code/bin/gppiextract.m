
allSubs = {'0006', '0012', '0192', '0273', '0490', '0491', '0464', '0494', '0495', '0269', '0549', '0550', '0557', '0558', '0559', '0604', '0605', '0627'};


rois = {'rBA4cluster.img', 'rBA123cluster.img'};
data = [];

for i = 1:length(allSubs);
    SID = allSubs{i}

    cd(sprintf('/data/r2d4/subjects/%s_1/perm_test/', SID));
    spmFile = sprintf('/data/r2d4/subjects/%s_1/SvR_GLM/SPM.mat',SID);
    SvR_GLM = load(spmFile);
    SvR_GLM = SvR_GLM.SPM;

    preH = sprintf('/data/r2d4/subjects/%s_1/perm_test/%s', SID, 'perm_searchlight_output_H_pre.img');
    preH = load_untouch_nii(preH);
    clear matlabbatch


    m1 = sprintf('/data/r2d4/subjects/%s_1/rois/r_lhBA4_cropped.nii',SID);
    s1 = sprintf('/data/r2d4/subjects/%s_1/rois/r_lhBA123_cropped.nii',SID);
    hand_knob = load_untouch_nii(sprintf('/data/r2d4/subjects/%s_1/perm_test/hand_knob_lh.nii', SID));
    [x,y,z] = ind2sub(size(hand_knob.img), find(hand_knob.img(:)));
    hand_knob = [x(1) y(1) z(1)];

    %find Max value and get its data
    maxval = max(preH.img(:));
    indx = find(preH.img==maxval);
    [x,y,z] = ind2sub(size(preH.img), indx);
    vox = [x y z]';
    peak_xyz = vox

    %Find peak voxel closest to hand knob
    for nvoxels = 1:size(peak_xyz,2);
        distances(nvoxels) = sqrt((peak_xyz(1, nvoxels)-hand_knob(1)).^2+(peak_xyz(2,nvoxels)-hand_knob(2)).^2+(peak_xyz(3,nvoxels)-hand_knob(3)).^2);
    end;
    
    [r,ind] = min(distances);
    peak_xyz = peak_xyz(:,ind);
    
    peak_data = spm_get_data(SvR_GLM.xY.VY,vox);

    Vmask = spm_vol(m1);
    roiMask = spm_read_vols(Vmask);
    [x, y, z] = ind2sub(size(roiMask),find(roiMask(:)));
    m1_vox = [x y z]';
    m1_roi_data = spm_get_data(SvR_GLM.xY.VY,m1_vox);
    
    Vmask = spm_vol(s1);
    roiMask = spm_read_vols(Vmask);
    [x, y, z] = ind2sub(size(roiMask),find(roiMask(:)));
    s1_vox = [x y z]';
    s1_roi_data = spm_get_data(SvR_GLM.xY.VY,s1_vox);


    save('data.mat', 'peak_data', 'm1_roi_data', 's1_roi_data', 'peak_xyz');
    clear distances
end



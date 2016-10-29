function [seed_voxel,seed_xyz] = cppi_extract_seed_voxel(SPM_extract,preH,hand_knob)
%CPPI_EXTRACT_SEED_VOXEL Extracts Seed Voxel
%   Detailed explanation goes here
% --- Arguments ----
%       SPM_extract = 'SPM.xY.VY'
%       preH = 'perm_test/perm_searchlight_output_H_pre.img'
%       'perm_test/preH.img'
%
%
%
%

[x,y,z] = ind2sub(size(hand_knob.img), find(hand_knob.img(:)));
hand_knob = [x(1) y(1) z(1)];
%find Max value and get its data
maxval = max(preH.img(:));
indx = find(preH.img==maxval);
[x,y,z] = ind2sub(size(preH.img), indx);
vox = [x y z]';
peak_xyz = vox;


%Find peak voxel closest to hand knob
for nvoxels = 1:size(peak_xyz,2);
    distances(nvoxels) = sqrt( ...
                                (peak_xyz(1, nvoxels)-hand_knob(1)).^2+ ...
                                (peak_xyz(2,nvoxels)-hand_knob(2)).^2+ ...
                                (peak_xyz(3,nvoxels)-hand_knob(3)).^2 ...
                            );
end;


[r,ind] = min(distances);
seed_xyz = peak_xyz(:,ind);

seed_voxel = spm_get_data(SPM_extract,seed_xyz);
end


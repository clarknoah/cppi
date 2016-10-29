function [rois] = cppi_extract_roi_timeseries(SPM_extract, rois)
%CPPI_EXTRACT_ROI_TIMESERIES Extracts roi timeseries for a given ROI
%   Function should be able to handle input from struct file with n 
%   number of ROIs

for region=1:length(rois)
    Vmask = spm_vol(rois(region).path);
    roiMask = spm_read_vols(Vmask);
    [x, y, z] = ind2sub(size(roiMask),find(roiMask(:)));
    rois(region).coordinates = [x y z]';
    rois(region).timeseries = spm_get_data(SPM_extract,rois(region).coordinates);
    
end
end


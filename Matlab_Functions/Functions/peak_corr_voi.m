function [ corr ] = peak_corr_voi(peak, voi)
%Peak Voxel Correlation Function
%   This function accepts the time series for the peak voxel
%   and a voxel of interest, and determines how different
%   there activity is. 

corr = [];

for n = 1:size(peak,1)
    corr(n,1) = peak(n)-peak(n+1);  
    corr(n,2) = voi(n)-voi(n+1);
end
end


function [betas, ppi_mtx] = glm_analysis(design_mtx, y_data, phys,roi)
%GLM_ANALYSIS Summary of this function goes here
%   Detailed explanation goes here
%   design_mtx:        Design Matrix (1 x T)
%   y_data:     The sphere of voxels surrounding the seed voxel (n x T)
%   phys:       The psychological time course of the seed voxel
%   load pre variables (peak_data, roi_data, y_data, psy)

%   run create_ppi for pre-variables
    
       
    ppi_ran = create_ppi(design_mtx(:,1),y_data,phys);
    ppi_seq = create_ppi(design_mtx(:,2),y_data,phys);
    design_mtx(:,1) = ppi_ran;
    design_mtx(:,2) = ppi_seq;
    
    %   run beta_extract
    [betas, ppi_mtx] = beta_extract(design_mtx,roi);


end


function [beta] = cppi_extract_betas(ppi_matrix, roi_voxels)
%CPPI_EXTRACT_BETAS Extracts the beta coefficients 

    beta = inv(ppi_matrix.'*ppi_matrix)*ppi_matrix.'*roi_voxels;
    
    

end


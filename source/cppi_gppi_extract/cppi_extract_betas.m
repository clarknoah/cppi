function [ output_args ] = cppi_extract_betas(ppi_matrix, eigen_vector)
%CPPI_EXTRACT_BETAS Extracts the beta coefficients 

    beta = inv(ppi_matrix.'*ppi_matrix)*ppi_matrix.'*voxel;

end


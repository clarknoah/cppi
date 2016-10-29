function [ppi_design] = cppi_extract_ppi_design(task_design,seed_eigen_vector)
%CPPI_EXTRACT_PPI_DESIGN Creates PPI
% --- Arguments ---
%         task_design:	Contains the task design matrix (SPM.xX.xKXs.X)
%   seed_eigen_vector:  Contains eigen vector for the seed voxel
%
    ppi_random = task_design(:,1).*seed_eigen_vector;
    ppi_sequence = task_design(:,2).*seed_eigen_vector;
    task_design(:,1) = ppi_random;
    task_design(:,2) = ppi_sequence;
    ppi_design = task_design;

end


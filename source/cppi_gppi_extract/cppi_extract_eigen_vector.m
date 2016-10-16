function [ eigen_vector] = cppi_extract_eigen_vector( ...
    seed_voxel, ...
    task_design, ...
    seed_voxel_xyz, ...
    SPM, ...
    sphere_radius)
%CPPI_EXTRACT_EIGEN_VECTOR: Extracts eigen vector from seed & task

%{
    This function takes in a seed_voxel, task_design_matrix, 
    seed_voxel_xyz, SPM
    
%}
    
y_data = light_grab(seed_voxel_xyz, sphere_radius, Vmask, Vdata);

end


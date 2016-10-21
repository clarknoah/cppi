function [beta, ppi_mtx] = beta_extract(ppi_mtx,voxel)
%BETA_EXTRACT produces the beta hat values. I think.
%    
    beta = inv(ppi_mtx.'*ppi_mtx)*ppi_mtx.'*voxel;
end


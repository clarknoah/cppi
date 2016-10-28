function [seed_sphere] = cppi_extract_seed_sphere(coord, dim, Vmask, Vdata)
%CPPI_EXTRACT_SEED_SPHERE Outputs 3D seed_voxel sphere for eigen vector generation
%--- Variables ---
%   coord: XYZ coordinate for seed voxel
%   dim: Radius the sphere
%   Vmask: SvR_GLM/mask.hdr
%   Vdata: SPM.xY.VY


X = zeros(Vmask.dim);
[x,y,z]=ind2sub(size(X),1:prod(size(X)));
C=[x;y;z;ones(1,length(y))];
C=Vmask.mat*C;
dis=sqrt((C(1,:)-coord(1)).^2+(C(2,:)-coord(2)).^2+(C(3,:)-coord(3)).^2);

X(dis<dim)=1;
[x, y, z] = ind2sub(size(X),find(X(:)));
vox = [x y z]';
seed_sphere = spm_get_data(Vdata,vox);

end

function [ eigen_variate] = cppi_extract_eigen_vector(seed_sphere)
%CPPI_EXTRACT_EIGEN_VECTOR Extracts eigen vector from seed & task

%{
--- Variables ---
    seed_sphere: Contains 3d sphere of the seed_voxel

%}

% compute regional response in terms of first eigenvariate
[m n]   = size(seed_sphere);
if m > n
[v s v] = svd(seed_sphere'*seed_sphere);
s       = diag(s);
v       = v(:,1);
u       = seed_sphere*v/sqrt(s(1));
else
[u s u] = svd(seed_sphere*seed_sphere');
s       = diag(s);
u       = u(:,1);
v       = seed_sphere'*u/sqrt(s(1));
end
d       = sign(sum(v));
u       = u*d;
v       = v*d;
Y       = u*sqrt(s(1)/n);

xY.seed_sphere     = seed_sphere;
xY.yy    = transpose(mean(transpose(seed_sphere))); %average (not in spm_regions)
eigen_variate    = Y; %eigenvariate
xY.v    = v;
xY.s    = s;
xY.X0   = [];

end

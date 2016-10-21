function y_data = light_grab(coord, dim, Vmask, Vdata);

X = zeros(Vmask.dim);
[x,y,z]=ind2sub(size(X),1:prod(size(X)));
C=[x;y;z;ones(1,length(y))];
C=Vmask.mat*C;
dis=sqrt((C(1,:)-coord(1)).^2+(C(2,:)-coord(2)).^2+(C(3,:)-coord(3)).^2);

X(dis<dim)=1;
[x, y, z] = ind2sub(size(X),find(X(:)));
vox = [x y z]';
y_data = spm_get_data(Vdata,vox);
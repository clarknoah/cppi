y=spm_get_data(SPM.xY.VY,y_data);
[U,S,V] = svd(y);
 
 U = diag(U);
 S = S(:,1);
 V = y*S/sqrt(U(1));
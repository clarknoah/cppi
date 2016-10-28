function [eigen_variate] = eigen_returns(y)


    % compute regional response in terms of first eigenvariate
	[m n]   = size(y);
	if m > n
		[v s v] = svd(y'*y);
		s       = diag(s);
		v       = v(:,1);
		u       = y*v/sqrt(s(1));
	else
		[u s u] = svd(y*y');
		s       = diag(s);
		u       = u(:,1);
		v       = y'*u/sqrt(s(1));
	end
	d       = sign(sum(v));
	u       = u*d;
	v       = v*d;
	Y       = u*sqrt(s(1)/n);

    xY.y     = y;
    xY.yy    = transpose(mean(transpose(y))); %average (not in spm_regions)
	eigen_variate    = Y; %eigenvariate
	xY.v    = v;
	xY.s    = s;
    xY.X0   = [];
end

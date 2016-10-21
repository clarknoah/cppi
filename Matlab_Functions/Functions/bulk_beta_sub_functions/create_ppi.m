function [ppi_demeaned] = create_ppi(psy,y_data,phys)
%CREATE_PPI Summary of this function goes here
%   psy:        Physiological Task vector time series (1 x T)
%   y_data:     The sphere of voxels surrounding the seed voxel (n x T)
%   phys:       The psychological time course of the seed voxel
    %create SVD of y_data
    %[U,S,V] = svd(y_data);
    flow = 'eigen';
    
    
    %PPI is the dot product of the demeaned psy*demeaned phys

   if strcmp(flow,'eigen')
       ppi_demeaned = psy.*phys;
   elseif strcmp(flow,'demeaned')
       
        %demean task time-course
        psy_demeaned = demeaned(psy);
        
        %demean seed voxel (physiological) time course
        phys_demeaned = demeaned(phys);
        
        
        ppi = psy_demeaned.*phys_demeaned;
        ppi_demeaned = demeaned(ppi);
       
   elseif strcmp(flow,'demeanedEigen')
       
       % psy_demeaned = demeaned(psy);
   else
   end

end


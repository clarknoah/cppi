function [] = voxelCompare(seed,roi, task)
%VOXELCOMPARE Summary of this function goes here
%   Detailed explanation goes here

    %demean seed
    y_data = 1;
    de_seed = demeaned(seed);

    ppi = create_ppi(task,y_data,seed);
    
    %PPI is colored solid and is dot-dashed
    hold;
    plot(ppi,'b');

   % plot(de_seed,'-r');
   
    %ROI Voxel is colored solid red
    plot(demeaned(roi),'-r');
   
    %Task is dashed black diamonds
    plot(demeaned(task),'--dk');
    

end


function [cropped] = cppi_img_crop(pre_cropped,c_max,c_min)
%CPPI_IMG_CROP Summary of this function goes here
%   pre_cropped: nii file for the roi that has not been cropped
%   y_max: y coordinate that is used to remove all values greater than this
%   y_min: y coordinate that removes all values less than this

    [x,y,z] = ind2sub(size(pre_cropped.img), find(pre_cropped.img(:)));
    cropped = pre_cropped;
    XYZ = [x(:)';y(:)';z(:)'];
    XYZ = XYZ';
    for dim=1:length(c_max(1,:))
        for options=1:length(c_max(:,1))
            if(c_max(options,dim)~=0)
                XYZ(XYZ(:,dim)>c_max(options,dim),:) = [];
            end     
        end
        for options=1:length(c_min(:,1))
            if(c_min(options,dim)~=0)
                XYZ(XYZ(:,dim)<c_min(options,dim),:) = [];
            end     
        end        
    end

    
    index = sub2ind(size(pre_cropped.img), XYZ(:,1), XYZ(:,2), XYZ(:,3));
    cropped.img = zeros(size(pre_cropped.img));
    cropped.img(index) = 10;

end


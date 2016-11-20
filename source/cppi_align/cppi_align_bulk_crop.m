function [cppi,payload] = cppi_align_bulk_crop(cppi,payload,subject,session)
%CPPI_BULK_CROP Summary of this function goes here
%   Detailed explanation goes here
fields = fieldnames(payload.files);
    for x=1:length(fields) 
        file = payload.files.(char(fields(x)));
        if(strcmp(file.function,'roi'))
            if(file.hemi==true)
                for y=1:length(fields)
                    seed = payload.files.(char(fields(y)));
                    if(seed.hemi==true && seed.cropper==true)
                        lh_c_max=[0,seed.lh.coord.z_max,0];
                        lh_c_min=[seed.lh.coord.x_min,seed.lh.coord.z_min,0];
                        rh_c_max=[seed.rh.coord.x_max,seed.rh.coord.z_max,0];
                        rh_c_min=[0,seed.rh.coord.z_min,0];  
                        
                        file.lh.obj = cppi_img_crop(file.lh.obj,lh_c_max,lh_c_min); 
                        file.rh.obj = cppi_img_crop(file.rh.obj,rh_c_max,rh_c_min);  

                        file.lh = cppi.save_session_file(file.lh, ...
                            file.lh.cropped_path,subject,session);
                        file.rh= cppi.save_session_file(file.rh, ...
                           file.rh.cropped_path,subject,session);
                        payload.files.(char(fields(x))).lh = file.lh;
                        payload.files.(char(fields(x))).rh = file.rh;
                    end
                end
               
            end
        end
    end
end


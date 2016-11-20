function [payload] = cppi_assign_seed_coords(payload)
%CPPI_ASSIGN_SEED_COORDS Summary of this function goes here
%   Detailed explanation goes here

    fields = fieldnames(payload.files);
    for x=1:length(fields) 
        file = payload.files.(char(fields(x)));
        if(strcmp(file.function,'seed'))
            if(file.hemi==true)
                file.lh.coord = cppi_grab_coords(file.lh.obj,20,-20);
                file.rh.coord = cppi_grab_coords(file.rh.obj,20,-20);
                payload.files.(char(fields(x))) = file;
            elseif(file.hemi==false)
                file.coord = cppi_grab_coords(file.obj,20,-20);
                payload.files.(char(fields(x))) = file;
            end
        end
    end

end


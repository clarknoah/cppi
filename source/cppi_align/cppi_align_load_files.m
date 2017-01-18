function [payload] = cppi_align_load_files(cppi,payload,subject,session)
%CPPI_ALIGN_LOAD_FILES Loads nii files into payload object
%   Function iterates through payload object and loads paths as nii files
%   so they can be maniplated

%TODO: Determine if there is a more effective way of doing this, as the
%payload file becomes very large and it requires the files to be pass
%around matlab while still in memory, somewhat messy. 
    fields = fieldnames(payload.files);
    for x=1:length(fields)
        file = payload.files.(char(fields(x)));
        if(file.hemi==false)
           file.obj = cppi.load_session_file( ...
                     file.org_path, ...
                     subject, ...
                     session);
           
        elseif(file.hemi==true)
         file.lh.obj = cppi.load_session_file( ...
             file.lh.org_path, ...
             subject, ...
             session);
     
         file.rh.obj = cppi.load_session_file( ...
             file.rh.org_path, ...
             subject, ...
             session);     
        else
        end
        payload.files.(char(fields(x))) = file;
    end

end


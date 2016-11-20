function [ output_args ] = cppi_align_bulk_overlap(cppi,payload,subject,session)
%CPPI_ALIGN_BULK_OVERLAP Summary of this function goes here
%   Detailed explanation goes here
fields = fieldnames(payload.files);
  for x=1:length(fields)
        file = payload.files.(char(fields(x)));
        %Determines if file is an ROI
        
        if(strcmp(file.function,'roi')&& file.hemi==true)
            priority = file.overlap_priority;
            for y=1:length(fields)
            	o_file = payload.files.(char(fields(y)));
                
                %Determines if o_file has larger priority value
                if(strcmp(o_file.function,'roi')&& o_file.hemi==true ...
                        && priority<o_file.overlap_priority)
                    %develop function that can determine if there's overlap
                    %before I do big batch func
                    intersectfn =  cppi.parse_session_path('%s/%s%s/perm_test/lhBA1234.nii', subject,session);
                    cppi_align_rm_overlap( ...
                        cppi.parse_session_path(o_file.lh.current_path,subject,session), ...
                        cppi.parse_session_path(file.lh.current_path,subject,session), ...
                        intersectfn, ...
                        cppi.parse_session_path(o_file.lh.current_path,subject,session)...
                        ); %voxels are removed from first roi
                     intersectfn =  cppi.parse_session_path('%s/%s%s/perm_test/rhBA1234.nii', subject,session);
                    cppi_align_rm_overlap( ...
                        cppi.parse_session_path(o_file.rh.current_path,subject,session), ...
                        cppi.parse_session_path(file.rh.current_path,subject,session), ...
                        intersectfn, ...
                        cppi.parse_session_path(o_file.rh.current_path,subject,session)...
                        ); %voxels are removed from first roi
                end  
            end
        end
    end
  

end


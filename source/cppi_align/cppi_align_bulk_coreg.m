function [cppi,payload] = cppi_align_bulk_coreg(cppi,payload,subject,session)
%CPPI_ALIGN_BULK_COREG Summary of this function goes here
%   Detailed explanation goes here
    fields = fieldnames(payload.files);
    rh_rois = {};
    lh_rois = {};
    counter=1;
    for x=1:length(fields)
        file = payload.files.(char(fields(x)));
        if(strcmp(file.function,'roi')&& file.hemi==true)
            lh_rois{counter} = cppi.parse_session_path( ...
                file.lh.current_path,subject,session);
            disp(lh_rois{counter});
            rh_rois{counter} = cppi.parse_session_path( ...
                file.rh.current_path,subject,session);
            sl= strsplit(file.lh.current_path,'/');
            lenl = length(sl);
            lenl = sl(lenl);
            sr= strsplit(file.rh.current_path,'/');
            lenr = length(sr);
            lenr = sr(lenr);            
  
            payload.files.(char(fields(x))).lh.current_path=char(['%s/%s%s/rois/r_' char(lenl)]);
            payload.files.(char(fields(x))).rh.current_path=char(['%s/%s%s/rois/r_' char(lenr)]);
        
        counter=counter+1;
        end
    end
    
    cppi_coreg_to_epi( ...
        [cppi.parse_session_path( ...
            payload.files.aurRER_Run1_01.current_path,subject,session) ',1'], ...
        [cppi.parse_session_path( ...
            payload.files.brain.current_path,subject,session) ',1'], ...
        lh_rois);
    
    cppi_coreg_to_epi(...
        [cppi.parse_session_path( ...
            payload.files.aurRER_Run1_01.current_path,subject,session) ',1'], ...
        [cppi.parse_session_path( ...
            payload.files.brain.current_path,subject,session) ',1'], ...
        rh_rois);

end


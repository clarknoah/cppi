function [cppi_tools] = cppi_batch_subjects( ...
                        rois, ...
                        sub_root_dir, ...
                        subjects, ...
                        output_name, ...)
%CPPI_BATCH_SUBJECTS Iterates through subjects producting Cppi_Subjects
%   
%   sub_root_dir:	Argument should contains string of the full path to the
%                   subjects root directory
%
%       subjects:   Contains array of the root subjects folder name, not
%                   including its session number (pre/post)
%
%  Output Folder:   Name of the folder you want your cppi subjects to go in
    mkdir(sub_root_dir,'ccpi_subjects');
    subjects_array = [];
    
    for x=1:length(subjects)
        pre_session_dir = [sub_root_dir subjects(x).name '_1'];
        post_session_dir = [sub_root_dir subjects(x).name '_2'];
        
        
        pre_session = cppi_extract_session_features(pre_session_dir);
        post_session = cppi_extract_session_features(post_session_dir);
        
        subject = Cppi_Subject(subjects(x).name, subjects(x).group ...
            , pre_session, post_session);
        
        subjects_array = [subjects_array, subject];

        % TO-DO catch parsing errors
         save([sub_root_dir output_name '/' ...
             subjects(x) '_cppi_subject.mat'],'subject');
    end
    
    cppi_tools = Cppi_Tools(subjects_array);
    

end


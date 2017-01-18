function [cppi_tools] = cppi_batch_subjects(config,payload)
%CPPI_BATCH_SUBJECTS Iterates through subjects producting Cppi_Subjects
% --- ARGUMENTS ---
%
%           rois:   TO-DO
%
%   sub_root_dir:	  Argument should contains string of the full path to the
%                   subjects root directory
%
%       subjects:   Contains array of structs for each subject, not
%                   including its session number (pre/post) in the following
%                   format:
%                    subjects = [
%                      struct('name','0006','group','sequence'),
%                      struct('name','0012','group','sequence')
%                      etc
%x                    ]
%
%    output_name:   Name of the folder you want your cppi subjects to go in

    %TODO: Use the config file to automate pre/post sessions. Basically
    % turn the for x=1:length(subjects) into a function that outputs
    % directly to Cppi_Subject, and reads the config file to do so
    
    
    %mkdir(subs_root_dir,'ccpi_subjects');
    subjects_array = [];
    session_pre = '_1';
    session_post = '_2';
    subjects = config.subjects;
    payload_org = payload;
    for x=1:length(subjects)
        pre_session_dir = [config.paths.subjects_root '/' subjects{x}.name '_1/'];
        post_session_dir = [config.paths.subjects_root '/' subjects{x}.name '_2/'];


        [pre_session,payload] = cppi_extract_session_features( ...
                                  pre_session_dir, ...
                                  config.paths.subjects_root, ...
                                  subjects{x}.name, ...
                                  config, ...
                                  payload_org, ...
                                  session_pre );
                          
        [post_session,payload] = cppi_extract_session_features( ...
                                  post_session_dir, ...
                                  config.paths.subjects_root, ...
                                  subjects{x}.name, ...
                                  config, ...
                                  payload, ...
                                  session_post);

        subject = Cppi_Subject(subjects{x}.name, subjects{x}.group ...
            , pre_session, post_session);

        subjects_array = [subjects_array, subject];

        % TO-DO catch parsing errors
       %  save([sub_root_dir output_name '/' ...
       %      subjects(x) '_cppi_subject.mat'],'subject');
    end
    disp('*****************')
    cppi_tools = Cppi_Tools(subjects_array);


end

classdef Cppi_Subject
    %CPPI_SUBJECT Class contains subject details and analyzed data
    %   Detailed explanation goes here
    
    properties
        name;
        group;
        pre;
        post;
        beta_differences;
        
        
    end
    
    methods
      function obj = Cppi_Subject( ...
              subject_name, ...
              subject_group, ...
              pre_session, ...
              post_session)
          obj.name = subject_name;
          obj.group = subject_group;
          obj.pre = cppi_subject_create_session(pre_session);
          obj.post = cppi_subject_create_session(post_session);
          obj.beta_differences = cppi_subject_beta_analysis(obj.pre,obj.post);
        
      end

    end
    
end


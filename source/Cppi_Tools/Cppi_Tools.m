classdef Cppi_Tools
    %CPPI_TOOLS Summary of this class goes here
    %   Detailed explanation goes here

    properties
        subjects;
    end

    methods
        function obj = Cppi_Tools(subjects)
        	obj.subjects = subjects;
        end
        
        function [mean_beta_array,properties]=extract_group_betas(obj,group,seed,roi,task_type)
            mean_beta_array = [];
            properties = struct();
            properties.seed = seed;
            properties.roi = roi;
            properties.group = group;
            properties.task_type = task_type;
            properties.total_subjects = length(obj.subjects);
            
            for x=1:length(obj.subjects)
                if(strcmp(obj.subjects(x).group,group))
                   for y=1:length(obj.subjects(x).beta_differences)
                   if(strcmp(obj.subjects(x).beta_differences(y).seed,seed) ...
                     && strcmp(obj.subjects(x).beta_differences(y).roi,roi))
                 
                        mean_beta_array = [mean_beta_array; ...
                            obj.subjects(x).beta_differences(y).(task_type).post_minus_pre_mean, ...
                            obj.subjects(x).beta_differences(y).(task_type).post_minus_pre_sem];
                 
                 
                   end
                   end
                end
            end
        end
        
        function [avg_beta]=average_beta_and_sem(obj,betas)
            avg_beta = [];
            if(length(betas)==0)
                avg_beta=[0,0];
            else
            avg_beta(1) = mean(betas(:,1));
            avg_beta(2) = mean(betas(:,2));
            end
        end
        function roi=extract_roi_mean_betas(obj,roi1,seed)
        roi = struct();
        roi.name = [roi1 ' with ' seed];
        [roi.trg_ran,prop] = extract_group_betas(obj,'training',seed,roi1,'random');
        [roi.trg_seq,prop] = extract_group_betas(obj,'training',seed,roi1,'sequence');
        [roi.ctrl_ran,prop] = extract_group_betas(obj,'control',seed,roi1,'random');
        [roi.ctrl_seq,prop] = extract_group_betas(obj,'control',seed,roi1,'sequence');
        roi.trg_ran = obj.average_beta_and_sem(roi.trg_ran);
        roi.trg_seq = obj.average_beta_and_sem(roi.trg_seq);
        roi.ctrl_ran = obj.average_beta_and_sem(roi.ctrl_ran);
        roi.ctrl_seq = obj.average_beta_and_sem(roi.ctrl_seq);
        end
        
        function [betas,sem]=extract_roi_beta_comparison(obj,roi1,roi2,seed)
        r1 = obj.extract_roi_mean_betas(roi1,seed);
        r2 = obj.extract_roi_mean_betas(roi2,seed);
        
  %      betas = [r1.trg_seq(1),r1.ctrl_seq(1);r1.trg_ran(1),r1.ctrl_ran(1); ...
  %          r2.trg_seq(1),r2.ctrl_seq(1);r2.trg_ran(1),r2.ctrl_ran(1)];
        
  %      sem=[r1.trg_seq(2),r1.ctrl_seq(2);r1.trg_ran(2),r1.ctrl_ran(2); ...
  %         r2.trg_seq(2),r2.ctrl_seq(2);r2.trg_ran(2),r2.ctrl_ran(2)];
   
        betas = [r1.trg_seq(1),r2.trg_seq(1);r1.ctrl_seq(1),r2.ctrl_seq(1); ...
            r1.trg_ran(1),r2.trg_ran(1);r1.ctrl_ran(1),r2.ctrl_ran(1)];
        
        sem=[r1.trg_seq(2),r2.trg_seq(2);r1.ctrl_seq(2),r2.ctrl_seq(2); ...
            r1.trg_ran(2),r2.trg_ran(2);r1.ctrl_ran(2),r2.ctrl_ran(2)];
        
        end
        
        %TEST-EVAL FUNCTIONS
        function [t] = eval_beta_differences(obj,sub,roi,seed,task)
            Post_Mean_Beta = [];
            Pre_Mean_Beta = [];
            temp_subjects = obj.subjects(sub);
            for x=1:length(temp_subjects)
                Post_Mean_Beta = [Post_Mean_Beta; temp_subjects(x).post.rois(roi).seeds(seed).betas.(task).mean];
                Pre_Mean_Beta = [Pre_Mean_Beta; temp_subjects(x).pre.rois(roi).seeds(seed).betas.(task).mean];
            end
            Difference = Post_Mean_Beta-Pre_Mean_Beta;
            Seed = cell(length(temp_subjects),1);
            Seed(:) = {obj.subjects(sub(1)).post.rois(roi).seeds(seed).name};
            Roi = cell(length(temp_subjects),1);
            Roi(:) = {obj.subjects(sub(1)).post.rois(roi).name};
            Subjects = {obj.subjects(sub).name}.';
            Group = {obj.subjects(sub).group}.';
            disp(length(Post_Mean_Beta));
            disp(length(Pre_Mean_Beta));
            disp(length(Roi));
            disp(length(Seed));
            disp(length(Difference));
            disp(length(Subjects));
           t = table(Post_Mean_Beta,Pre_Mean_Beta,Difference,Seed,Roi,Group,...
               'RowNames',Subjects);
        end
    end

end

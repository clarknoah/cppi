function [diffs] = cppi_subject_beta_analysis(pre_session,post_session)
%CPPI_SUBJECT_BETA_ANALYSIS Analyzes the difference between pre-post, beta
%values.
%   Detailed explanation goes here
diffs = [];
for roi=1:length(pre_session.rois)
    for x=1:length(pre_session.rois(roi).seeds)
        beta_differences = struct();
        beta_differences.roi = pre_session.rois(roi).name;
        beta_differences.seed = pre_session.rois(roi).seeds(x).name;
        beta.differences.random = struct();
        beta.differences.sequence = struct();
        beta_differences.name = [pre_session.rois(roi).name ...
           ' with ' pre_session.rois(roi).seeds(x).name ' seed'];

        beta_differences.random.post_minus_pre_raw = ...
            post_session.rois(roi).seeds(x).betas.random.raw - ...
            pre_session.rois(roi).seeds(x).betas.random.raw;

        beta_differences.random.post_minus_pre_mean = ...
            mean(beta_differences.random.post_minus_pre_raw);

        beta_differences.random.post_minus_pre_sem = ...
           cppi_sem(beta_differences.random.post_minus_pre_raw);


        beta_differences.sequence.post_minus_pre_raw = ...
            post_session.rois(roi).seeds(x).betas.sequence.raw - ...
            pre_session.rois(roi).seeds(x).betas.sequence.raw;

        beta_differences.sequence.post_minus_pre_mean = ...
            mean(beta_differences.sequence.post_minus_pre_raw);

        beta_differences.sequence.post_minus_pre_sem = ...
           cppi_sem(beta_differences.sequence.post_minus_pre_raw);
        diffs = [diffs,beta_differences];    
    
    end
end

 
end


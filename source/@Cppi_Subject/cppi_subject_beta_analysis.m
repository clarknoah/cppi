function [diffs] = cppi_subject_beta_analysis(pre_session,post_session)
%CPPI_SUBJECT_BETA_ANALYSIS Analyzes the difference between pre-post, beta
%values.
%   Detailed explanation goes here
diffs = [];
for roi=1:length(pre_session.rois)
    beta_differences.name = pre_session.rois(roi).name;
    
    beta_differences.random.post_minus_pre_raw = ...
        post_session.rois(roi).betas.random.raw - ...
        pre_session.rois(roi).betas.random.raw;
    
    beta_differences.random.post_minus_pre_mean = ...
        mean(beta_differences.random.post_minus_pre_raw);
    
    beta_differences.random.post_minus_pre_sem = ...
       sem(beta_differences.random.post_minus_pre_raw);
   
       
    beta_differences.sequence.post_minus_pre_raw = ...
        post_session.rois(roi).betas.sequence.raw - ...
        pre_session.rois(roi).betas.sequence.raw;
    
    beta_differences.sequence.post_minus_pre_mean = ...
        mean(beta_differences.sequence.post_minus_pre_raw);
    
    beta_differences.sequence.post_minus_pre_sem = ...
       sem(beta_differences.sequence.post_minus_pre_raw);
    diffs = [diffs,beta_differences];
end

 
end


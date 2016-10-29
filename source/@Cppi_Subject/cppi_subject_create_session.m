function [session] = cppi_subject_create_session(session)
%CPPI_SUBJECT_CREATE_SESSION Handles session generation in Cppi_Subject
%constructor.
%   Detailed explanation goes here


session.task_design = cppi_extract_task_design(session.SPM);
session.ppi_design = cppi_extract_task_design( ...
                    session.task_design, ...
                    session.eigen);
                
for roi=x:length(session.rois)
    session.rois(roi).betas = struct('random',struct(),'sequence',struct());
    betas = cppi_extract_betas(session.ppi_matrix, session.eigen);
    session.rois(roi).betas.raw =  betas;
    session.rois(roi).betas.random.betas = betas(1,:);
    session.rois(roi).betas.random.sum = sum(betas(1,:));
    session.rois(roi).betas.random.mean = mean(betas(1,:));
    session.rois(roi).betas.random.std = std(betas(1,:));
    session.rois(roi).betas.random.sem = cppi_sem(betas(1,:));
    

    session.rois(roi).betas.sequence.raw = betas(2,:);
    session.rois(roi).betas.sequence.sum = sum(betas(2,:));
    session.rois(roi).betas.sequence.mean = mean(betas(2,:));
    session.rois(roi).betas.sequence.std = std(betas(2,:));
    session.rois(roi).betas.sequence.sem = cppi_sem(betas(2,:));
    
end


%get betas


end


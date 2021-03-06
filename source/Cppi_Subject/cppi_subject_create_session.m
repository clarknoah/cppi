function [session] = cppi_subject_create_session(session)
%CPPI_SUBJECT_CREATE_SESSION Handles session generation in Cppi_Subject
%constructor.
%   Detailed explanation goes here


session.task_design = cppi_extract_task_design(session.SPM);
    for x=1:length(session.seeds)
        session.seeds(x).ppi_design = cppi_extract_ppi_design( ...
                    session.task_design, ...
                    session.seeds(x).eigen);
    end


for roi=1:length(session.rois)
    session.rois(roi).seeds = [];
    for x=1:length(session.seeds)
        session.rois(roi).seeds(x).name = session.seeds(x).name;
        session.rois(roi).seeds(x).betas = struct('random',struct(),'sequence',struct());
 %{ 
    #TEST-START This code has been injected to evaluate if beta values are
    correct
        
 %} 
        
        seed = session.seeds(x).seeds_timeseries;
        seed = [seed seed seed seed seed];
        betas = cppi_extract_betas(session.seeds(x).ppi_design, seed);
 %{ 
    #TEST-END 
        
        (Original Code that will be placed back)
         % betas = cppi_extract_betas(session.seeds(x).ppi_design, session.rois(roi).timeseries);
        
 %} 
      
        
        session.rois(roi).seeds(x).betas.raw =  betas;
        session.rois(roi).seeds(x).betas.random.raw = betas(1,:);
        session.rois(roi).seeds(x).betas.random.sum = sum(betas(1,:));
        session.rois(roi).seeds(x).betas.random.mean = mean(betas(1,:));
        session.rois(roi).seeds(x).betas.random.std = std(betas(1,:));
        session.rois(roi).seeds(x).betas.random.sem = cppi_sem(betas(1,:));


        session.rois(roi).seeds(x).betas.sequence.raw = betas(2,:);
        session.rois(roi).seeds(x).betas.sequence.sum = sum(betas(2,:));
        session.rois(roi).seeds(x).betas.sequence.mean = mean(betas(2,:));
        session.rois(roi).seeds(x).betas.sequence.std = std(betas(2,:));
        session.rois(roi).seeds(x).betas.sequence.sem = cppi_sem(betas(2,:));     

    end
end


%get betas


end

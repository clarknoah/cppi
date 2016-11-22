function [cppi] = cppi_align_labels(config,payload,subject,session)
%CPPI_ALIGN_LABELS Summary of this function goes here
%   Detailed explanation goes here
    cppi = Cppi_Manipulator(config, payload);
    %load all files
    disp('Loading Files to payload...');
    payload = cppi_align_load_files(cppi,payload,subject,session);
    
    %get coords for seeds
    disp('Extracting Seed Coords...');
    payload = cppi_assign_seed_coords(payload);
    
    %crop labels with seeds
    disp('Cropping labels...');
    [cppi,payload] = cppi_align_bulk_crop(cppi,payload,subject,session);
    
    cppi = Cppi_Manipulator(config,payload);
    cppi_align_bulk_overlap(cppi,payload,subject,session);
    %coreg ROIs to EPI
    [cppi,payload] = cppi_align_bulk_coreg(cppi,payload,subject,session);
    
    %Remove overlap by priority
    cppi = Cppi_Manipulator(config,payload);
    
    cppi_align_bulk_overlap(cppi,payload,subject,session);

    cppi = Cppi_Manipulator(config,payload);
    payload = cppi.save_json(payload.paths.payload_path,'payload_a.json');
    cppi = Cppi_Manipulator(config,payload);
end


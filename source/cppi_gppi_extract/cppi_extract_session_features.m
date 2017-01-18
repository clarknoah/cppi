function [session,payload] = cppi_extract_session_features(session_path,subs_dir,subject_name,config,payload,session_point)
%CPPI_EXTRACT_SESSION_FEATURES Gets data for Cppi_Subject
%   This function accepts the root path of a subject's folder and uses that
%   to extract that various data points required for the Cppi_Subject
%   object. 
%
%   ---- Arguments ----
%   session_path:	Contains the full path to the subjects individual scan
%                   session.
%
disp('********************');
disp(['Starting ' subject_name ' session ' session_point]);
session = struct();
session.SPM = cppi_load([session_path 'SvR_GLM/SPM.mat'],'SPM');

%Changing SPM path so that it matches which source of computer running code
for x=1:length(session.SPM.xY.VY)
session.SPM.xY.VY(x).fname = [session_path 'Seq_v_Rand_Block_01/scraurSeq_v_Rand_Block_01.nii'];
end

%processed_rois =  cppi_align_roi_to_epi(rois);
%m1 = struct('name','Primary Motor Cortex','path',[session_path 'rois/r_lhBA4_cropped.nii']);
%s1 = struct('name','Primary Somatosensory Cortex','path',[session_path,'rois/r_lhBA123_cropped.nii']);

    %Pipeline evaluates if it has received the first or second session, if
    %the session is the first one, then it will go through the
    %cppi_align_labels function in order to determine whether or 
if(strcmp(session_point,'_1'))
    
    cppi = cppi_align_labels(config,payload,subject_name,session_point);
    
    payload = cppi.payload;
    %payload = loadjson('/home/noah/Development/cppi/data/payload_a.json');
    %cppi = Cppi_Manipulator(config,payload);
    
    processed_rois = cppi.retrieve_rois(subject_name,session_point);
else
    cppi = Cppi_Manipulator(config,payload);
    processed_rois = cppi.retrieve_rois(subject_name,'_1');
end


seeds = cppi.retrieve_seeds(subject_name,'_1');

session.seeds = [];
for x=1:length(seeds)
    seed = seeds(x);
 session.seeds(x).name = seed.name;   
[session.seeds(x).seeds_timeseries, session.seeds(x).seed_xyz] = cppi_extract_seed_voxel( ...
                            session.SPM.xY.VY, ...
                            seed.searchlight_obj, ...
                            seed.obj);

Vmask = spm_vol([session_path 'SvR_GLM/mask.hdr']);                       
                        
[seed_sphere] = cppi_extract_seed_sphere( ...
                            session.seeds(x).seed_xyz, ...
                            3, ...
                            Vmask, ...
                            session.SPM.xY.VY);
                        
                        
session.seeds(x).eigen = cppi_extract_eigen_vector(seed_sphere);    
end


session.rois = cppi_extract_roi_timeseries(session.SPM.xY.VY,processed_rois);

   disp(['Completed ' subject_name ' session ' session_point]);

end


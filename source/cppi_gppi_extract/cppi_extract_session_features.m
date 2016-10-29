function [session] = cppi_extract_session_features(session_path)
%CPPI_EXTRACT_SESSION_FEATURES Gets data for Cppi_Subject
%   This function accepts the root path of a subject's folder and uses that
%   to extract that various data points required for the Cppi_Subject
%   object. 
%
%   ---- Arguments ----
%   session_path:	Contains the full path to the subjects individual scan
%                   session.
%


session = struct();
session.SPM = cppi_load([session_path 'SvR_GLM/SPM.mat'],'SPM');

%Changing SPM path so that it matches which source of computer running code
for x=1:length(session.SPM.xY.VY)
session.SPM.xY.VY(x).fname = [session_path 'Seq_v_Rand_Block_01/scraurSeq_v_Rand_Block_01.nii']
end

%processed_rois =  cppi_align_roi_to_epi(rois);
m1 = struct('name','Primary Motor Cortex','path',[session_path 'rois/r_lhBA4_cropped.nii']);
s1 = struct('name','Primary Somatosensory Cortex','path',[session_path,'rois/r_lhBA123_cropped.nii']);
processed_rois = [m1, s1];

cd([session_path 'perm_test/']);

%Loading Variables required to create Seed Voxel
hand_knob = load_untouch_nii([session_path 'perm_test/hand_knob_lh.nii']);
preH = [session_path 'perm_test/' 'perm_searchlight_output_H_pre.img'];
preH = load_untouch_nii(preH);

[session.seed_timeseries, session.seed_xyz] = cppi_extract_seed_voxel( ...
                            session.SPM.xY.VY, ...
                            preH, ...
                            hand_knob);

Vmask = spm_vol([session_path 'SvR_GLM/mask.hdr']);                       
                        
[seed_sphere] = cppi_extract_seed_sphere( ...
                            session.seed_xyz, ...
                            3, ...
                            Vmask, ...
                            session.SPM.xY.VY);
                        
                        
session.eigen = cppi_extract_eigen_vector(seed_sphere);

session.rois = cppi_extract_roi_timeseries(session.SPM.xY.VY,processed_rois);

   

end


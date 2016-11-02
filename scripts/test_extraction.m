%Test of Extraction Process
addpath('~/Documents/MATLAB/spm12');
addpath('~/Documents/MATLAB/NIfTI_20140122')

subject_root_directory = '/Volumes/coax_lab/patrick_project/subjects/subjects/';

subjects = {'0006', '0012', '0192', '0273', '0490', '0491', '0464', ...
        '0494', '0495', '0269', '0549', '0550', '0557', '0558', '0559', ...
        '0604', '0605', '0627'};
    
subjects = [struct('name','0006','group','sequence'); ...
    struct('name','0012','group','sequence'); ...
    struct('name','0192','group','sequence'); ... 
    struct('name','0273','group','sequence'); ... 
    struct('name','0490','group','sequence'); ... 
    struct('name','0491','group','sequence'); ... 
    struct('name','0557','group','sequence'); ... 
    struct('name','0558','group','sequence'); ... 
    struct('name','0559','group','sequence'); ... 
    struct('name','0269','group','control'); ... 
    struct('name','0494','group','control'); ... 
    struct('name','0495','group','control'); ... 
    struct('name','0549','group','control'); ... 
    struct('name','0550','group','control'); ... 
    struct('name','0604','group','control'); ... 
    struct('name','0605','group','control'); ... 
    struct('name','0464','group','control'); ... 
    struct('name','0627','group','control')];



test_dir = '/Volumes/coax_lab/patrick_project/subjects/subjects/';

test_sub_dir = '/Volumes/coax_lab/patrick_project/subjects/subjects/0006_1/';
test_sub_dir_p = '/Volumes/coax_lab/patrick_project/subjects/subjects/0006_2/';

sub_perm = '/Volumes/coax_lab/patrick_project/subjects/subjects/0006_1/perm_test/';

sub_svr = '/Volumes/coax_lab/patrick_project/subjects/subjects/0006_1/SvR_GLM/';

SPM = cppi_load([sub_svr 'SPM.mat'],'SPM');

for x=1:length(SPM.xY.VY)
    SPM.xY.VY(x).fname = [test_sub_dir 'Seq_v_Rand_Block_01/scraurSeq_v_Rand_Block_01.nii'];
end

%subject_aligned =  cppi_align_roi_to_epi();

cd(sub_perm);

%Loading Variables required to create Seed Voxel
hand_knob = load_untouch_nii([test_sub_dir 'perm_test/hand_knob_lh.nii']);
preH = [test_sub_dir 'perm_test/' 'perm_searchlight_output_H_pre.img'];
preH = load_untouch_nii(preH);

[seed_voxel, seed_xyz] = cppi_extract_seed_voxel( ...
                            SPM.xY.VY, ...
                            preH, ...
                            hand_knob);

Vmask = spm_vol([test_sub_dir 'SvR_GLM/mask.hdr']);                       
                        
[seed_sphere] = cppi_extract_seed_sphere( ...
                            seed_xyz, ...
                            3, ...
                            Vmask, ...
                            SPM.xY.VY);
                        
session.eigen = cppi_extract_eigen_vector(seed_sphere);

m1 = struct('name','Primary Motor Cortex','path',[test_sub_dir 'rois/r_lhBA4_cropped.nii']);
s1 = struct('name','Primary Somatosensory Cortex','path',[test_sub_dir,'rois/r_lhBA123_cropped.nii']);
processed_rois = [m1, s1];


roi_timeseries = cppi_extract_roi_timeseries(SPM.xY.VY,processed_rois);


pre_session = cppi_extract_session_features(test_sub_dir);
post_session = cppi_extract_session_features(test_sub_dir_p);
sub1 = Cppi_Subject('0006','sequence');


                        
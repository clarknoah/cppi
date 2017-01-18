
init;
cppi = Cppi_Manipulator(1,1);
%Setting up the paths neccessary to automate comparing between nifti files
bk_root = '/home/noah/coax_external/backup/patrick_project';
bk_fs = [bk_root '/freesurfer/subjects/subjects/%s/'];
bk_subs = [bk_root 'subjects/subjects/%s/'];

%18Jan17LL of code added to cppi_debug_alignment, I am trying to setup the code so that I can easily input three different variables so I don’t have to constantly replace all of them throughout the script. 

m_root = '/home/noah/coax_external/patrick_project';
m_fs = [m_root '/freesurfer/subjects/subjects/%s/%s/%s'];
m_subs = [m_root 'subjects/subjects/%s/%s/%s'];

subject = '0006_1';

(sprintf('/data/r2d4/subjects/%s_1/perm_test/hand_knob_lh.nii', sub)
%comparing original dimensions of ROI files from perm_test

bk_perm_test_m1 = load_untouch_nii( ...
    sprinsf[bk_subs '0006_1/perm_test_'] ...
    );
bk_perm_test_s1 = 
bk_coreg_m1
bk_coreg_s1

m_pt_m1 = 
m_pt_s1 = 
m_coreg_m1 = 
m_coreg_s1 = 
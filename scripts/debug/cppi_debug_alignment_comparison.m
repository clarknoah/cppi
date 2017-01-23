function [ output_args ] = cppi_debug_alignment_comparison(sub1,hemi,region_name,region_title)
%CPPI_DEBUG_ALIGNMENT_COMPARISON Summary of this function goes here
%   Detailed explanation goes here

init;
cppi = Cppi_Manipulator(1,1);
%Setting up the paths neccessary to automate comparing between nifti files
bk_root = '/home/noah/coax_external/backup/patrick_project';
bk_fs = [bk_root '/freesurfer/subjects/subjects/%s/'];
bk_subs = [bk_root '/subjects/subjects/%s/%s/%s'];

%18Jan17LL of code added to cppi_debug_alignment, I am trying to setup the code so that I can easily input three different variables so I don’t have to constantly replace all of them throughout the script. 

m_root = '/home/noah/coax_external/patrick_project';
m_fs = [m_root '/freesurfer/subjects/subjects/%s/%s/%s'];
m_subs = [m_root '/subjects/subjects/%s/%s/%s'];

%sub1 = '0006_1';
%sub2 = '0006_1';
pt = 'perm_test';
roi = 'rois';

%ROIS Filenames (region)-(lateralization)-(status:org=original,cr=cropped,co=coreg)
region_lh_org = [hemi region_name '.nii'];
region_lh_cr = [hemi region_name '_cropped.nii'];
region_lh_co = ['r_' hemi region_name '_cropped.nii'];

%Seeds


%comparing original dimensions of ROI files from perm_test


%Original region Files
bk_region_lh_org = load_untouch_nii(sprintf(...
    bk_subs,sub1,pt,region_lh_org...
    ));
bk_region_lh_cr = load_untouch_nii(sprintf(...
    bk_subs,sub1,roi,region_lh_cr...
    ));
bk_region_lh_co = load_untouch_nii(sprintf(...
    bk_subs,sub1,roi,region_lh_co...
    ));

    
%Manipulated region Files
m_region_lh_org = load_untouch_nii(sprintf(...
    m_subs,sub1,pt,region_lh_org...
    ));
m_region_lh_cr =  load_untouch_nii(sprintf(...
    m_subs,sub1,roi,region_lh_cr...
    ));
m_region_lh_co = load_untouch_nii(sprintf(...
    m_subs,sub1,roi,region_lh_co...
    ));

%region Comparison
cppi.quick_display_overlap(bk_region_lh_org,m_region_lh_org,['BK vs Manipulated: ' region_title ' original)']);
cppi.compare_nii_mask(bk_region_lh_org,m_region_lh_org);

cppi.quick_display_overlap(bk_region_lh_cr,m_region_lh_cr,['BK vs Manipulated: ' region_title ' cropped)']);
cppi.compare_nii_mask(bk_region_lh_cr,m_region_lh_cr);

cppi.quick_display_overlap(bk_region_lh_co,m_region_lh_co,['BK vs Manipulated: ' region_title ' coreg)']);
cppi.compare_nii_mask(bk_region_lh_co,m_region_lh_co);
end
%Test of Extraction Process
addpath('~/Documents/MATLAB/spm12');
addpath('~/Documents/MATLAB/NIfTI_20140122')

subs_root_dir = '/Volumes/coax_lab/patrick_project/subjects/subjects/';

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

tools = cppi_batch_subjects( ...
                        'rois path', ...
                        subs_root_dir, ...
                        subjects, ...
                        'dd');
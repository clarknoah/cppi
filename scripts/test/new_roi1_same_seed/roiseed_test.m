addpath('~/Development/cppi');
addpath('~/Documents/MATLAB/spm12');
addpath('~/Documents/MATLAB/NIfTI_20140122');
addpath('~/Documents/MATLAB/jsonlab-1.5');

here = pwd;
config = loadjson('config/config.json');
payload = loadjson('data/payload0.json');
%config.subjects = [config.subjects(1)];         
cd(config.paths.cppi_root);
%config.subjects = [config.subjects(2)];  
tools = cppi_batch_subjects(config,payload,'ba6_roi_with_original_seeds');
cd('/home/noah/Development/cppi');
[betas,sem] = tools.extract_roi_beta_comparison('Broadmann 6 (lh)','Broadmann 3 (lh)','Hand Knob (lh)');
cppi_comparison_graph(betas,sem,'BA6','BA3');
disp('function has completed');
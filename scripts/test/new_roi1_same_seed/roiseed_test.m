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
tools = cppi_batch_subjects(config,payload,'ba6_roi_with_original_seeds',0);
cd('/home/noah/Development/cppi');
[betas,sem] = tools.extract_roi_beta_comparison('Primary Somatosensory Cortex (lh)','Primary Motor Cortex (lh)','Hand Knob (lh)');
cppi_comparison_graph(betas,sem,'s1','m1');
disp('function has completed');
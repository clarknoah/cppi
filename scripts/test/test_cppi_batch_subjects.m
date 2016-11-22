%Test of Extraction Process
addpath('~/Documents/MATLAB/spm12');
addpath('~/Documents/MATLAB/NIfTI_20140122');
addpath('~/Documents/MATLAB/jsonlab');

here = pwd;
config = loadjson('config/config.json');
payload = loadjson('data/payload.json');
%config.subjects = [config.subjects(1)];                  
tools = cppi_batch_subjects(config,payload);
cd('/home/clarknoah/Development/cppi');
[betas,sem] = tools.extract_roi_beta_comparison('Primary Motor Cortex (lh)','Primary Somatosensory Cortex (lh)','Hand Knob (lh)');
cppi_comparison_graph(betas,sem);
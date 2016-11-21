%Test of Extraction Process
addpath('~/Documents/MATLAB/spm12');
addpath('~/Documents/MATLAB/NIfTI_20140122');
addpath('~/Documents/MATLAB/jsonlab');

here = pwd;
config = loadjson('config/config.json');
payload = loadjson('data/payload.json');
%config.subjects = [config.subjects(1),config.subjects(2),config.subjects(3)];                  
tools = cppi_batch_subjects(config,payload);
cd('/home/clarknoah/Development/cppi');
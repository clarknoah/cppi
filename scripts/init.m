
addpath('~/Documents/MATLAB/spm12');
addpath('~/Documents/MATLAB/NIfTI_20140122');
addpath('~/Documents/MATLAB/jsonlab-1.5');

here = pwd;
config = loadjson('config/config.json');
payload = loadjson('data/payload.json');
%config.subjects = [config.subjects(1)];         
cd('/home/noah/Development/cppi');
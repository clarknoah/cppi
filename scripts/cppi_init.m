% This init script loads required Matlab tools, and puts the config &
% payload objects in memory so they can be used.
addpath('~/Development/cppi');
addpath('~/Documents/MATLAB/spm12');
addpath('~/Documents/MATLAB/NIfTI_20140122');
addpath('~/Documents/MATLAB/jsonlab-1.5');

here = pwd;
config = loadjson('config/config.json');
payload = loadjson('data/payload.json');
%config.subjects = [config.subjects(1)];         
cd(config.paths.cppi_root);
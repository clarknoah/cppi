function [config] = cppi_config()
%23Jan2017 TODO: Probably delete this file, init script is likely better,
%TBD

%CPPI_CONFIG Cofigures environment variables for matlab
%   Detailed explanation goes here
path = '/home/noah/Development/cppi/config/config.json';
config = loadjson(path);

end


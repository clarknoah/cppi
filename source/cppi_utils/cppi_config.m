function [config] = cppi_config()
%CPPI_CONFIG Cofigures environment variables for matlab
%   Detailed explanation goes here
path = '/home/clarknoah/Development/cppi/config/config.json';
config = loadjson(path);

end


function [clean_object] = cppi_load(full_path, object_name)
%CPPI_LOAD: This function loads an object and handles removing
%   the higher order variable name.

    file = load(full_path);
    clean_object = file.([object_name]);

end


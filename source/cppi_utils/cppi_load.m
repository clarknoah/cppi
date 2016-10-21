function [clean_object] = cppi_load(full_path, object_name)
%CPPI_LOAD: Loads and trims higher level object variable
%   the higher order variable name.

    file = load(full_path);
    clean_object = file.([object_name]);

end


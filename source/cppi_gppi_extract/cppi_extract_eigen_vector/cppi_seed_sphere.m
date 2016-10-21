function sphere_analysis(path)
%sphere_analysis goes through peak_data
% dim        - Radius of sphere
%
% path       - Absolute path to subjects directory

dim = 3;

folders = dir(path);
    for x=1:length(folders)
    
    length(folders)
        if (folders(x).isdir == 1) && (folders(x).name(1)=='0')

            Vdata_pre = load([path folders(x).name '/SvR_GLM/SPM.mat']);
            Vdata = Vdata_pre.SPM.xY.VY;
            Vmask = spm_vol([path folders(x).name '/SvR_GLM/mask.hdr']);

            coord = load([path folders(x).name '/perm_test/data.mat']);

            
            y_data = light_grab(coord.peak_xyz, dim, Vmask, Vdata);
            save([path folders(x).name '/SvR_GLM/sphere.mat'],'y_data');

        end
    end
end

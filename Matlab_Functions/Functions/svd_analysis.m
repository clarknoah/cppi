function  = svd_analysis(path)
%SVD_Analysis Summary of this function goes here
%   This function takes the ppiAnalysis folder and
%  runs the correlation function on the neccessary data
% and outputs the results of the correlations into each subject's
% directory
    
%Console must be in ppiAnalysis directory

folders = dir(path);
allData = struct();
    for x=1:length(folders)
        if (folders(x).isdir == 1) && (folders(x).name(1)=='0')

            pr = load([path folders(x).name '/SvR_GLM/sphere.mat']);
            [U,S,V] = svd(pr.y_data);
            % create sigma value from Sphere data
            
            phy_pre = load([path folders(x).name '/SvR_GLM/SPM.mat']);
            % load SPM.xX.xKXs.X (=dzn_mtx)
            phy = phy_pre.SPM.xX.xKXs.X
            phy_ran = phy(:,1);
            phy_seq = phy(:,2);
            ppi_ran = phy_ran*S;
            ppi_seq = phy_seq*S;
            % create PPI1 from ran task voxel (ppi1=S(:,1)*dzn_mtx(:,1)'
            % create PPI1 from seq task voxel (ppi1=S(:,1)*dzn_mtx(:,2)'
            % create x' matrix 
           
            
        end
    end
    save(finalName,'allData');
end


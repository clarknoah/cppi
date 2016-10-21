function [allData] = bulk_analysis(finalName)
%BULK_ANALYSIS Summary of this function goes here
%   This function takes the ppiAnalysis folder and
%  runs the correlation function on the neccessary data
% and outputs the results of the correlations into each subject's
% directory
    
%Console must be in ppiAnalysis directory

folders = dir;
allData = struct();
    for x=1:length(folders)
        if (folders(x).isdir == 1) && (folders(x).name(1)=='0')
            pr = load([folders(x).name '/data.mat'])
            SPM = load([folders(x).name '/SvR_GLM/SPM.mat'])
            analyzer = ppiAnalyzer(SPM.SPM, pr.roi_data,pr.peak_data);
            corr = analyzer.corr;
            save([folders(x).name '/test_results.mat'],'corr');
            allData.(['s' folders(x).name]) = corr;
        end
    end
    save(finalName,'allData');

end


function [subject_betas,pre_post_beta, avg_beta, vox_betas, sub_ppi] = bulk_betas(path,phys_key,roi_key)
%BULK_BETAS is the master function that will take rio_data, peak_data,
%   and each subject SPM file and do the analysis that Tim requested.
%   
%   subject_betas:  This object contains each subject's pre/post betas. 
%       Each subject vector will be a 9 x <number of roi voxels>
%       Row 1: Random
%       Row 2: Sequence
%       Row 3-9: Movement/Nuisance regressors
%
%   pre_post_betas: This vector contains three columns. The first column
%       is the sum of the pre(sequence) betas for that particular subject
%       (by row). The second column the sum of the post(sequence) betas for
%       that particular subject. 
%       the third column is the difference between the sum of that
%       subject's betas in the pre(sequence) and the
%       post(sequence).
%        
%   pre_avg: vector contains the mean of the betas for that particular 
%       subject. The first column is for pre-random, the second column is for
%       pre-sequence.
%
%   post_avg: vector contains the mean of the betas for that particular 
%       subject. The first column is for post-random, the second column is for
%       post-sequence.
%
%

folders = dir(path);
subject_betas = struct();
subject_ppi = struct();
avg_beta = [];
pre_post_beta = [];

pre_beta = [];
post_beta = [];
vox_betas = struct();
eigens =  load([path 'eigens.mat']);
eigens = eigens.eigens;
subs = load([path 'subs.mat']);
subs = subs.subs;
counter = 1;
    for x=1:length(folders)
        if (folders(x).isdir == 1) && (folders(x).name(1)=='0')
            %load design_mtx, y_data, phys, roi
            disp(folders(x).name);
            
            y_data = load([path folders(x).name '/SvR_GLM/sphere.mat']);
            y_data = y_data.y_data;
            
            design_mtx = load([path folders(x).name '/SvR_GLM/SPM.mat']);
            design_mtx = design_mtx.SPM.xX.xKXs.X;
            
            fmri_data = load([path folders(x).name '/perm_test/data.mat']);
                        

            if strcmp(phys_key,'voxel')
                phys = fmri_data.peak_data;    
            elseif strcmp(phys_key,'eigen')
                phys = determine_subject(folders(x).name, eigens, subs);
            else
            end

            peak_size = size(phys);
            if peak_size(2) > 1
                phys = phys(:,1);
            end
            roi = fmri_data.([roi_key '_roi_data']);

            [betas, ppi_mtx] = glm_analysis(design_mtx, y_data, phys,roi);
             save([path folders(x).name '/SvR_GLM/betas.mat'],'betas');
             subject_betas.(['s' folders(x).name]) = betas;
             sub_ppi.(['s' folders(x).name '_ppi_mtx']) = ppi_mtx;
            
             comparison_voxels = betas;
             if folders(x).name(6)=='1'
                   pre_beta = comparison_voxels;
                   % The first column holds the sum of the
                   % pre-random, the second column holds of the sum of 
                   % pre-sequence
                   pre_post_beta(counter,1) = sum(betas(1,:));
                   pre_post_beta(counter,2) = sum(betas(2,:));
                   pre_post_beta(counter,6) = sem(betas(1,:));
                   pre_post_beta(counter,7) = sem(betas(2,:));
                   
                   
                  %Random Average
                  avg_beta(counter,1) = mean(betas(1,:));
                  
                  %Random STD
                  avg_beta(counter,6) = sem(betas(1,:));
                  
                  %Sequence Average
                   avg_beta(counter,2) = mean(betas(2,:));
                   avg_beta(counter,7) = sem(betas(2,:));
                    
             elseif  folders(x).name(6)=='2'
                   post_beta = comparison_voxels;
                   vox_betas.(['s' folders(x).name]) = ...
                       rank_voxels(pre_beta,post_beta);
                   
                   % The third column holds the sum of the post-random
                   % betas
                   % Fourth column holds sum of post-sequence betas
                   pre_post_beta(counter,3) = sum(betas(1,:));
                   pre_post_beta(counter,4) = sum(betas(2,:));
                   pre_post_beta(counter,8) = sem(betas(1,:));
                   pre_post_beta(counter,9) = sem(betas(2,:));
                   %Fifth column is the subject ID
                   pre_post_beta(counter,5) = str2num(['1' ...
                       folders(x).name(1:4)])
                   %Random Average
                   avg_beta(counter,3) = mean(betas(1,:));
                   avg_beta(counter,8) = sem(betas(1,:));
                   %Sequence Average
                   avg_beta(counter,4) = mean(betas(2,:));
                   avg_beta(counter,9) = sem(betas(2,:));
                   avg_beta(counter,5) = str2num(['1' ...
                       folders(x).name(1:4)]);
                   
                   
                   %COLUMN 10 takes the mean of the (post-betas
                   % subtracted from the pre-betas) for random
                   avg_beta(counter,10) = mean((post_beta(1,:) ... 
                       - pre_beta(1,:)));
                   
                   %COLUMN 11 takes the SEM of the (post-betas
                   % subtracted from the pre-betas) for random
                   avg_beta(counter,11) = sem((post_beta(1,:) ... 
                       -pre_beta(1,:)));
                   
                   %COLUMN 12 takes the mean of the (post-betas
                   % subtracted from the pre-betas) for sequence
                   avg_beta(counter,12) = mean((post_beta(2,:) ... 
                       -pre_beta(2,:)));
                   
                   %COLUMN 13 takes the SEM of the (post-betas
                   % subtracted from the pre-betas) for sequence
                   avg_beta(counter,13) = sem((post_beta(2,:) ... 
                       -pre_beta(2,:)));
                   
                   % The third column shows overall difference
                   % between post and pre. 
                   %pre_post_beta(counter,4) = pre_post_beta(counter,2) ...
                   %    - pre_post_beta(counter,1);
                   counter = counter + 1;   
             end
        end
    end
    save([path 'all_betas'],'subject_betas');
    save([path 'compare_betas'],'pre_post_beta');

end


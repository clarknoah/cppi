function [beta_comp] = rank_voxels_abs(pre_beta, post_beta)
%RANK_VOXELS this function should take an input of the GLM values
%   of each individual voxel and shit fuck I don't even know what 
%    I'm doing with my life. I should've stayed as a consultant making
%   bookoo bucks. I would've been still dealing with my existential crisis
%   probably crying my eyes out. But as the dutch say, it's better to 
%   cry in a Mercedes than on a bicycle.

%   {subject:{
%           random:{
%               row1: Beta from pre-random
%               row2: Betas from post-random
%               row3: Change
%   
%           sequence:{
%                row1: Beta from pre
%                row2: Betas from post
%                row3: Change
%
%
%
%
%
%
beta_comp = struct();
beta_comp.random = [];
beta_comp.sequence = [];
beta_comp.comparison = [];

beta_comp.random(1,:) = pre_beta(1,:);
beta_comp.random(2,:) = post_beta(1,:);

beta_comp.sequence(1,:) = pre_beta(2,:);
beta_comp.sequence(2,:) = post_beta(2,:);

for x=1:length(pre_beta(1,:))
    beta_comp.random(3,x) = abs(beta_comp.random(2,x)) - abs(beta_comp.random(1,x));
    beta_comp.random(4,x) = x;
end

for x=1:length(pre_beta(1,:))
    beta_comp.sequence(3,x) = abs(beta_comp.sequence(2,x)) - abs(beta_comp.sequence(1,x));
    beta_comp.sequence(4,x) = x;
end

beta_comp.comparison = abs(beta_comp.sequence(3,:)) - abs(beta_comp.random(3,:));
beta_comp.comparison(2,:) = beta_comp.sequence(4,:);   
    
    %   End State Expectations:
    %   Struct object for each subject that will 
    

end


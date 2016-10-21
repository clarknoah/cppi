function [eigens] = determine_subject(fullSubName, eigenvectors, subs)
%DETERMINE_SUBJECT Determines which subject eigen to use
%   Detailed explanation goes here
        
    %iterate through subs
    for x=1:length(subs)
        tempName = subs{x};
        
        %find sub that matches fullSubName
        if fullSubName(1:4) == tempName(1:4)
            disp(['Selecting eigenvector for ' fullSubName]);
            %Checks for pre data folder
            if fullSubName(6) == '1'
                eigens = eigenvectors(:,x,1);
            %Checkes for post data folder
            elseif fullSubName(6) == '2'
                eigens = eigenvectors(:,x,2);
            else
            end
        else
           
        end
        
            
    end
end


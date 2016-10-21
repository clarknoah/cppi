function [meaned] = demeaned(meaned)
%DEMEANED function takes a single column vector and returns
%   a demeaned vector. If a multi-column vector is provided,
%   it will output that multi-column vector with each column vector
%   being demeaned by its own column.
        if length(size(meaned)) > 1
                for x=1:length(meaned(1,:))
                    meaned_avg = mean(meaned(:,x));
                    for y=1:length(meaned(:,x))
                        meaned(y,x) = meaned(y,x)- meaned_avg;
                    end
                end
        else
            meaned_avg = mean(meaned);
                for x = 1:length(meaned)
                meaned(x) = meaned(x) - meaned_avg;
                end 
        end
end


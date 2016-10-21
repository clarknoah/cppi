function [h] = group_error_bar(model_series,model_error,xticker,yticker,lKey,bTitle)
%GROUP_ERROR_BAR Summary of this function goes here
%   Detailed explanation goes here

%model_series = [10 40 80; 20 50 90; 30 60 100];
%model_error = [1 4 8; 2 5 9; 3 6 10];
h = bar(model_series);
set(h,'BarWidth',1);    % The bars will now touch each other
set(gca,'YGrid','on')
set(gca,'GridLineStyle','-')
set(gca,'XTicklabel',xticker)
set(get(gca,'YLabel'),'String',yticker)
 title(bTitle);
hold on;
numgroups = size(model_series, 1); 
numbars = size(model_series, 2); 
groupwidth = min(0.8, numbars/(numbars+1.5));
for i = 1:numbars
      % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
      x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);  % Aligning error bar with individual bar
      errorbar(x, model_series(:,i), model_error(:,i), 'k', 'linestyle', 'none');
end
end


function [ output_args ] = barplot_comp(funplot,funplot_std)
%BARPLOT_COMP Summary of this function goes here
%   Detailed explanation goes here

% funplot = [barplot_m1.seq;barplot_m1.ran;barplot_s1.seq;barplot_s1.ran];
%funplot_std=[barplot_m1.seq_std,barplot_m1.ran_std,barplot_s1.seq_std,barplot_s1.ran_std];
 
    
 figure

h = bar(funplot);
 set(gca,'XLim',[0 5]);
 set(gca,'XTick',[1:4]);
 ylim([0,0.4]);
 ylabel('Mean of PPI correlation');
 %set(gca,'XTickLabelRotation',45);
 %set(gca,'XTickLabels',{'Control-Pre', 'Sequence-Pre', 'Control-Post', 'Sequence-Post'});
 set(gca,'XTickLabels',{'M1-Sequence|M1-Random|S1-Sequence|S1-Random'});
 %title('Sequence Data (M1 and S1 PPI correlation)');
h(1).FaceColor = [0.501 0.0 0.0];
h(2).FaceColor = [0 0 0.8039];
h(3).FaceColor = [1 0.388 0.278];
h(4).FaceColor = [0 0.749 1];
lh = legend('Control Group (Pre)','Sequence Group (Pre)',...
'Control Group (Post)','Sequence Group (Post)');
 hold
%errorbar(funplot(1,:),funplot_std(1,:),'black.');
error = 1;
if error == 1
    set(h,'BarWidth',1);    % The bars will now touch each other
    set(gca,'YGrid','on')
    set(gca,'GridLineStyle','-')
    %set(gca,'XTicklabel','Modelo1|Modelo2|Modelo3')
    set(get(gca,'YLabel'),'String','U')
   % lh = legend('Serie1','Serie2','Serie3');
    set(lh,'Location','BestOutside','Orientation','horizontal')
    hold on;
    numgroups = size(funplot, 1); 
    numbars = size(funplot, 2); 
    groupwidth = min(0.8, numbars/(numbars+1.5));
    for i = 1:numbars
          % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
          x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);  % Aligning error bar with individual bar
         disp(x);
          errorbar(x, funplot(:,i), funplot_std(:,i), 'k', 'linestyle', 'none');
    end
end

end


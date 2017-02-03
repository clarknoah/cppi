function [difference] = cppi_comparison_graph(betas,sem,name1, name2)
%CPPI_GENERATE_DIFFERENCE Returns the difference of two values
m1_differences = betas(:,1).';
m1_sem = sem(:,1).';
s1_differences = betas(:,2).';
s1_sem = sem(:,2).';

xTicker = {'Training Group - Sequence Condition',...
    'Control Group - Sequence Condition',...
    'Training Group - Random Condition'...
    'Control Group - Random Condition'};
%yTicker = 'Mean Beta Value';
yTicker = 'Connectivity';

figure;
subplot(1,2,1);
mb = bar(m1_differences.','g');
hold;
errorbar(m1_differences, m1_sem.','black.');
set(gca,'XTicklabel',xTicker);
set(get(gca,'YLabel'),'String',yTicker);
set(gca,'XTickLabelRotation',45);
title({'M1: Mean Value of the Post minus Pre Difference','(With SEM)'});

subplot(1,2,2);
sb = bar(s1_differences,'g');
hold;
errorbar(s1_differences, s1_sem.','black.');
set(gca,'XTicklabel',xTicker);
set(gca,'XTickLabelRotation',45);
title({'S1: Mean Value of the Post minus Pre Difference','(With SEM)'});


figure;
lKey = xTicker;
xticker = 'M1 - S1';
bTitle = {'Mean Value of the Post minus Pre ROI Differences','(With SEM)'};
h = group_error_bar([m1_differences;s1_differences] ...
    ,[m1_sem;s1_sem],xticker,yTicker,lKey,bTitle);
set(gca,'XTicklabel',{name1,name2})
h(1).FaceColor = 'g';
lh = legend(lKey);
set(lh,'Location','BestOutside','Orientation','horizontal');
end

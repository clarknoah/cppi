pather = '/Users/clarknoah/Development/Coax/Patrick_Project/ppi_test/';
load('/Users/clarknoah/Development/Coax/Patrick_Project/ppi_test/seq_ran_subjects.mat');
load('/Users/clarknoah/Development/Coax/Patrick_Project/ppi_test/eigens.mat');

[m1_subject_betas,m1_pre_post_beta, m1_avg_beta, m1_vox_betas, ...
    m1_sub_ppi] = ... 
    bulk_betas(pather,'eigen', 'm1' );

[s1_subject_betas,s1_pre_post_beta, s1_avg_beta, s1_vox_betas, ...
    s1_sub_ppi] = ... 
    bulk_betas(pather,'eigen', 's1' );

[m1_averages, m1_bar_plot] = group_mean_std(m1_avg_beta,seq_ran_subjects,1);
[s1_averages, s1_bar_plot] = group_mean_std(s1_avg_beta,seq_ran_subjects,1);

m1_differences = [m1_bar_plot.seq_diff(1,2) m1_bar_plot.seq_diff(1,1) ...
    m1_bar_plot.ran_diff(1,2) m1_bar_plot.ran_diff(1,1)];
m1_sem = [m1_bar_plot.seq_diff_std(1,2) m1_bar_plot.seq_diff_std(1,1) ...
    m1_bar_plot.ran_diff_std(1,2) m1_bar_plot.ran_diff_std(1,1)];

s1_differences = [s1_bar_plot.seq_diff(1,2) s1_bar_plot.seq_diff(1,1) ...
    s1_bar_plot.ran_diff(1,2) s1_bar_plot.ran_diff(1,1)];
s1_sem = [s1_bar_plot.seq_diff_std(1,2) s1_bar_plot.seq_diff_std(1,1) ...
    s1_bar_plot.ran_diff_std(1,2) s1_bar_plot.ran_diff_std(1,1)];
xTicker = {'Training Group - Sequence Condition',...
    'Control Group - Sequence Condition',...
    'Training Group - Random Condition'...
    'Control Group - Random Condition'};
yTicker = 'Mean Beta Value';

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
set(gca,'XTicklabel',{'M1 ROI','S1 ROI'})
h(1).FaceColor = 'g';
lh = legend(lKey);
set(lh,'Location','BestOutside','Orientation','horizontal');
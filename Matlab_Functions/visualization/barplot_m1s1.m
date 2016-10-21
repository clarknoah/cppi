 
 subplot(1,4,2)
m1_ran = bar(barplot_m1.ran,'g');
 hold
 errorbar(barplot_m1.ran,barplot_m1.ran_std,'black.');
 ylim([0,0.4]);
 set(gca,'XLim',[0 5]);
 set(gca,'XTick',[1:4]);
  ylabel('Mean of PPI correlation');
   set(gca,'XTickLabelRotation',45);
 set(gca,'XTickLabels',{'Control-Pre', 'Sequence-Pre', 'Control-Post', 'Sequence-Post'});
  title('Random Data (Pre-Post)');
  
   subplot(1,4,3)
 s1_seq = bar(barplot_s1.seq,'c');
 hold
 errorbar(barplot_s1.seq,barplot_s1.seq_std,'black.');

 set(gca,'XLim',[0 5]);
 set(gca,'XTick',[1:4]);
 ylim([0,0.4]);
 ylabel('Mean of PPI correlation');
  set(gca,'XTickLabelRotation',45);
 set(gca,'XTickLabels',{'Control-Pre', 'Sequence-Pre', 'Control-Post', 'Sequence-Post'});
 title('Sequence Data (Pre-Post)');
 
 
 subplot(1,4,4)
s1_ran = bar(barplot_s1.ran,'c');
 hold
 errorbar(barplot_s1.ran,barplot_s1.ran_std,'black.');
 ylim([0,0.4]);
 set(gca,'XLim',[0 5]);
 set(gca,'XTick',[1:4]);
 set(gca,'XTickLabelRotation',45);
  ylabel('Mean of PPI correlation');
 set(gca,'XTickLabels',{'Control-Pre', 'Sequence-Pre', 'Control-Post', 'Sequence-Post'});
  title('Random Data (Pre-Post)');
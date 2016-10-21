function [averages, bar_plot] = group_mean_std(pre_post_beta,group_ids,diff)
%GROUP_MEAN_STD Takes an input of subject betas and outputs group averages
%   Detailed explanation goes here
   
averages = struct();

averages.control = [];
averages.sequence = [];
        counter_seq = 1;
        counter_con = 1;
    for x=1:length(pre_post_beta)
        %Find 
        
        %Iterate through the group_ids to determine whether subject
        %is part of the control or sequence.

        for id_x=1:length(group_ids)
            if pre_post_beta(x,5) == group_ids(id_x,1) & ... 
                    group_ids(id_x,2) == 1
                averages.sequence(counter_seq,:) = pre_post_beta(x,:);
                counter_seq= counter_seq +1;
             disp(['Sequence Match Found:' num2str(pre_post_beta(x,5)) ...
                    ' and ' num2str(group_ids(id_x,1))])
            elseif pre_post_beta(x,5) == group_ids(id_x,1) & ...
                    group_ids(id_x,2) == 0
                averages.control(counter_con,:) = pre_post_beta(x,:);
                counter_con = counter_con +1;
            disp(['Control Match Found: ' num2str(pre_post_beta(x,5)) ...
                    ' and ' num2str(group_ids(id_x,1))])
            else
            end
        end
        
    end
 
 bar_plot = struct();
 bar_plot.seq = [];
 bar_plot.seq_std = [];
 bar_plot.ran = [];
 bar_plot.ran_std = [];
 bar_plot.seq_diff = [];
 bar_plot.ran_diff = [];
 bar_plot.seq_diff_std = [];
 bar_plot.ran_diff_std = [];

 if diff == 0
 
         bar_plot.seq(1,1) = mean(averages.control(:,2));
         bar_plot.seq(1,2) = mean(averages.sequence(:,2));
         bar_plot.seq(1,3) = mean(averages.control(:,4));
         bar_plot.seq(1,4) = mean(averages.sequence(:,4));

         bar_plot.ran(1,1) = mean(averages.control(:,1));
         bar_plot.ran(1,2) = mean(averages.sequence(:,1));
         bar_plot.ran(1,3) = mean(averages.control(:,3));
         bar_plot.ran(1,4) = mean(averages.sequence(:,3));

        bar_plot.seq_std(1,1) = sem(averages.control(:,2));
        bar_plot.seq_std(1,2) = sem(averages.sequence(:,2));
        bar_plot.seq_std(1,3) = sem(averages.control(:,4));
        bar_plot.seq_std(1,4) = sem(averages.sequence(:,4));

        bar_plot.ran_std(1,1) = sem(averages.control(:,1));
        bar_plot.ran_std(1,2) = sem(averages.sequence(:,1));
        bar_plot.ran_std(1,3) = sem(averages.control(:,3));
        bar_plot.ran_std(1,4) = sem(averages.sequence(:,3));

elseif diff == 1
    
         bar_plot.seq_diff(1,1) = mean(averages.control(:,4) - averages.control(:,2));
         bar_plot.seq_diff(1,2) = mean(averages.sequence(:,4) - averages.sequence(:,2));

         bar_plot.ran_diff(1,1) = mean(averages.control(:,3) - averages.control(:,1));
         bar_plot.ran_diff(1,2) = mean(averages.sequence(:,3) -averages.sequence(:,1));


        bar_plot.seq_diff_std(1,1) = sem(averages.control(:,4) - averages.control(:,2));
        bar_plot.seq_diff_std(1,2) = sem(averages.sequence(:,4) - averages.sequence(:,2));

        bar_plot.ran_diff_std(1,1) = sem(averages.control(:,3) - averages.control(:,1));
        bar_plot.ran_diff_std(1,2) = sem(averages.sequence(:,3) - averages.sequence(:,1));


 elseif diff == 2
           bar_plot.seq_diff(1,1) = mean(averages.control(:,4) - averages.control(:,2));
         bar_plot.seq_diff(1,2) = mean(averages.sequence(:,4) - averages.sequence(:,2));

         bar_plot.ran_diff(1,1) = mean(averages.control(:,3) - averages.control(:,1));
         bar_plot.ran_diff(1,2) = mean(averages.sequence(:,3) -averages.sequence(:,1));


        bar_plot.seq_diff_std(1,1) = sem(averages.control(:,4)) - sem(averages.control(:,2));
        bar_plot.seq_diff_std(1,2) = sem(averages.sequence(:,4)) - sem(averages.sequence(:,2));

        bar_plot.ran_diff_std(1,1) = sem(averages.control(:,3)) -sem(averages.control(:,1));
        bar_plot.ran_diff_std(1,2) = sem(averages.sequence(:,3)) - sem(averages.sequence(:,1));
   
 else   
 end
%{
 figure
 subplot(1,2,1)
 bar(bar_plot.seq);
 hold
 errorbar(bar_plot.seq,bar_plot.seq_std,'magenta.');

 set(gca,'XLim',[0 5]);
 set(gca,'XTick',[1:4]);
 ylim([y_limit(1),y_limit(2)]);
 ylabel('Mean of PPI correlation');
 set(gca,'XTickLabels',{'Control-Pre', 'Sequence-Pre', 'Control-Post', 'Sequence-Post'});
 title('Sequence Data (Pre-Post)');
 
 
 subplot(1,2,2)
 bar(bar_plot.ran);
 hold
 errorbar(bar_plot.ran,bar_plot.ran_std,'magenta.');
 ylim([y_limit(1),y_limit(2)]);
 set(gca,'XLim',[0 5]);
 set(gca,'XTick',[1:4]);
  ylabel('Mean of PPI correlation');
 set(gca,'XTickLabels',{'Control-Pre', 'Sequence-Pre', 'Control-Post', 'Sequence-Post'});
  title('Random Data (Pre-Post)');
  %}

end


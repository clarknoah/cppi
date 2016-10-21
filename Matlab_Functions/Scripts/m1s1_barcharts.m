%9 x 4 Bar chart of M1 and S1
m1 = [averages_m1.sequence(:,10).';averages_m1.sequence(:,12).';averages_m1.control(:,10).';averages_m1.control(:,12).'].';

m1_sem = [averages_m1.sequence(:,11).';averages_m1.sequence(:,13).';averages_m1.control(:,11).';averages_m1.control(:,13).'].';

s1 = [averages_s1.sequence(:,10).';averages_s1.sequence(:,12).';averages_s1.control(:,10).';averages_s1.control(:,12).'].';
s1_sem = [averages_s1.sequence(:,11).';averages_s1.sequence(:,13).';averages_s1.control(:,11).';averages_s1.control(:,13).'].';
figure
subplot(1,2,1)
group_error_bar(...
m1,m1_sem,'','Beta Value',{'Random(Seq)','Sequence(Seq)','Random(Ctrl)','Sequence(Ctrl)'},'M1 Post - Pre')
 ylim([-1.4,0.6]);
subplot(1,2,2)
group_error_bar(s1,s1_sem,...
'','Beta Value',{'Random(Seq)','Sequence(Seq)','Random(Ctrl)','Sequence(Ctrl)'},'S1 Post - Pre')
 ylim([-1.4,0.6]);

%9 x 4 Bar chart of M1 and S1
figure
subplot(1,2,1)
figure
subplot(1,2,1)
group_error_bar(...
m1.',m1_sem.',''...
,'Beta Value',{''},...
'M1 Post - Pre ***Random (Seq) || Sequence (Seq) || Random (Ctrl) || Sequence (Ctrl)***')
 ylim([-1.4,0.6]);
subplot(1,2,2)
group_error_bar(s1.',s1_sem.',...
''...
,'Beta Value',{''}, ...
'S1 Post - Pre ***Random (Seq) || Sequence (Seq) || Random (Ctrl) || Sequence (Ctrl***')
 ylim([-1.4,0.6]);
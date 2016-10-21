
subs = {'0006','0012', '0192', '0273', '0490', '0491', '0464', '0494', '0495', '0269', '0549', '0550','0557', '0558','0559', '0604', '0605', '0627'};
eigens = [];
for i = 1:length(subs)
    sub = subs{i};
    for run = [1,2];
        sphere = load(sprintf('/data/r2d4/subjects/%s_%d/SvR_GLM/sphere.mat', sub, run));
        y_data = sphere.y_data;
        eigens(:,i, run) = grab_eigens(y_data);
    end
    clear y_data
end;

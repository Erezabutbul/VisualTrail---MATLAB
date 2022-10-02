% Present the stats

function present_stats()
results = load('VSresults.mat');
results = results.results;
mean_feature_target = zeros(1,4);
mean_feature_no_target = zeros(1,4);
mean_conj_target = zeros(1,4);
mean_conj_no_target = zeros(1,4);
SD_feature_target = zeros(1,4);
SD_feature_no_target = zeros(1,4);
SD_conj_target = zeros(1,4);
SD_conj_no_target = zeros(1,4);
set_sizes = [4,8,12,16]; 
x_size = [2,max(set_sizes)+1];
y_size = [0,3];
fontSize = 15;


% loop through the results and calc the Mean && SD for each condition 
for i = 1 : length(results)
    if(strcmpi(results{i}.type,"conjunction"))
        index_of_mean = results{i}.setSize / 4;
        % with target
        % get from rt - the mean of the non zero values - 
        % when target condition was on
        mean_conj_target(index_of_mean) = mean(nonzeros(results{i}.rt(results{i}.target_no_target(2:2:length(results{i}.target_no_target)))));
        SD_conj_target(index_of_mean)= std(nonzeros(results{i}.rt(results{i}.target_no_target(2:2:length(results{i}.target_no_target)))));
        % without target
        % get from rt - the mean of the non zero values - 
        % when target condition was off
        mean_conj_no_target(index_of_mean) = mean(nonzeros(results{i}.rt(results{i}.target_no_target(1:2:length(results{i}.target_no_target)))));
        SD_conj_no_target(index_of_mean)= std(nonzeros(results{i}.rt(results{i}.target_no_target(1:2:length(results{i}.target_no_target)))));

    else
        index_of_mean = results{i}.setSize / 4;
        % with target
        % get from rt - the mean of the non zero values - 
        % when target condition was on
        mean_feature_target(index_of_mean) = mean(nonzeros(results{i}.rt(results{i}.target_no_target(2:2:length(results{i}.target_no_target)))));
        SD_feature_target(index_of_mean)= std(nonzeros(results{i}.rt(results{i}.target_no_target(2:2:length(results{i}.target_no_target)))));
        % without target
        % get from rt - the mean of the non zero values - 
        % when target condition was off
        mean_feature_no_target(index_of_mean) = mean(nonzeros(results{i}.rt(results{i}.target_no_target(1:2:length(results{i}.target_no_target)))));
        SD_feature_no_target(index_of_mean)= std(nonzeros(results{i}.rt(results{i}.target_no_target(1:2:length(results{i}.target_no_target)))));

    end
      
end




% plot the data

figure("Name",'No target');
hold on
title("WithOut target",FontSize= fontSize)
p_feature_no_target = polyfit(set_sizes,mean_feature_no_target,1);
poly_x = linspace(min(set_sizes) - 1 , max(set_sizes) + 1); 
errorbar(set_sizes,mean_feature_no_target,SD_feature_no_target, 'o') 
poly_val = polyval(p_feature_no_target,poly_x);
plot(poly_val)

p_conj_no_target = polyfit(set_sizes,mean_conj_no_target,1);
poly_val_2 = polyval(p_conj_no_target,poly_x);
errorbar(set_sizes,mean_conj_no_target,SD_conj_no_target, 'o')   
plot(poly_val_2)
hold on
xlim(x_size)
ylim(y_size)
xticks(set_sizes)
legend('RT feature','Polfit feature','RT conj','Polfit conj', 'Location','northwest');
xlabel("Set Size [Number of Elements]",FontSize= fontSize)
ylabel("Reaction Time [Sec]",FontSize= fontSize)
hold off






figure("Name",'target');
hold on
title("With target",FontSize= fontSize)

p_feature_target = polyfit(set_sizes,mean_feature_target,1);
errorbar(set_sizes,mean_feature_target,SD_feature_target, 'o') 
poly_val = polyval(p_feature_target,poly_x);
plot(poly_val)

p_conj_target = polyfit(set_sizes,mean_conj_target,1);
poly_val_2 = polyval(p_conj_target,poly_x);
errorbar(set_sizes,mean_conj_target,SD_conj_target, 'o')   
plot(poly_val_2)
hold on
xlim(x_size)
ylim(y_size)
xticks(set_sizes)
legend('RT feature','Polfit feature','RT conj','Polfit conj', 'Location','northwest');
xlabel("Set Size [Number of Elements]",FontSize= fontSize)
ylabel("Reaction Time [Sec]",FontSize= fontSize)


% Find the correlation
r_conj_target = corrcoef(set_sizes,mean_conj_target);
r_feature_target = corrcoef(set_sizes,mean_feature_target);
r_conj_no_target = corrcoef(set_sizes,mean_conj_no_target);
r_feature_no_target = corrcoef(set_sizes,mean_feature_no_target);
disp("for conjunction with target, pearson's result is: " + r_conj_target + ".")
disp("for conjunction with target, p-value is: " + r_conj_target + ".")
disp("for feature with target, pearson's result is: " + r_feature_target + ".")
disp("for feature with target, p-value is: " + r_feature_target + ".")
disp("for conjunction withOut target, pearson's result is: " + r_conj_no_target + ".")
disp("for conjunction withOut target, p-value is: " + r_conj_no_target + ".")
disp("for feature withOut target, pearson's result is: " + r_feature_no_target + ".")
disp("for feature withOut target, p-value is: " + r_feature_no_target + ".")






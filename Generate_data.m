% Generates Data

function [rt_vec , acc_vec] = Generate_data()

acc_vec =  [0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
shuffle_gen = randperm(30);
acc_vec = acc_vec(shuffle_gen);


rt_vec = randperm(30);

for i = 1:30
    rt_vec(i) = rt_vec(i) / 10;
end
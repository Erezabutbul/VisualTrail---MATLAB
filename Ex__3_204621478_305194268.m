% Data members for Set blocks order 
% Randomazing the data
conditions = ["feature","conjunction"];
numberOfGoodTrails = 20;
proportion = [0.16,0.1,0.08,0.06];
x = 0.5;
y = 0.8;
set_size = [4, 8, 12, 16];
set_size = [set_size,set_size];
target_no_target = randperm(30);
block_vec = [0,0,0,0,1,1,1,1];
shuffle = randperm(8);
block_vec = block_vec(shuffle);
set_size = set_size(shuffle);
% calling the primary function
results = Run_Experiment(conditions,numberOfGoodTrails,set_size,target_no_target,block_vec,proportion,x,y);
% save the results
save("VSresults","results");
% present stats
present_stats();


% Run the current block
% return data_stract that contains - all the data for the statistics
function data_stract = RunBlock(curr_condition,curr_set_size,target_no_target,proportion,h,automated)

data_stract.type = curr_condition;
data_stract.setSize = curr_set_size;
data_stract.target_no_target = target_no_target;
data_stract.rt = zeros(1,30);
data_stract.acc = zeros(1,30);
if(automated == 0)
    for k = 1 : length(target_no_target)
                if(mod(target_no_target(k),2) == 0)
                    target = true;
                else
                    target = false;
                end
    
                % call the Create_visual_stimuli
                
                % the functions uploads the current visual trail - and clears
                % the figure when its ends
                [rt, acc] = Create_visual_stimuli(curr_condition,curr_set_size,target,proportion,h);
                if(rt < 3 && acc == 1)
                    data_stract.rt(k) =  rt;
                    data_stract.acc(k) = acc;
                end
    
            
    end
else
    [data_stract.rt , data_stract.acc] = Generate_data;


end
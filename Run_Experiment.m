% Runs the Experiment
function result = Run_Experiment(conditions,numberOfGoodTrails,set_size,target_no_target,block_vec,proportion,x,y)
%% Visual search function - Experiment Figure
result = cell(1,length(block_vec));
fontSize = 15;
h = figure('units','normalized', 'position', [0 0 1 1]);
set(h,'MenuBar','none');
axis off;
set(gca,'Color','w');
instruction = text(x,y,{'hello user', 'Our stimuli will contain O and X elements in the colors blue and red','','Feature trial with a target includes several (N-1) elements of one shape and 1 element of a different shape, all in the same color.','',' For instance, 7 red Os and a single red x.' ,'','','Feature trial without a target includes N elements of same shape and color.',' For instance, 8 blue Os.','','','Conjunction trial with a target includes N/2 elements of first shape and first color, N/2-1 elements of second shape and second color, and 1 element of second shape and first color.',' For instance, 4 red Xs, 3 blue Os and a single red o.','','',' Conjunction trial without a target includes N/2 elements of first shape and first color, and N/2 elements of second shape and second color.',' For instance, 4 blue Xs, 4 red Os.'},FontSize=fontSize,HorizontalAlignment="center");
hold on

%% Greeting and instruction
% greeting
pause;
key = h.get('CurrentCharacter');
expKey = ' ';
while(strcmpi(key, expKey) == 0)
    pause;
    key = h.get('CurrentCharacter');
end
delete(instruction)
% instructions
instruction = text(x,y,{'','','','','','Your challenge today is to detect whether a target symbol is shown or not','','',' please press the button A if you think you spotted a target ','','','please press the button L if you think there is no target','','','','','','you are expected to answer as fast as you can','','','','','','','','press the space key to start'},FontSize=fontSize,HorizontalAlignment="center");
hold on
pause;
key = h.get('CurrentCharacter');
expKey = ' ';
while(strcmpi(key, expKey) == 0)
    pause;
    key = h.get('CurrentCharacter');
end
delete(instruction)
hold on
%% Start of the trail
% set blocks order 
for i = 1 : length(block_vec)
        % select the current condition
        curr_condition = conditions(block_vec(i) + 1);
        %   set the curr size
        curr_set_size = set_size(i);

        % run block function
        % default of automated is 0 
        % for automated data (bonus sections) : automated = 1;
        automated = 0;
        data_struct = RunBlock(curr_condition,curr_set_size,target_no_target,proportion,h,automated);
        
        % check if we need to run block again
        if(length(nonzeros(data_struct.rt ~= 0)) < numberOfGoodTrails )
            set(h,'MenuBar','none');
            axis off;
            set(gca,'Color','w');
            text(x,y,{'your results werent good enough','we are going to do this block again', ' please stay concentrated','','','','','','press space button to continue'},FontSize=fontSize,HorizontalAlignment="center")
            pause;
            key = h.get('CurrentCharacter');
            expKey = ' ';
            while(strcmpi(key, expKey) == 0)
                pause;
                key = h.get('CurrentCharacter');
            end
            clf;
            data_struct2 = RunBlock(curr_condition,curr_set_size,target_no_target,proportion,h,automated);
            
            % save the best result out of the 2
            if(length(nonzeros(data_struct2.rt ~= 0)) < length(nonzeros(data_struct.rt ~= 0)))
                %  save data_stract
                result{i} = data_struct;
            else
                %  save data_stract2
                result{i} = data_struct2;
            end
        
        
        else % the exp went as planed
            %save data_stract
            result{i} = data_struct;
        end
        if(automated == 0)
            set(h,'MenuBar','none');
            axis off;
            set(gca,'Color','w');
            text(x,y,{'way to go','you finished the block','','','','','','press space button to continue'},FontSize=fontSize,HorizontalAlignment="center");
            % pause after each block
            pause;
            key = h.get('CurrentCharacter');
            expKey = ' ';
            while(strcmpi(key, expKey) == 0)
                pause;
                key = h.get('CurrentCharacter');
            end
            clf;
        end

end

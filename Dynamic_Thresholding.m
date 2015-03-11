function [output_array,subject_quit,new_threshold] = Dynamic_Thresholding(windowPtr,detection_threshold)
%{

70% of trials are dynamic threshold
20% are null
10% are suprathreshold (100%)

if two correct in a row, lower thresold by .005 V
if three correct in a row, increase threshold .005 V

%}


subject_quit = false;
%Initialize crosshair images and screens
green_cross = imread('crosshair_green.png');
red_cross = imread('crosshair_red.png');
solid_black = imread('solid_black.png');
green_cross_screen = Screen('MakeTexture',windowPtr,green_cross);
red_cross_screen = Screen('MakeTexture',windowPtr,red_cross);
solid_black_screen = Screen('MakeTexture',windowPtr,solid_black);


Screen('DrawTexture',windowPtr,solid_black_screen);
Screen(windowPtr,'Flip');

WaitSecs(3);

%% 3) Initialize necessary variables - NUM_TRIALS IS HERE!!

%Desired number of trials of thresholded stimulus
total_num_trials = 20;


%Initialize variables to store stimulus values
intensity_1 = 0.0;
intensity_2 = detection_threshold;
intensity_3 = detection_threshold*2;

%array with num_trials of each stimulus (for a total of 3*num_trials trials)
stimulus_initial_values = [repmat(intensity_1,1,round(total_num_trials*.2)),repmat(intensity_2,1,round(total_num_trials*.7)),repmat(intensity_3,1,round(total_num_trials*.1))];

%array with delay times
delay_times = [.5 .6 .7 .8 .9 1 1.1 1.2 1.3 1.4 1.5];

%variables to keep track of output
count =  0;
output_array = [];
correct_count = 0;
incorrect_count_1 = 0;
incorrect_count_2 = 0;

%The equivalent of .005 V
change = .02;

%% 4) Actual presentation of stimuli and input of participant response
for (i = 1:total_num_trials)
    
    % 1) choose random stimulus intensity
    % 2) choose random delay time (from 500 ms to 1500 ms)
    % 3) display red cross hair
    % 4) deliver stimulus in fixed 100 ms interval 500 - 1500 ms after
    % presentation of red crosshair
    % 5) Wait an additional 500 ms (so total of 2 s since cue)
    % 6) displays green crosshair
    % 7) gives user up to 1 s for response y or n
    % 8) repeats loop
    
    
    %Choose random stimulus, and then erase it from initial array
    rand_position = randi([1 size(stimulus_initial_values,2)]);
    stimulus = stimulus_initial_values(rand_position);
    stimulus_initial_values(rand_position) = [];
    
    %Choose random delay time
    rand_position_delay = randi([1 size(delay_times,2)]);
    delay_time = delay_times(rand_position_delay);
    
    %Draw red crosshair
    Screen('DrawTexture',windowPtr,red_cross_screen);
    Screen(windowPtr,'Flip');
    
    WaitSecs(delay_time);
    
    %Deliver Stimulus
    Beeper(100,stimulus,.01);
    WaitSecs(2 - delay_time);
    
    %Draw green crosshair
    Screen('DrawTexture',windowPtr,green_cross_screen);
    Screen(windowPtr,'Flip');
    
    % Checks for detection, gives
    [s, keyCode, delta] = KbWait([], 2, GetSecs()+1);
    
    WaitSecs(1 - delta);
    
    %Dynamic thresholding
    
    % If it is a threshold stimulus... (and is greater than delta so the
    % stimulus doesn't go to 0)
    
    if (stimulus ~= intensity_1 && stimulus ~= intensity_3)
        
        % And if it is detected
        if (keyCode(30) && stimulus > change)
            
            % check if previous one detected, if so lower stimulus, reset
            % counts
            if (correct_count == 1)
                
                stimulus_initial_values(find(stimulus_initial_values == stimulus)) = stimulus_initial_values(find(stimulus_initial_values == stimulus)) - change;
                correct_count = 0;
                incorrect_count_1 = 0;
                incorrect_count_2 = 0;
            
            % if previous not detected, then add one to count
            elseif (correct_count ~= 1)
                
                correct_count = 1;
                
            end
        
        % and if this one wasn't detected
        else
            
            % check to see if previous two were not detected, if so increase
            % stimulus, reset counts
            if (incorrect_count_2 == 1)
                
                stimulus_initial_values(find(stimulus_initial_values == stimulus)) = stimulus_initial_values(find(stimulus_initial_values == stimulus)) + change;
                incorrect_count_2 = 0;
                incorrect_count_1 = 0;
                correct_count = 0;
            
            % check to see if previous one was not detected, add to count  
            elseif (incorrect_count_1 == 1)
                
                incorrect_count_2 = 1;
            
            % if none previously not detected, then add one to count
            else
                
                incorrect_count_1 = 1;
                
            end
            
           
            
        end
        
        
    end
    
    
    
    % Add a break
    if (i == round(total_num_trials/3) || i == 2*round(total_num_trials/3))
        
        display_instructions(windowPtr,6)
        
    end
    
    %Check for quitting
    if (keyCode(8) == 1)
        
        subject_quit = true;
        fprintf('The subject indicated they wanted to quit at Dynamic Thresholding.');
        Screen('CloseAll')
        break;
        
        
    end
    
    %Output data appropriately
    count = count + 1;
    data = [count, delay_time, stimulus, keyCode(30)];
    
    output_array = cat(1,output_array,data);
    %Output data
    output_array(end,:)
    
    %Output new threshold
    if ((length(find(stimulus_initial_values == intensity_1)) + length(find(stimulus_initial_values == intensity_3))) == length(stimulus_initial_values))
        
        new_threshold = stimulus;
        
    end
end




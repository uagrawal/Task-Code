function [output_array,error_screen,subject_quit] = Training_Block_1(windowPtr)
%{

    Added 1 second to presentation of red cross and 1 second to
    presentation of green cross (ie 5 second ISI total). It helps train
    participants in the task.

%}

%% 1) Initialize variables

global initial_time
subject_quit = false;

% Initialize crosshair images and screens
green_cross = imread('crosshair_green.png');
red_cross = imread('crosshair_red.png');
solid_black = imread('solid_black.png');
green_cross_screen = Screen('MakeTexture',windowPtr,green_cross);
red_cross_screen = Screen('MakeTexture',windowPtr,red_cross);
solid_black_screen = Screen('MakeTexture',windowPtr,solid_black);

% Draw inital black screen
Screen('DrawTexture',windowPtr,solid_black_screen);
Screen(windowPtr,'Flip');

% Wait after instructions screen (to prepare subject)
WaitSecs(3);

%Desired number of trials per intensity
num_trials = 5;

%Initialize variables to store stimulus values
num_intensities = 2;
intensity_1 = 0;
intensity_2 = 1;

%array with num_trials of each stimulus
stimulus_initial_values = [repmat(intensity_1,1,num_trials),repmat(intensity_2,1,num_trials)];

%array with delay times
delay_times = [.5 .6 .7 .8 .9 1 1.1 1.2 1.3 1.4 1.5];

%variables to keep track of output
count =  0;
output_array = [];
error_count = 0;
error_screen = false;

%% 2) Actual presentation of stimuli and input of participant response
for (i = 1:num_intensities*num_trials)
    
    % 1) choose random stimulus intensity
    % 2) choose random delay time in delay_times
    % 3) display red cross hair
    % 4) deliver stimulus following delay_time + 500 ms (bc training)
    % 5) wait an additional 500 ms + 500 ms (bc training)
    % 6) display green crosshair
    % 7) user response in 1s + 1s (bc training)
    % 8) repeats loop until all stimuli done
    
    
    % Choose random stimulus, and then erase it from initial array
    rand_position = randi([1 size(stimulus_initial_values,2)]);
    stimulus = stimulus_initial_values(rand_position);
    stimulus_initial_values(rand_position) = [];
    
    % Choose random delay time
    rand_position_delay = randi([1 size(delay_times,2)]);
    delay_time = delay_times(rand_position_delay);
    
    % Draw red crosshair
    Screen('DrawTexture',windowPtr,red_cross_screen);
    Screen(windowPtr,'Flip');
    
    % Wait delay_time + 500 ms (bc training)
    WaitSecs(delay_time + .5);
    
    % Deliver Stimulus, and obtain timestamps
    time = GetSecs() - initial_time;
    Beeper(100,stimulus,.01);
    
    % Wait remainder of the interval 
    WaitSecs(2.5 - delay_time - .01);
    
    % Draw green crosshair
    Screen('DrawTexture',windowPtr,green_cross_screen);
    Screen(windowPtr,'Flip');
    
    % Checks for detection, obtain participant response
    [s, keyCode, delta] = KbWait(-3, 2, GetSecs()+2);
    
    % Wait remainder of the interval
    WaitSecs(2 - delta);
    
    %Output data appropriately
    count = count + 1;
    data = [count, time, delay_time, stimulus, keyCode(30)];
    
    % Check for error in detection
    if (stimulus == intensity_1 && keyCode(30) == 1)
        
        error_count = error_count + 1;
        
    elseif (stimulus == intensity_2 && keyCode(30) == 0)
        
        error_count = error_count + 1;
        
    end
    
    % If the subject presses '=' (ie keycode(46)) at any time the session
    % will end
    if (keyCode(46) == 1)
        subject_quit = true;
        fprintf('The subject indicated they wanted to quit at Training Block 1.');
        Screen('CloseAll')
        break;
        
    end
    
    % If too many errors then indicate error screen should be output
    if (error_count >= 3)
        
        error_screen = true;
        
    end
    
    % Append data to output_array
    output_array = cat(1,output_array,data);
    
end


if (error_screen)
    
    fprintf('Training 1 was incorrectly done.');
    
end
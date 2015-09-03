function [output_array,subject_quit,threshold] = Dynamic_Thresholding_withStim(windowPtr,detection_threshold,total_num_trials,a)
%{

This is a script to perform the dynamic thresholding procedure as described
in Jones 2007. In the procedure, there will be 70% dynamic thresholding
trials, 20% null trials, and 10% suprathreshold (ie 100%). Specifically,
the suprathreshold trials will be two times the detection threshold
obtained from PEST.

Dynamic thresholding works as follows - if two correct threshold stimuli
are percieved in a row, then the threshold will be lowered by .005 V. If
three threshold stimuli are failed to be percieved in a row, then the
threshold will increase by .005 V.

a = arduino

%}

%% 1) Initialize variables

global initial_time

% boolean to track whether subject quit
subject_quit = false;

% initialize images, screens
green_cross = imread('crosshair_green.png');
red_cross = imread('crosshair_red.png');
solid_black = imread('solid_black.png');
green_cross_screen = Screen('MakeTexture',windowPtr,green_cross);
red_cross_screen = Screen('MakeTexture',windowPtr,red_cross);
solid_black_screen = Screen('MakeTexture',windowPtr,solid_black);


% draw initial black screen
Screen('DrawTexture',windowPtr,solid_black_screen);
Screen(windowPtr,'Flip');

% initial stimulus intensities (based on performance in PEST)
null = 0.0;
threshold_intensity = detection_threshold;
supra = detection_threshold*2;

% array to store placeholders (0,1,2) for (null, threshold, supra) at the
% correct proportions (ie 20%, 70%, 10%)
stimulus_initial_values = [repmat(0,1,round(total_num_trials*.2)),repmat(1,1,round(total_num_trials*.7)),repmat(2,1,round(total_num_trials*.1))];

% array with possible delay times
delay_times = [.5 .6 .7 .8 .9 1 1.1 1.2 1.3 1.4 1.5];

% variables to keep track of output
output_array = []; %overall output
threshold_output_array = []; %array that only stores responses from threshold stimuli
count_threshold = 0; %number of threshold stimuli

% the equivalent of .005 V (to increase or decrease the threshold by)
change = .01;

% value to store the changing threshold
threshold = threshold_intensity;

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
    % 8) Checks to see if the threshold needs to be changed and does so
    % 9) Outputs array of data
    
    
    %% Delivery of stimulus
    %Choose random stimulus
    rand_position = randi([1 size(stimulus_initial_values,2)]);
    
    %Select appropriate stimulus based on indexes
    if (stimulus_initial_values(rand_position) == 0)
        
        stimulus = null;
        
    elseif (stimulus_initial_values(rand_position) == 1)
        
        stimulus = threshold;
        
    elseif (stimulus_initial_values(rand_position) == 2)
        
        stimulus = supra;
        
    end
    
    %Delete stimulus from array so that it isn't repeated
    stimulus_initial_values(rand_position) = [];
    
    %Choose random delay time
    rand_position_delay = randi([1 size(delay_times,2)]);
    delay_time = delay_times(rand_position_delay);
    
    %Draw red crosshair
    Screen('DrawTexture',windowPtr,red_cross_screen);
    Screen(windowPtr,'Flip');
    
    WaitSecs(delay_time);
    
    %Deliver Stimulus
    time = GetSecs() - initial_time;
    Beeper(100, stimulus, .01);
    WaitSecs(2 - delay_time - .01);
    
    %Draw green crosshair
    Screen('DrawTexture',windowPtr,green_cross_screen);
    Screen(windowPtr,'Flip');
    
    % Checks for detection, gives
    [s, keyCode, delta] = KbWait(-3, 2, GetSecs()+1);
    
    WaitSecs(1 - delta);
    
    
    %% Dynamic Thresholding
    
    % If stimulus is same intensity as threshold, then add to array
    if (stimulus == threshold)
        
        threshold_output_array = cat(1,threshold_output_array,keyCode(30));
        count_threshold = count_threshold + 1;
        
        
        % And if it is detected, and previous threshold stimulus was
        % detected, then reduce threshold
        if (keyCode(30))
            
            if (count_threshold > 1)
                
                if (threshold_output_array(count_threshold-1) == 1)
                    
                    threshold = threshold - change;
                    threshold_output_array = [];
                    count_threshold = 0;
                    
                end
            end
            
        % If it wasn't detected, and previous two threshold stimuli weren't
        % detected, then increase threshold
        else
            
            if (count_threshold > 2)
                
                if (threshold_output_array(count_threshold-1) == 0 && threshold_output_array(count_threshold-2) == 0)
                    
                    threshold = threshold + change;
                    threshold_output_array = [];
                    count_threshold = 0;
                    
                end
            end  
        end  
    end
    
    %% Stimulation
    
    % Stimulate every 2 trials
    if (mod(i+2,4) == 0)
        
        writeDigitalPin(a, 11, 1)
        
    elseif (mod(i,4) == 0)
        
        writeDigitalPin(a, 11, 0)
    
    end
    

    %Check for quitting (= is to quit)
    if (keyCode(46) == 1)
        
        writeDigitalPin(a, 11, 0)
        subject_quit = true;
        fprintf('The subject indicated they wanted to quit.');
        Screen('CloseAll')
        break;
        
        
    end
    
    %Output data appropriately
    data = [i, time, delay_time, stimulus, keyCode(30)];
    
    output_array = cat(1,output_array,data);
    
    %Output data
    output_array(end,:)
    
end

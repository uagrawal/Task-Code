function [subject_quit] = S1_Localization(windowPtr)
%{
    Repeatedly stimulate subject at a frequency, intensity, and duration of
    interest. Useful in localizing S1 respresentation of finger.
%}

%% 1) Initialize necessary variables

% Boolean to track whether session wants to be ended early
subject_quit = false;

% Initialize crosshair images and screens
red_cross = imread('crosshair_red.png');
solid_black = imread('solid_black.png');
red_cross_screen = Screen('MakeTexture',windowPtr,red_cross);
solid_black_screen = Screen('MakeTexture',windowPtr,solid_black);

% Draw inital black screen
Screen('DrawTexture',windowPtr,solid_black_screen);
Screen(windowPtr,'Flip');

% Wait after instructions screen (to prepare subject)
WaitSecs(3);

% Desired stimulation frequency, stimulation intensity, stimulus duration,
% number of trials, and frequency of trials
stim_frequency = 100; % Hz
stim_intensity = 1; % on scale of 0 - 1 (scaled in psychtoolbox)
stim_duration = .01; % seconds
num_trials = 50;
freq_trials = 1; % seconds

%% 2) Actual presentation of stimuli

for (i = 1:num_trials)
    
    %Draw red crosshair
    Screen('DrawTexture',windowPtr,red_cross_screen);
    Screen(windowPtr,'Flip');
    
    Beeper(stim_frequency,stim_intensity,stim_duration);
    
    % Checks for detection, gives
    [s, keyCode, delta] = KbWait(-3, 2, GetSecs()+freq_trials);
    
    WaitSecs(freq_trials - delta);
    
    % If the subject presses '=' (ie keycode(46)) at any time the session
    % will end
    if (keyCode(46) == 1)
        
        subject_quit = true;
        fprintf('The subject indicated they wanted to quit at S1 Localization.');
        Screen('CloseAll')
        break;
        
    end
    
    
end

end

function clean_eeg(windowPtr,trial_length)
%{
   Display red crosshair for trial_length seconds
%}

%% 1) Initialize necessary variables

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

%% 2) Presentation of Red Crosshair

%Draw red crosshair
Screen('DrawTexture',windowPtr,red_cross_screen);
Screen(windowPtr,'Flip');

WaitSecs(trial_length);


end



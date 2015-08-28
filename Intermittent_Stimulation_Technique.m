%Intermittent Stimulation Technique
  
%This script will contain the following procedure:

% Set up - 45 min
% 1) S1 Localization - 1 min
% 2) Training Block 1 - 1 min
% 3) Training Block 2 - 1 min
% 4) Baseline EEG only - 3 min
% 5) PEST Convergence - 3 min
% 6) EEG/tactile 1 - 6 min
% 7) tACS/tactile 1 - 6 min
% 8) EEG/tactile 2 - 6 min
% 9) tACS/tactile 2 - 6 min
% 10) EEG/tactile 3 - 6 min
% 11) tACS/tactile 3 - 6 min
% 12) EEG/tactile 4 - 6 min
% 13) Baseline EEG only - 3 min
% Clean up - 30 min
% 


%% Initializing Psychtoolbox Audio Functionality

% Initialize screens (to determine if using one laptop or connected
% monitor)
setGlobalVariables();
global screens

% Load PsychPortAudio sound driver and set default sampling frequency and
% number of channels
InitializePsychSound(1);
SamplingFreq = 44100;
NbChannels = 2;

% Creates a sound handle with indicated settings
SoundHandle = PsychPortAudio('Open',[],[],2,SamplingFreq,NbChannels);

% Create Arduino handle
a = arduino();

% Initialize parameters of Screen() so Screen() doesn't crash
% Note: This was specific to my Mac and runs on most Macs, but may need to
% be altered on other laptops
Screen('Preference','SyncTestSettings',[.005],[50],[.5],[5]);

% Open first screen, solid black
[windowPtr, rect] = Screen('OpenWindow',screens,[0 0 0]);

%% 1) S1 Localization - 1 min

% An interval where a stimulus at maximal intensity will be delivered
% every second to help localize S1.
display_instructions(windowPtr,'PreS1Localization')
subject_quit_S1_Localization = S1_Localization(windowPtr);

%% 2,3) Training Blocks 1 and 2

% Instructions for the task will be displayed until the participant reads
% and understands them, and can press any key to move past. Training Blocks
% will also be given consisting of 5 max intensity stimuli and 5 null
% stimuli to ensure the participant understands and can perform the task.
% The first training block will show a red crosshair for 2.5 s and then
% switch to a green crosshair for 1.5 s (for an ISI of 4 sec). The second
% training block will present the red crosshair for 2 s and then switch to
% the green crosshair for 1 s (for an ISI of 3 sec) as in the actual task.
% If the subjects incorrectly identify 3 or more stimuli, they will be
% prompted to repeat the Training Blocks.

% Note: participant can quit training blocks by presing '='

% Initializing boolean variables to check whether subject passes Training
% Block 1 and Trianing Block 2 respectively
not_understand_task_1 = true;
not_understand_task_2 = true;

display_instructions(windowPtr,'PreTrainingBlock1A')
display_instructions(windowPtr,'PreTrainingBlock1B')
% Loop through Training Blocks until they are passed by the partcipant
while (not_understand_task_1)
    
    [output_array_training_1,error_1,subject_quit_training_1] = Training_Block_1(windowPtr);
    
    % If they missed more than three trials, repeat training
    if (error_1)
        
        fprintf('Repeat Training 1');
        display_instructions(windowPtr,'Error')
        
    else
        
        not_understand_task_1 = false;
        
    end
    
    if (subject_quit_training_1)
        
        return
        
    end
    
end

display_instructions(windowPtr,'PreTrainingBlock2')
% Loop through Training Block 2 until it is passed by the partcipant
while (not_understand_task_2)
    
    [output_array_training_2,error_2,subject_quit_training_2] = Training_Block_2(windowPtr);
    
    % If they missed more than three trials, repeat training
    if (error_2)
        
        fprintf('Repeat Training 2')
        display_instructions(windowPtr,'Error')
        
    else
        
        not_understand_task_2 = false;
        
    end
    
    if (subject_quit_training_2)
        
        return
        
    end
    
end

%% 4) Clean EEG 1

% 3 minute period where instruction screen is displayed and clean EEG is
% recorded
display_instructions(windowPtr,'PreCleanEEG1')
clean_eeg(windowPtr,180)

%% 5) Go into PEST Convergence Procedure

display_instructions(windowPtr,'PreTask')
% A procedure to obtain the tactile detection threshold (50 %)
[detection_threshold, output_array_PEST_1, subject_quit_PEST] = PEST_Convergence_Procedure(windowPtr);

% If the threshold was output as 1, then the procedure was done incorrectly
% and should be repeated
while (detection_threshold == 1)
    
    display_instructions(windowPtr,4)
    
    [detection_threshold,output_array_PEST_1] = PEST_Convergence_Procedure(windowPtr);
    
end
%% 6 - 12) Tactile Stimulation Task

% 6) EEG/tactile 1 - 6 min
% 7) tACS/tactile 1 - 6 min
% 8) EEG/tactile 2 - 6 min
% 9) tACS/tactile 2 - 6 min
% 10) EEG/tactile 3 - 6 min
% 11) tACS/tactile 3 - 6 min
% 12) EEG/tactile 4 - 6 min

[output_array_tactile_detection, subject_quit_task, new_threshold] = Dynamic_Thresholding(windowPtr,detection_threshold,840,a);

save('psychometric_data');


%% 13) Clean EEG 2

% 3 minute period where instruction screen is displayed and clean EEG is
% recorded
display_instructions(windowPtr,'PreCleanEEG2')
clean_eeg(windowPtr,180)
display_instructions(windowPtr,'Final')
clear a
Screen('CloseAll')

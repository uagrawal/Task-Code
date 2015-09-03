%Intermittent Stimulation Technique
  
%This script contains the following procedure:

%{
1) S1 Localization - 7 min
2) Training Block 1 - 1 min
3) Baseline EEG only - 3 min: no tactile
4) PEST Convergence - 3 min
5) Baseline EEG/tactile 10 min
6) break 1 min
7) tACS/tactile/ EEG (6sec ON/ 6sec OFF): 15 min
8) break 1 min
9) EEG/tactile 10 min
10) Baseline EEG only - 3 min
%}

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

%% 1) S1 Localization - 7 min
% This will involve 100 max intensity stimulations to the fingertip in 50 seconds to help
% feed into the starstim software and localize S1

display_instructions(windowPtr,'PreS1Localization')
subject_quit_S1_Localization = S1_Localization(windowPtr);

%% 2) Training Blocks 1 and 2

% Instructions for the task will be displayed until the participant reads
% and understands them, and can press any key to move past. A Training Block
% will also be given consisting of 5 max intensity stimuli and 5 null
% stimuli to ensure the participant understands and can perform the task.
% The training block will present the red crosshair for 2 s and then switch to
% the green crosshair for 1 s (for an ISI of 3 sec) as in the actual task.
% If the subjects incorrectly identify 3 or more stimuli, they will be
% prompted to repeat the Training Blocks.

% Note: participant can quit training blocks by presing '='

% Initializing boolean variables to check whether subject passes Training
% Block 1 and Trianing Block 2 respectively
not_understand_task_1 = true;

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


%% 3) Clean EEG 1

% 3 minute period where instruction screen is displayed and clean EEG is
% recorded
display_instructions(windowPtr,'PreCleanEEG1')
clean_eeg(windowPtr,180)

%% 4) Go into PEST Convergence Procedure

display_instructions(windowPtr,'PreTask')
% A procedure to obtain the tactile detection threshold (50 %)
[detection_threshold, output_array_PEST_1, subject_quit_PEST] = PEST_Convergence_Procedure(windowPtr);

% If the threshold was output as 1, then the procedure was done incorrectly
% and should be repeated
while (detection_threshold == 1)
    
    display_instructions(windowPtr,4)
    
    [detection_threshold,output_array_PEST_1] = PEST_Convergence_Procedure(windowPtr);
    
end
%% 5) Baseline EEG/Tactile 1 - 7.5 min

[tactile_detection_baseline_pretACS, subject_quit_task, new_threshold_pretACS] = Dynamic_Thresholding(windowPtr,detection_threshold,150);

save('baseline_data')
%% 6) tACS/Tactile/EEG - 15 min

display_instructions(windowPtr,'Break')

[tactile_detection_tACS, subject_quit_task, new_threshold_tACS] = Dynamic_Thresholding_withStim(windowPtr,new_threshold_pretACS,300,a);
clear a
save('post_tACS_data')

%% 7) Baseline EEG/Tactile 2 - 7.5 min

display_instructions(windowPtr,'Break')

[tactile_detection_baseline_posttACS, subject_quit_task, new_threshold_posttACS] = Dynamic_Thresholding(windowPtr,new_threshold_tACS,150);


%% 13) Clean EEG 2

% 3 minute period where instruction screen is displayed and clean EEG is
% recorded
display_instructions(windowPtr,'PreCleanEEG2')
clean_eeg(windowPtr,180)
display_instructions(windowPtr,'Final')
Screen('CloseAll')

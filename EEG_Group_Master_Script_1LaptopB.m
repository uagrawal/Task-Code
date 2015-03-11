%% Initializing Psychtoolbox functions
%Initialize Psych Sound

%SCREENS = 0; %if there is 1 screen then keep this
SCREENS = 1; %if there are two screens then keep this


InitializePsychSound(1);
SamplingFreq = 44100;
NbChannels = 2;
SoundHandle = PsychPortAudio('Open',[],[],2,SamplingFreq,NbChannels);

%Initialize Parameters so screen() doesn't crash
Screen('Preference','SyncTestSettings',[.005],[50],[.5],[5])

%Open first screen, solid black
[windowPtr, rect] = Screen('OpenWindow',SCREENS,[0 0 0]);


%% 5) Tactile Detection Task

[output_array_tactile_detection_2,subject_quit_task_2] = TactileDetectionTask(windowPtr,detection_threshold_1);
save('psychometric_data_post_tACS');

if (subject_quit_task_2)
        
        return
        
end

%% 6) PEST Convergence again

[detection_threshold_2,output_array_PEST_2,subject_quit_PEST] = PEST_Convergence_Procedure(windowPtr);

save('psychometric_data_final');

if (subject_quit_training_2)
        
        return
        
end

display_instructions(windowPtr,7);
Screen('CloseAll')


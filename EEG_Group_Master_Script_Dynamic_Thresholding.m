%EEG Group Master Script - Dynamic Thresholding
  
%This script will contain the following procedure:

%Set up - 40 min
% 1) Display Instructions - 2 min
% 2) PEST - 3 min
% 3) Tacti11leDetection Task - 20 min
% 4) tACS - 10 min
% 5) TactileDetection Task - 20 min
% 6) PEST - 3 min
%Clean up - 20 min
% then repeat for the two control conditions
%
%
%% Initializing Psychtoolbox functions
%Initialize Psych Sound

SCREENS = 0; %if there is 1 screen then keep this
%SCREENS = 1; %if there are two screens then keep this

InitializePsychSound(1);
SamplingFreq = 44100;
NbChannels = 2;
SoundHandle = PsychPortAudio('Open',[],[],2,SamplingFreq,NbChannels);

%Initialize Parameters so screen() doesn't crash
Screen('Preference','SyncTestSettings',[.005],[50],[.5],[5]);

%Open first screen, solid black
[windowPtr, rect] = Screen('OpenWindow',SCREENS,[0 0 0]);

%% Round 1 -


%% 1) Display Instructions + Training Block

not_understand_task_1 = true;
not_understand_task_2 = true;
display_instructions(windowPtr,1);


display_instructions(windowPtr,2);
%Training Blocks
%{
while (not_understand_task_1)
    
    [output_array_training_1,error_1,subject_quit_training_1] = Training_Block_1(windowPtr);
    
    if (error_1)
        
        fprintf('Repeat Training 1');
        display_instructions(windowPtr,4)
        
    else
        
        not_understand_task_1 = false;
        
    end
    
    if (subject_quit_training_1)
        
        return
        
    end
    
end

display_instructions(windowPtr,3);

while (not_understand_task_2)
    
    [output_array_training_2,error_2,subject_quit_training_2] = Training_Block_2(windowPtr);
    
    if (error_2)
        
        fprintf('Repeat Training 2')
        display_instructions(windowPtr,4)
        
    else
        
        not_understand_task_2 = false;
        
    end
    
    if (subject_quit_training_2)
        
        return
        
    end
    
end

display_instructions(windowPtr,3.5);


%% 2) Go into PEST Convergence Procedure

[detection_threshold_1,output_array_PEST_1,subject_quit_PEST] = PEST_Convergence_Procedure(windowPtr);

save('detection_threshold');
if (subject_quit_training_2)
        
        return
        
end


while (detection_threshold_1 == 1)
    
    display_instructions(windowPtr,4)
    
    [detection_threshold_1,output_array_PEST_1] = PEST_Convergence_Procedure(windowPtr);
    
end



%% 3) Tactile Detection Task
[output_array_tactile_detection_1,subject_quit_task_1,new_threshold] = Dynamic_Thresholding(windowPtr,detection_threshold_1);

save('psychometric_data_pre_tACS');

if (subject_quit_task_1)
        
        return
        
end
%}

%% 4) tACS
quit = display_instructions(windowPtr,5);
if (quit)
        
        return
        
end


%% 5) Tactile Detection Task

[output_array_tactile_detection_2,subject_quit_task_2,final_threshold] = Dynamic_Thresholding(windowPtr,new_threshold);
save('psychometric_data_post_tACS');

if (subject_quit_task_2)
        
        return
        
end

display_instructions(windowPtr,7);

Screen('CloseAll')

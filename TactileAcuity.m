setGlobalVariables();
global screens


InitializePsychSound(1);
SamplingFreq = 44100;
NbChannels = 2;
SoundHandle = PsychPortAudio('Open',[],[],2,SamplingFreq,NbChannels);

%Initialize Parameters so screen() doesn't crash
Screen('Preference','SyncTestSettings',[.005],[50],[.5],[5]);

%Open first screen, solid black
[windowPtr, rect] = Screen('OpenWindow',screens,[0 0 0]);

%% 1) Display Instructions + Training Block

not_understand_task_1 = true;
not_understand_task_2 = true;
display_instructions(windowPtr,1);


display_instructions(windowPtr,2);
%Training Blocks

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

[detection_threshold_2,output_array_PEST_2,subject_quit_PEST] = PEST_Convergence_Procedure(windowPtr);

save('detection_threshold');
if (subject_quit_training_2)
        
        return
        
end

[detection_threshold_3,output_array_PEST_3,subject_quit_PEST] = PEST_Convergence_Procedure(windowPtr);

save('detection_threshold');
if (subject_quit_training_2)
        
        return
        
end

[detection_threshold_4,output_array_PEST_4,subject_quit_PEST] = PEST_Convergence_Procedure(windowPtr);

save('detection_threshold');
if (subject_quit_training_2)
        
        return
        
end

[detection_threshold_5,output_array_PEST_5,subject_quit_PEST] = PEST_Convergence_Procedure(windowPtr);

save('detection_threshold');
if (subject_quit_training_2)
        
        return
        
end

display_instructions(windowPtr,7);

Screen('CloseAll')


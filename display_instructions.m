function quit_to_tACS = display_instructions(windowPtr,instruction_screen)

if (strcmp(instruction_screen,'PreS1Localization'))
    
    instructions = imread('Instructions_PreS1Localization.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
elseif (strcmp(instruction_screen,'PreTrainingBlock1A'))
    
    instructions = imread('Instructions_PreTrainingBlock1A.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);

elseif (strcmp(instruction_screen,'PreTrainingBlock1B'))
    
    instructions = imread('Instructions_PreTrainingBlock1B.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
elseif (strcmp(instruction_screen,'PreTrainingBlock2'))
    
    instructions = imread('Instructions_PreTrainingBlock2.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
elseif (strcmp(instruction_screen,'PreCleanEEG1'))
    
    instructions = imread('Instructions_PreCleanEEG1.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
elseif (strcmp(instruction_screen,'PreTask'))
    
    instructions = imread('Instructions_PreTask.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
elseif (strcmp(instruction_screen,'PreCleanEEG2'))
    
    instructions = imread('Instructions_PreCleanEEG2.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
    
elseif (strcmp(instruction_screen,'Final'))
    
    instructions = imread('Instructions_Final.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    

    
elseif (instruction_screen == 5)
    
    instructions_5 = imread('tACS_Instructions_5.png');
    instructions_screen_5 = Screen('MakeTexture',windowPtr,instructions_5);
    
    Screen('DrawTexture',windowPtr,instructions_screen_5);
    Screen(windowPtr, 'Flip');
    
    fprintf('Subject is ready to be tACSed.');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+6000);
    
    if (wait_2(46) == 1)
        
        quit_to_tACS = true;
        Screen('CloseAll')
        
    end
    
elseif (instruction_screen == 6)
    
    instructions_6a = imread('tACS_Instructions_Break_1.png');
    instructions_screen_6a = Screen('MakeTexture',windowPtr,instructions_6a);
    instructions_6b = imread('tACS_Instructions_Break_2.png');
    instructions_screen_6b = Screen('MakeTexture',windowPtr,instructions_6b);
    
    Screen('DrawTexture',windowPtr,instructions_screen_6a);
    Screen(windowPtr, 'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+50);
    
    Screen('DrawTexture',windowPtr,instructions_screen_6b);
    Screen(windowPtr, 'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+10);
    
elseif (instruction_screen == 7)
    
    instructions_end = imread('tACS_Instructions_end.png');
    instructions_screen_end = Screen('MakeTexture',windowPtr,instructions_end);
    
    Screen('DrawTexture',windowPtr,instructions_screen_end);
    Screen(windowPtr, 'Flip');
    
    fprintf('The subject has completed the experiment.');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+6000);
    
end


end

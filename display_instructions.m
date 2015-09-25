function quit_to_tACS = display_instructions(windowPtr,instruction_screen)

if (strcmp(instruction_screen,'PreS1Localization'))
    
    instructions = imread('Instructions_PreS1Localization.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait(-3, 2, GetSecs()+120);
    
elseif (strcmp(instruction_screen,'PreTrainingBlock1A'))
    
    instructions = imread('Instructions_PreTrainingBlock1A.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait(-3, 2, GetSecs()+120);
    
elseif (strcmp(instruction_screen,'PreTrainingBlock1B'))
    
    instructions = imread('Instructions_PreTrainingBlock1B.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait(-3, 2, GetSecs()+120);
    
elseif (strcmp(instruction_screen,'PreTrainingBlock2'))
    
    instructions = imread('Instructions_PreTrainingBlock2.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait(-3, 2, GetSecs()+120);
    
elseif (strcmp(instruction_screen,'PreCleanEEG1'))
    
    instructions = imread('Instructions_PreCleanEEG1.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait(-3, 2, GetSecs()+120);
    
elseif (strcmp(instruction_screen,'PreTask'))
    
    instructions = imread('Instructions_PreTask.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait(-3, 2, GetSecs()+120);
    
elseif (strcmp(instruction_screen,'PreCleanEEG2'))
    
    instructions = imread('Instructions_PreCleanEEG2.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait(-3, 2, GetSecs()+120);
    
    
elseif (strcmp(instruction_screen,'Final'))
    
    instructions = imread('Instructions_Final.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait(-3, 2, GetSecs()+120);
    
elseif (strcmp(instruction_screen,'Break'))
    
    instructions = imread('Instructions_BreakA.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait(-3, 2, GetSecs()+50);
    
    instructions = imread('Instructions_BreakB.png');
    instructions_screen = Screen('MakeTexture',windowPtr,instructions);
    
    Screen('DrawTexture',windowPtr,instructions_screen);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait(-3, 2, GetSecs()+10);
    
    
end


end

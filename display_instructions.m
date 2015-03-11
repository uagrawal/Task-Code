function display_instructions(windowPtr,instruction_screen)

solid_black = imread('solid_black.png');
solid_black_screen = Screen('MakeTexture',windowPtr,solid_black);

if (instruction_screen == 1)
    
    instructions_1 = imread('tACS_Instructions_1.png');
    instructions_screen_1 = Screen('MakeTexture',windowPtr,instructions_1);
    
    Screen('DrawTexture',windowPtr,instructions_screen_1);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
    
elseif (instruction_screen == 2)
    
    instructions_2 = imread('tACS_Instructions_2.png');
    instructions_screen_2 = Screen('MakeTexture',windowPtr,instructions_2);
    
    Screen('DrawTexture',windowPtr,instructions_screen_2);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
elseif (instruction_screen == 3)
    
    
    instructions_3 = imread('tACS_Instructions_3.png');
    instructions_screen_3 = Screen('MakeTexture',windowPtr,instructions_3);
    
    Screen('DrawTexture',windowPtr,instructions_screen_3);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
elseif (instruction_screen == 3.5)
    
    
    instructions_3a = imread('tACS_Instructions_3.5.png');
    instructions_screen_3a = Screen('MakeTexture',windowPtr,instructions_3a);
    
    Screen('DrawTexture',windowPtr,instructions_screen_3a);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
elseif (instruction_screen == 4)
    
    instructions_4 = imread('tACS_Instructions_4.png');
    instructions_screen_4 = Screen('MakeTexture',windowPtr,instructions_4);
    
    Screen('DrawTexture',windowPtr,instructions_screen_4);
    Screen(windowPtr,'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+600);
    
elseif (instruction_screen == 5)
    
    instructions_5 = imread('tACS_Instructions_5.png');
    instructions_screen_5 = Screen('MakeTexture',windowPtr,instructions_5);
    
    Screen('DrawTexture',windowPtr,instructions_screen_5);
    Screen(windowPtr, 'Flip');
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+6000);
    
    if (wait_2(8) == 1)
        
        return
        
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
    
    [wait_1, wait_2, wait_3] = KbWait([], 2, GetSecs()+6000);
    
end

%Screen('CloseAll')


end

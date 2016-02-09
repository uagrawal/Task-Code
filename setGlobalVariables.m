function setGlobalVariables()

global screens
global initial_time

% screens = 0 if running task on one laptop
% screens = 1 if running task on laptop and projecting to a monitor
% 1 (preferred)
screens = 1;

% Variable to keep track of the timestamps of each of the stimuli, can
% compare with open ephys timestamps 
initial_time = GetSecs();
save('initial_time')



end
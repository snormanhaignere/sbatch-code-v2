function wait_until_fewer_than_N_processes_are_running(username, max_num_processes)

% Checks if maximum number of processes exceeded
% Doesn't return until number of processes falls below the maximum. 

while 1
    
    % Wait 2 seconds
    pause(0.5);
    
    % List current jobs from a specific user
    [~,x] = unix(['squeue -u ' username]);
    if length(strfind(x,username)) < max_num_processes
        break;
    end
end




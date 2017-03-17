function job_started = call_sbatch_smart(B)

% 2017-03-17: Modified to return whether job successfully started

% check if the job is already running
if is_job_running(B.job_id);
    job_started = false;
    return;
end

% wait until fewer then a set number of jobs are running
% to prevent fludding the suerver
wait_until_fewer_than_N_processes_are_running('svnh', B.max_num_process);

% call sbatch
call_sbatch(B);
job_started = true;
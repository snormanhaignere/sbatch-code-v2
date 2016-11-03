function call_sbatch_smart(B)

% check if the job is already running
if is_job_running(B.job_id);
    return;
end

% wait until fewer then a set number of jobs are running
% to prevent fludding the suerver
wait_until_fewer_than_N_processes_are_running('svnh', B.max_num_process);

% call sbatch
call_sbatch(B);
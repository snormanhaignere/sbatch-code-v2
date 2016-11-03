function job_running = is_job_running(job_id)

% Checks if a job is already running
[~,x] = unix('squeue -u svnh -o %j');
job_running = ~isempty(strfind(x,job_id));
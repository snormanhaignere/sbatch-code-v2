function batch_file = create_sbatch_file(B)

B = default_batch_parameters(B);

% open batch file
batch_file = [B.batch_directory '/' B.job_id '.sbatch'];
fid = fopen(batch_file,'w');

% B.batch_directory = escape_special_characters(B.batch_directory);
% B.directory_to_run_from = escape_special_characters(B.directory_to_run_from);

% bash flag
fprintf(fid, '#!/bin/bash\n');

% parameters
fprintf(fid, ['#SBATCH --job-name=' B.job_id '\n']);
fprintf(fid, ['#SBATCH --output="' [B.batch_directory '/' B.job_id] '"-%%j.out\n']);
fprintf(fid, ['#SBATCH --error="' [B.batch_directory '/' B.job_id] '"-%%j.err\n']);
fprintf(fid, ['#SBATCH --mem=' B.mem '\n']);
fprintf(fid, ['#SBATCH --nodes=' B.n_nodes '\n']);
fprintf(fid, ['#SBATCH --cpus-per-task=' B.cpus_per_task '\n']);
fprintf(fid, ['#SBATCH --exclude=' B.nodes_to_exclude '\n']);
fprintf(fid, ['#SBATCH --time=' B.max_run_time_in_min '\n']); % 2-day, maximum

% cd to appropriate directory
fprintf(fid, ['cd "' fileparts(which('create_sbatch_file.m')) '"\n']);

% command
MAT_file = [B.batch_directory '/' B.job_id '.mat'];
save(MAT_file, 'B');
B.command = ['matlab -nodesktop -nosplash -singleCompThread -r ' ...
    '"sbatch_matlab_wrapper(''' MAT_file '''), exit"\n'];
% B.command = format_matlab_command(B.matlab_fn, B.matlab_fn_args);
fprintf(fid, B.command);

% close file
fclose(fid);

function B = default_batch_parameters(B)

% default parameters
if ~isfield(B, 'mem');
    B.mem = '4000';
end

if ~isfield(B, 'n_nodes');
    B.n_nodes = '1';
end

if ~isfield(B, 'cpus_per_task');
    B.cpus_per_task = '1';
end

if ~isfield(B, 'nodes_to_exclude');
    B.nodes_to_exclude = '';
end

if ~isfield(B, 'max_run_time_in_min');
    B.max_run_time_in_min = num2str(60*24*2);
end
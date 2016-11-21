function sbatch_matlab_wrapper(MAT_file)

% Just runs the desired function with specified arguments

load(MAT_file, 'B');
cd(B.directory_to_run_from);
ls
drawnow;
B.matlab_fn(B.matlab_fn_args{:});
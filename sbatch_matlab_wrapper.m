function sbatch_matlab_wrapper(MAT_file)

% Just runs the desired function with specified arguments

load(MAT_file, 'B');
B.matlab_fn(B.matlab_fn_args{:});
function call_sbatch(B)

batch_file = create_sbatch_file(B);
unix(['sbatch "' batch_file '"']);

function command = format_matlab_command(fn_name, fn_args)

fn_arg_string = '';
for i = 1:length(fn_args);
    if ischar( fn_args{i} )
        fn_arg_string = [ fn_arg_string, '''' fn_args{i} '''' ]; %#ok<*AGROW>
    elseif isnumeric( fn_args{i} ) && isvector( fn_args{i} )
        if ~isrow(fn_args{i});
            fn_args{i} = fn_args{i}';
        end
        fn_arg_string = [ fn_arg_string, '[' num2str(fn_args{i}) ']' ];
    else
        error('Only strings and scalars/vectors supported');
    end
    if i < length(fn_args)
        fn_arg_string = [fn_arg_string, ','];
    end
end

command = ['matlab -nodesktop -nosplash -singleCompThread -r ' ...
    '"' fn_name '(' fn_arg_string '), exit"\n'];

% version 1
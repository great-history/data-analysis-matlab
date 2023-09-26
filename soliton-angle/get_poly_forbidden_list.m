function poly_forbidden_list = get_poly_forbidden_list(data_left_end_forbidden_cell, data_right_end_forbidden_cell, num_line)
    poolobj = gcp('nocreate');
    poly_forbidden_list = [];
    if ~isempty(poolobj)
        parfor line_index = 1:num_line
            poly1 = polyshape([data_left_end_forbidden_cell{line_index}(1, :), fliplr(data_right_end_forbidden_cell{line_index}(1, :))], ...
                              [data_left_end_forbidden_cell{line_index}(2, :), fliplr(data_right_end_forbidden_cell{line_index}(2, :))]);
            poly_forbidden_list = [poly_forbidden_list, poly1];
        end
    else
        for line_index = 1:num_line
            poly1 = polyshape([data_left_end_forbidden_cell{line_index}(1, :), fliplr(data_right_end_forbidden_cell{line_index}(1, :))], ...
                              [data_left_end_forbidden_cell{line_index}(2, :), fliplr(data_right_end_forbidden_cell{line_index}(2, :))]);
            poly_forbidden_list = [poly_forbidden_list, poly1];
        end
    end
end
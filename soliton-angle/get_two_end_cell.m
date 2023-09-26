function [data_left_end_cell, data_right_end_cell] = get_two_end_cell(data_line_x_cell, data_line_y_cell, num_line, half_width)
    data_left_end_cell = cell(num_line, 1);
    data_right_end_cell = cell(num_line, 1);

    for line_index = 1:num_line
        data_line_x_list = data_line_x_cell{line_index}';
        data_line_y_list = data_line_y_cell{line_index}';
        num_point_per_line = size(data_line_x_list, 1);
        [data_left_end_list, data_right_end_list] = get_two_end_list(data_line_x_list, data_line_y_list, num_point_per_line, 1, half_width);
        data_left_end_cell{line_index} = data_left_end_list;
        data_right_end_cell{line_index} = data_right_end_list;
    end
    
end
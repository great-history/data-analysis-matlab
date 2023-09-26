function [data_left_end_list, data_right_end_list] = get_two_end_list(data_line_x_list, data_line_y_list, num_point_per_line, num_line, half_width)
    if num_line == 1
        mid_point_x_list = data_line_x_list';
        mid_point_y_list = data_line_y_list';
        [left_end_list, right_end_list] = get_two_end_list_per_line(mid_point_x_list, mid_point_y_list, half_width);
        
        data_left_end_list = left_end_list;
        data_right_end_list = right_end_list;
    else
        data_left_end_list = zeros(2, num_point_per_line, num_line);
        data_right_end_list = zeros(2, num_point_per_line, num_line);

        for line_index = 1:num_line
            mid_point_x_list = data_line_x_list(:, line_index)';
            mid_point_y_list = data_line_y_list(:, line_index)';
            [left_end_list, right_end_list] = get_two_end_list_per_line(mid_point_x_list, mid_point_y_list, half_width);

            data_left_end_list(:, :, line_index) = left_end_list;
            data_right_end_list(:, :, line_index) = right_end_list;
        end

    end
end
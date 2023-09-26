function seg_length_cell = get_seg_length_cell(data_line_segment_x_cell, data_line_segment_y_cell, num_seg)
    seg_length_cell = cell(num_seg, 1);
    
    for line_index = 1:num_seg
        data_line_x = data_line_segment_x_cell{line_index};
        data_line_y = data_line_segment_y_cell{line_index};
        num_point_per_line = length(data_line_x);
        
        line_length_list = zeros(1, num_point_per_line);
        for point_index = 2:num_point_per_line
            delta_length = (data_line_x(point_index) - data_line_x(point_index - 1)) ^ 2 + ...
                           (data_line_y(point_index) - data_line_y(point_index - 1)) ^ 2;
            delta_length = sqrt(delta_length);
            line_length_list(point_index) = line_length_list(point_index - 1) + delta_length; % 长度累加
        end
        seg_length_cell{line_index} = line_length_list;
    end
end
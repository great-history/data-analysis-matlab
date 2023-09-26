function crossing_info_cell = find_crossing_lines(intersect_point_array, num_line)
    crossing_info_cell = cell(num_line, 2); % 第一列存放的是交叉线指标，第二列存放的是交叉点的位置
    for line_index1 = 1:num_line
        current_index_list = [];
        current_pos_list = [];
        
        for line_index2 = 1:num_line
            if isnan(intersect_point_array(line_index1, line_index2, 1))
                continue
            else
                current_index_list = [current_index_list, line_index2];
                current_pos_list = [current_pos_list, intersect_point_array(line_index1, line_index2, :)];
            end
        end
        current_pos_list = reshape(current_pos_list, [size(current_pos_list, 2), size(current_pos_list, 3)]);
        crossing_info_cell{line_index1, 1} = current_index_list;
        crossing_info_cell{line_index1, 2} = current_pos_list;
    end
end
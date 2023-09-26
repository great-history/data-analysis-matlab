function line_num_point_list = get_line_num_point_list_by_cell(seg_length_cell, num_seg)
    line_num_point_list = zeros(1, num_seg);
    
    % min_length = seg_length_cell{1}(end) / (length(seg_length_cell{1}) - 1); % 相邻两点之间的最短距离
    min_length = seg_length_cell{1}(2) - seg_length_cell{1}(1); % 相邻两点之间的最短距离

    for line_index = 1:num_seg
        num_per_line = length(seg_length_cell{line_index});
        for point_index = 2:num_per_line
            current_length = seg_length_cell{line_index}(point_index) - seg_length_cell{line_index}(point_index - 1);
            if current_length < min_length
                min_length = current_length; % 相邻两点间的最短距离
                % min_points = length(seg_length_cell{line_index});
            end
        end
    end
    
    for line_index = 1:num_seg
        current_length = seg_length_cell{line_index}(end);
        line_num_point_list(line_index) = round(current_length / min_length) + 1;
    end
    
end
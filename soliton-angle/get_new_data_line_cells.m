function [data_line_x_cell, data_line_y_cell, data_line_ang_cell] = ...
            get_new_data_line_cells(data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell, ...
                                    seg_length_cell, line_num_point_list, num_seg)
    % 进行插值得到新的(x,y)点和angle值
    data_line_x_cell = cell(num_seg, 1);
    data_line_y_cell = cell(num_seg, 1);
    data_line_ang_cell = cell(num_seg, 1);
    
    for line_index = 1:num_seg
        line_length = seg_length_cell{line_index}(end); % 当前折线总长
        num_points = line_num_point_list(line_index);

        line_x_list_old = data_line_segment_x_cell{line_index}; % 当前折线上每个点的X坐标
        line_y_list_old = data_line_segment_y_cell{line_index}; % 当前折线上每个点的Y坐标
        line_ang_list_old = data_line_segment_ang_cell{line_index}; % 当前折线上每个点对应的角度值
        line_len_list_old = seg_length_cell{line_index};

        line_len_list_new = linspace(0, line_length, num_points); % 新的点
        line_x_list_new = interp1(line_len_list_old, line_x_list_old, line_len_list_new, 'linear');
        line_y_list_new = interp1(line_len_list_old, line_y_list_old, line_len_list_new, 'linear');
        line_ang_list_new = interp1(line_len_list_old, line_ang_list_old, line_len_list_new, 'linear');

        data_line_x_cell{line_index} = line_x_list_new;
        data_line_y_cell{line_index} = line_y_list_new;
        data_line_ang_cell{line_index} = line_ang_list_new;
    end
end
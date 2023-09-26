function [data_line_x_cell, data_line_y_cell, data_line_ang_cell, num_line, num_point_per_line] = read_line_file(angle_file_path, num_point_per_line)
    data_ = readmatrix(angle_file_path); %读取数据构成矩阵
    num_linepoint = size(data_, 1);
    num_line = num_linepoint / num_point_per_line;
    % num_point_per_line = 500;

    data_line_ang_list = data_(:,3);
    data_line_ang_list = reshape(data_line_ang_list, [num_point_per_line, num_line]);
    data_line_x_list = data_(:,1);
    data_line_x_list = reshape(data_line_x_list, [num_point_per_line, num_line]);
    data_line_y_list = data_(:,2);
    data_line_y_list = reshape(data_line_y_list, [num_point_per_line, num_line]);

    data_line_x_cell = cell(num_line, 1);
    data_line_y_cell = cell(num_line, 1);
    data_line_ang_cell = cell(num_line, 1);
    for line_index = 1:num_line
        data_line_x_cell{line_index} = data_line_x_list(:, line_index)';
        data_line_y_cell{line_index} = data_line_y_list(:, line_index)';
        data_line_ang_cell{line_index} = data_line_ang_list(:, line_index)';
    end
end
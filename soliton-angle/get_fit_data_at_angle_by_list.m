function interp_val_angle_mat = get_fit_data_at_angle_by_list(data_left_end_list, data_right_end_list, point_index_list, interp_func, num_interp_half)    
    %% 计算平均值
    count = length(point_index_list);
    interp_val_angle_mat = zeros(count, 2 * num_interp_half - 1);
    for ii = 1:count
        point_index = point_index_list(ii);

        left_end_x = data_left_end_list(1, point_index);
        left_end_y = data_left_end_list(2, point_index);
        right_end_x = data_right_end_list(1, point_index);
        right_end_y = data_right_end_list(2, point_index);

        interp_x_list = linspace(left_end_x, right_end_x, 2 * num_interp_half - 1);
        interp_y_list = linspace(left_end_y, right_end_y, 2 * num_interp_half - 1);
        
        % interp_val_list = interp2(data_x, data_y, data_mag, interp_x_list, interp_y_list, 'spline'); % interp2只能对网格进行拟合
        interp_val_list = interp_func(interp_x_list, interp_y_list);

        interp_val_angle_mat(ii, :) = interp_val_list;
    end
end
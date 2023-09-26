function select_index_list = get_select_index_list_by_angle(data_ang, ang_left_bound, ang_right_bound, num_points)
    select_index_list = [];
    for point_index = 1:num_points
        current_ang = data_ang(point_index);
        if current_ang > ang_left_bound && current_ang <= ang_right_bound
            select_index_list = [select_index_list, point_index];
        end
    end
    
end
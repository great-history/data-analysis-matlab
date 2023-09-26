function angle_select_index_list = find_angle_select_index(ang_list, angle_select_list)
    angle_select_index_list = zeros(size(angle_select_list));
    for ii = 1:length(angle_select_list)
        current_angle = angle_select_list(ii);
        ang_substract_list = ang_list - current_angle;
        [~, find_index] = min(abs(ang_substract_list));

        angle_select_index_list(ii) = find_index;
    end
end
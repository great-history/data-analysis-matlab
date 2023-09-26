function [data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell, data_line_segment_left_end_cell, data_line_segment_right_end_cell, num_seg] = ...
                    remove_close_points(data_left_end_cell, data_right_end_cell, data_line_x_cell, data_line_y_cell, data_line_ang_cell, num_line)
    data_line_segment_left_end_cell = {};
    data_line_segment_right_end_cell = {};
    data_line_segment_x_cell = {};
    data_line_segment_y_cell = {};
    data_line_segment_ang_cell = {};

    count_seg = 0;
    for line_index = 1:num_line
        flag_seg = false;

        current_left_end_list = data_left_end_cell{line_index};
        current_right_end_list = data_right_end_cell{line_index};
        current_mid_x_list = data_line_x_cell{line_index};
        current_mid_y_list = data_line_y_cell{line_index};
        current_mid_ang_list = data_line_ang_cell{line_index};

        num_point_per_line = size(current_left_end_list, 2);

        for point_index = 1:num_point_per_line
            if isnan(current_left_end_list(1, point_index))
                if flag_seg % 线段结束
                    flag_seg = false;
                    if size(current_line_segment_mid_x, 2) >= 2  % 至少要有两个点
                        count_seg = count_seg + 1;
                        data_line_segment_x_cell{count_seg, 1} = current_line_segment_mid_x;
                        data_line_segment_y_cell{count_seg, 1} = current_line_segment_mid_y;
                        data_line_segment_ang_cell{count_seg, 1} = current_line_segment_mid_ang;
                        data_line_segment_left_end_cell{count_seg, 1} = current_line_segment_left_end;
                        data_line_segment_right_end_cell{count_seg, 1} = current_line_segment_right_end;
                    end
                end

            else
                if ~flag_seg % 线段开始
                    flag_seg = true;
                    current_line_segment_mid_x = [];
                    current_line_segment_mid_y = [];
                    current_line_segment_mid_ang = [];
                    current_line_segment_left_end = [];
                    current_line_segment_right_end = [];
                end

                current_line_segment_mid_x = [current_line_segment_mid_x, current_mid_x_list(point_index)];
                current_line_segment_mid_y = [current_line_segment_mid_y, current_mid_y_list(point_index)];
                current_line_segment_mid_ang = [current_line_segment_mid_ang, current_mid_ang_list(point_index)];
                current_line_segment_left_end = [current_line_segment_left_end, current_left_end_list(:, point_index)];
                current_line_segment_right_end = [current_line_segment_right_end, current_right_end_list(:, point_index)];
            end
        end

        if flag_seg
            if size(current_line_segment_mid_x, 2) >= 2  % 至少要有两个点
                count_seg = count_seg + 1;
                data_line_segment_x_cell{count_seg, 1} = current_line_segment_mid_x;
                data_line_segment_y_cell{count_seg, 1} = current_line_segment_mid_y;
                data_line_segment_ang_cell{count_seg, 1} = current_line_segment_mid_ang;
                data_line_segment_left_end_cell{count_seg, 1} = current_line_segment_left_end;
                data_line_segment_right_end_cell{count_seg, 1} = current_line_segment_right_end;
            end
        end
    end

    num_seg = count_seg;
end
function [data_left_end_cell, data_right_end_cell] = find_close_points(data_left_end_cell, data_right_end_cell, data_line_x_cell, data_line_y_cell, crossing_info_cell, poly_forbidden_list, num_line)
    poolobj = gcp('nocreate');
    if ~isempty(poolobj)
        parfor line_index = 1:num_line  % 用8个核可以加速5倍左右
            current_left_end_list = data_left_end_cell{line_index};
            current_right_end_list = data_right_end_cell{line_index};
            % current_mid_point_x_list = data_line_x_cell{line_index};
            % current_mid_point_y_list = data_line_y_cell{line_index};
            num_point_per_line = size(current_left_end_list, 2);
            current_crossing_index_list = crossing_info_cell{line_index, 1};

            for poly_index = 1:num_line
                if poly_index == line_index % 同一条线不考虑
                    continue
                end

                if ~ismember(poly_index, current_crossing_index_list)
                    continue
                end

                poly1 = poly_forbidden_list(poly_index);
                for point_index = 1:num_point_per_line
                    if isnan(current_left_end_list(1, point_index)) % 这个点已经被舍弃了
                        continue
                    end


                    lineseg = [current_left_end_list(1, point_index) current_left_end_list(2, point_index); current_right_end_list(1, point_index) current_right_end_list(2, point_index)];
                    [in, ~] = intersect(poly1, lineseg);

                    % 如果存在交点，那么就舍弃这个点（不好）
                    % 如果存在交点，那么试着做一下截断，如果做不了才舍弃
                    if ~(isempty(in))
                        current_left_end_list(1, point_index) = nan;
                        current_left_end_list(2, point_index) = nan;
                        current_right_end_list(1, point_index) = nan;
                        current_right_end_list(2, point_index) = nan;
                    end
                end

            end

            data_left_end_cell{line_index} = current_left_end_list;
            data_right_end_cell{line_index} = current_right_end_list;
        end
    else
        for line_index = 1:num_line
            current_left_end_list = data_left_end_cell{line_index};
            current_right_end_list = data_right_end_cell{line_index};
            current_mid_point_x_list = data_line_x_cell{line_index};
            current_mid_point_y_list = data_line_y_cell{line_index};
            num_point_per_line = size(current_left_end_list, 2);
            current_crossing_index_list = crossing_info_cell{line_index, 1};

            for poly_index = 1:num_line
                if poly_index == line_index % 同一条线不考虑
                    continue
                end

                if ~ismember(poly_index, current_crossing_index_list)
                    continue
                end

                poly1 = poly_forbidden_list(poly_index);
                for point_index = 1:num_point_per_line
                    if isnan(current_left_end_list(1, point_index)) % 这个点已经被舍弃了
                        continue
                    end


                    lineseg = [current_left_end_list(1, point_index) current_left_end_list(2, point_index); current_right_end_list(1, point_index) current_right_end_list(2, point_index)];
                    [in, ~] = intersect(poly1, lineseg);

                    % 如果存在交点，那么就舍弃这个点（不好）
                    % 如果存在交点，那么试着做一下截断，如果做不了才舍弃
                    if ~(isempty(in))
                        current_left_end_list(1, point_index) = nan;
                        current_left_end_list(2, point_index) = nan;
                        current_right_end_list(1, point_index) = nan;
                        current_right_end_list(2, point_index) = nan;
                    end
                end

            end

            data_left_end_cell{line_index} = current_left_end_list;
            data_right_end_cell{line_index} = current_right_end_list;
        end
    end
    
end
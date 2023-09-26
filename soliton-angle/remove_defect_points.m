function [data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell, num_seg] = ...
                    remove_defect_points(data_line_x_cell, data_line_y_cell, data_line_ang_cell, defect_region_poly, num_line)
    data_line_segment_x_cell = {};
    data_line_segment_y_cell = {};
    data_line_segment_ang_cell = {};

    count_seg = 0;
    % 确定那几条曲线与defect_region相交,并得到新的数据
    for line_index = 1:num_line
        flag_seg = false;
        current_mid_x_list = data_line_x_cell{line_index};
        current_mid_y_list = data_line_y_cell{line_index};
        current_line_seg = [transpose(current_mid_x_list), transpose(current_mid_y_list)];
        current_ang_list = data_line_ang_cell{line_index};
        % num_point_per_line = size(current_line_seg, 1);

        [in,out] = intersect(defect_region_poly, current_line_seg);
        for ii = 1:size(out, 1)
            if isnan(out(ii,1))
                if size(in, 1) > 2 % in要存在至少三个点才有必要真正被看作两端
                    flag_seg = true;
                    % len_seg_list = [ii - 2, size(out, 1) - ii - 1];
                    % disp([line_index, "有两断"])
                    break
                end
            end
        end
        
        if flag_seg
            % 寻找in对应的指标范围
            index1 = find(current_line_seg == in(2,1));
            index2 = find(current_line_seg == in(end - 1,1));
            index_start = min(index1, index2);
            index_end = max(index1, index2);
            
            % 存放两端segment
            count_seg = count_seg + 1;
            data_line_segment_x_cell{count_seg} = current_mid_x_list(1:index_start);
            data_line_segment_y_cell{count_seg} = current_mid_y_list(1:index_start);
            data_line_segment_ang_cell{count_seg} = current_ang_list(1:index_start);
            
            % data_line_x_cell_new{count_seg} = fliplr(transpose(out(1:(ii-2), 1))); % 要进行一次倒叙，否则角度和坐标对不上
            % data_line_y_cell_new{count_seg} = fliplr(transpose(out(1:(ii-2), 2))); % 要进行一次倒叙，否则角度和坐标对不上
            % data_line_ang_cell_new{count_seg} = current_ang_list(end + 1 - len_seg_list(1):end);
            % data_line_x_cell_new{count_seg} = current_mid_x_list(1:len_seg_list(1));
            % data_line_y_cell_new{count_seg} = current_mid_y_list(1:len_seg_list(1));

            count_seg = count_seg + 1;
            data_line_segment_x_cell{count_seg} = current_mid_x_list(index_end:end);
            data_line_segment_y_cell{count_seg} = current_mid_y_list(index_end:end);
            data_line_segment_ang_cell{count_seg} = current_ang_list(index_end:end);
            
            % data_line_x_cell_new{count_seg} = fliplr(transpose(out((ii + 2):end, 1)));
            % data_line_y_cell_new{count_seg} = fliplr(transpose(out((ii + 2):end, 2)));
            % data_line_ang_cell_new{count_seg} = current_ang_list(1:len_seg_list(2));
            % data_line_x_cell_new{count_seg} = current_mid_x_list(end + 1 - len_seg_list(2):end);
            % data_line_y_cell_new{count_seg} = current_mid_y_list(end + 1 - len_seg_list(2):end);
            % data_line_ang_cell_new{count_seg} = current_ang_list(end + 1 - len_seg_list(2):end);
        else
            count_seg = count_seg + 1;
            data_line_segment_x_cell{count_seg} = current_mid_x_list;
            data_line_segment_y_cell{count_seg} = current_mid_y_list;
            data_line_segment_ang_cell{count_seg} = current_ang_list;
        end
    end

    num_seg = count_seg;
end
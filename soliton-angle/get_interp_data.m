function [interp_av_value_array, std_error_array, skip_ang_index_list] = get_interp_data(interp_func, data_line_left_end_list, data_line_right_end_list, data_line_ang_list, ...
                                                                                         ang_hist, thre_num, num_angle, num_interp_half, num_linepoint, type)
    poolobj = gcp('nocreate');
    interp_av_value_array = zeros(num_angle, 2 * num_interp_half - 1);
    std_error_array = zeros(num_angle, 2 * num_interp_half - 1);

    % thre_num = 0; % 样本数量少于thre_num的angle将跳过，之后用插值去得到
    skip_ang_index_list = zeros(num_angle, 1);
    if ~isempty(poolobj)
        parfor ang_index = 1:num_angle % 并行之后快了3倍
            % select_ang = ang_list(ang_index);
            ang_left_bound = ang_hist.BinEdges(ang_index);
            ang_right_bound = ang_hist.BinEdges(ang_index + 1);
            select_index_list = get_select_index_list_by_angle(data_line_ang_list, ang_left_bound, ang_right_bound, num_linepoint);
            if length(select_index_list) <= thre_num
                skip_ang_index_list(ang_index) = 1;
                continue
            end

            %% 在当前角度下进行插值
            interp_val_angle_mat = get_fit_data_at_angle_by_list(data_line_left_end_list, data_line_right_end_list, select_index_list, interp_func, num_interp_half);
            %% 对称化处理
            interp_val_angle_mat = get_data_symmetry(interp_val_angle_mat, num_interp_half);
            %% 平均化处理
            interp_val_av_angle = sum(interp_val_angle_mat, 1) / length(select_index_list);
            %% 计算标准差
            % std_error_list = get_std_error_list(interp_val_angle_mat, interp_val_av_angle);
            se_error_list = get_se_list(interp_val_angle_mat);
            %% 存放数据
            interp_av_value_array(ang_index, :) = interp_val_av_angle;
            std_error_array(ang_index, :) = se_error_list;
        end
    else
        for ang_index = 1:num_angle % 并行之后快了3倍
            % select_ang = ang_list(ang_index);
            ang_left_bound = ang_hist.BinEdges(ang_index);
            ang_right_bound = ang_hist.BinEdges(ang_index + 1);
            select_index_list = get_select_index_list_by_angle(data_line_ang_list, ang_left_bound, ang_right_bound, num_linepoint);
            if length(select_index_list) <= thre_num
                skip_ang_index_list(ang_index) = 1;
                continue
            end

            %% 在当前角度下进行插值
            interp_val_angle_mat = get_fit_data_at_angle_by_list(data_line_left_end_list, data_line_right_end_list, select_index_list, interp_func, num_interp_half);
            %% 对称化处理
            interp_val_angle_mat = get_data_symmetry(interp_val_angle_mat, num_interp_half);
            %% 平均化处理
            interp_val_av_angle = sum(interp_val_angle_mat, 1) / length(select_index_list);
            %% 计算标准差
            % std_error_list = get_std_error_list(interp_val_angle_mat, interp_val_av_angle);
            se_error_list = get_se_list(interp_val_angle_mat);
            %% 存放数据
            interp_av_value_array(ang_index, :) = interp_val_av_angle;
            std_error_array(ang_index, :) = se_error_list;
        end
    end
    
    if type == "renorm"
        for ang_index = 1:num_angle
            se_renorm_y = (std_error_array(ang_index, end) / interp_av_value_array(ang_index, end))^2; % renorm
            for ii = 1:size(interp_av_value_array, 2)
                se_renorm_x = (std_error_array(ang_index, ii) / interp_av_value_array(ang_index, ii))^2;
                std_error_array(ang_index, ii) = interp_av_value_array(ang_index, ii) / interp_av_value_array(ang_index, end) * sqrt(se_renorm_y + se_renorm_x);
            end
            
            % 这异步要放到se_renorm计算完之后在进行
            interp_av_value_array(ang_index, :) = interp_av_value_array(ang_index, :) / interp_av_value_array(ang_index, end); % 已经经过对称化处理，1和end是一样的
        end
    end
end
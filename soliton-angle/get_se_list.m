function se_error_list = get_se_list(interp_val_angle_mat)
    [count, dims] = size(interp_val_angle_mat);
    se_error_list = zeros(1, dims);
    
    if count >= 2
        % 计算std(standard deviation),然后计算se(standard error)
        % https://ww2.mathworks.cn/help/matlab/ref/std.html
        %         for x_index = 1:dims
        %             std_error = 0.0;
        %             for ii = 1:count
        %                 std_error = std_error + (interp_val_angle_mat(ii, x_index) - interp_val_av_angle(x_index))^2;
        %             end
        %             std_error = sqrt(std_error / (count - 1));
        %             std_error_list(x_index) = std_error;
        %         end
        
        for x_index = 1:dims % 对每个x处的所有值计算标准差
            std_error = std(interp_val_angle_mat(:, x_index)); % 这一步是计算出standard deviation
            se_error_list(x_index) = std_error / sqrt(count); % 这一步是计算出standard error
        end
    end
end


% function std_error_list = get_std_error_list(interp_val_angle_mat, interp_val_av_angle)
%     [count, dims] = size(interp_val_angle_mat);
%     std_error_list = zeros(1, dims);
%     
%     if count >= 2
%         % 计算std(standard deviation),然后计算se(standard error)
%         % https://ww2.mathworks.cn/help/matlab/ref/std.html
%         %         for x_index = 1:dims
%         %             std_error = 0.0;
%         %             for ii = 1:count
%         %                 std_error = std_error + (interp_val_angle_mat(ii, x_index) - interp_val_av_angle(x_index))^2;
%         %             end
%         %             std_error = sqrt(std_error / (count - 1));
%         %             std_error_list(x_index) = std_error;
%         %         end
%         end
%     end
% end
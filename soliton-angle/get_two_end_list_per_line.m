function [left_end_list, right_end_list] = get_two_end_list_per_line(mid_point_x_list, mid_point_y_list, half_width)
    vertical_slope_list = get_slope_list(mid_point_x_list, mid_point_y_list);
    
    num_points = size(mid_point_x_list, 2);
    
    left_end = zeros(2,1);
    right_end = zeros(2,1);
    
    left_end_list = zeros(2, num_points);
    right_end_list = zeros(2, num_points);
    
    for point_index = 1:num_points
        mid_point_x = mid_point_x_list(point_index);
        mid_point_y = mid_point_y_list(point_index);
        
        slope_av = vertical_slope_list(point_index);
        % 计算两个end
        if slope_av == inf
            left_end(1) = mid_point_x;
            left_end(2) = mid_point_y - half_width;
            
            right_end(1) = mid_point_x;
            right_end(2) = mid_point_y + half_width;

        else
            delta_x = half_width / sqrt(1 + (slope_av)^2);
            delta_y = delta_x * slope_av;

            left_end(1) = mid_point_x - delta_x;
            left_end(2) = mid_point_y - delta_y;

            right_end(1) = mid_point_x + delta_x;
            right_end(2) = mid_point_y + delta_y;

        end
        
        left_end_list(:, point_index) = left_end;
        right_end_list(:, point_index) = right_end;
    end
    
end

% fig2 = figure;
% sz = 1;
% clr = linspace(min(data_cell{2}(1:1000,3)),max(data_cell{2}(1:1000,3)),1000);
% % scatter(data_line_x(1:511), data_line_y(1:511), sz)
% hold on
% 
% plot(data_line_x(:, line_index), data_line_y(:, line_index))
% hold on
% plot([left_end_list(1,:), right_end_list(1,:)], [left_end_list(2,:), right_end_list(2,:)])
% poly1 = polyshape([left_end_list(1,:), right_end_list(1,:)], [left_end_list(2,:), right_end_list(2,:)]);

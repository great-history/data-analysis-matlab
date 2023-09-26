function vertical_slope_list = get_slope_list(mid_point_x_list_test, mid_point_y_list_test)
    num_points = size(mid_point_x_list_test, 2);
    vertical_slope_list = zeros(num_points, 1);
    
    for point_index = 1:num_points
        if point_index == 1
            slope_av = get_slope_by_2point([mid_point_x_list_test(point_index), mid_point_x_list_test(point_index + 1)], ...
                                           [mid_point_y_list_test(point_index), mid_point_y_list_test(point_index + 1)]);
        elseif point_index == num_points
            slope_av = get_slope_by_2point([mid_point_x_list_test(point_index), mid_point_x_list_test(point_index - 1)], ...
                                           [mid_point_y_list_test(point_index), mid_point_y_list_test(point_index - 1)]);
        else
            slope1 = get_slope_by_2point([mid_point_x_list_test(point_index), mid_point_x_list_test(point_index + 1)], ...
                                         [mid_point_y_list_test(point_index), mid_point_y_list_test(point_index + 1)]);
            slope2 = get_slope_by_2point([mid_point_x_list_test(point_index), mid_point_x_list_test(point_index - 1)], ...
                                         [mid_point_y_list_test(point_index), mid_point_y_list_test(point_index - 1)]);
            
            % 注意：90°左右的两个slope直接相加会得到一个slope=0的情况，这种情况要避免
            if sign(slope1) * sign(slope2) < 0 % 这种情况会出现在90°和0°附近
                if abs(slope1) > 1 % 对应90°的情况
                    % ang1 = atand(slope1);
                    % if ang1 < 0
                    %     ang1 = ang1 + 180;
                    % end
                    % 
                    % ang2 = atand(slope2);
                    % if ang2 < 0
                    %     ang2 = ang2 + 180;
                    % end
                    % 
                    % ang_av = (ang1 + ang2) / 2;
                    % slope_av = tan(ang_av); 
                    
                    slope_av = inf; % 经过测试，发现直接赋值inf(即90°)会更加光滑
                else
                    slope_av = ( slope1 + slope2 ) / 2; 
                end
            else
                slope_av = ( slope1 + slope2 ) / 2; 
            end
            % slope_av = ( slope1 + slope2 ) / 2;                         
        end
        
        if slope_av == inf
            vertical_slope = 0.0;
        elseif slope_av == 0
            vertical_slope = inf;
        else
            vertical_slope = - 1 / slope_av;
        end
        
        vertical_slope_list(point_index) = vertical_slope;
    end
    
end
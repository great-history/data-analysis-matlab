function intersect_point_array = get_crossing_points_by_cell(data_left_end_cell, data_right_end_cell, num_line)
    poly_array = [];
    for line_index = 1:num_line
        current_poly = polyshape([data_left_end_cell{line_index}(1,:), fliplr(data_right_end_cell{line_index}(1,:))], ...
                                 [data_left_end_cell{line_index}(2,:), fliplr(data_right_end_cell{line_index}(2,:))]);
        poly_array = [poly_array, current_poly];
    end

    intersect_point_array = zeros(num_line, num_line, 2);
    for line_index1 = 1:num_line
        poly1 = poly_array(line_index1);
        intersect_point_array(line_index1, line_index1, 1) = nan;
        intersect_point_array(line_index1, line_index1, 2) = nan;

        for line_index2 = (line_index1+1):num_line
            poly2 = poly_array(line_index2);
            [x_intersect, y_intersect] = get_crossing_points(poly1, poly2);
            intersect_point_array(line_index1, line_index2, 1) = x_intersect;
            intersect_point_array(line_index1, line_index2, 2) = y_intersect;
            intersect_point_array(line_index2, line_index1, 1) = x_intersect;
            intersect_point_array(line_index2, line_index1, 2) = y_intersect;
            
%             polyout = intersect([poly1, poly2]);
%             if polyout.NumRegions == 1
%                 x_intersect = sum(polyout.Vertices(:,1)) / size(polyout.Vertices, 1);  % 因为half_width_eps取得足够小，所以平均一下就行了
%                 y_intersect = sum(polyout.Vertices(:,2)) / size(polyout.Vertices, 1);
%                 intersect_point_array(line_index1, line_index2, 1) = x_intersect;
%                 intersect_point_array(line_index1, line_index2, 2) = y_intersect;
%                 intersect_point_array(line_index2, line_index1, 1) = x_intersect;
%                 intersect_point_array(line_index2, line_index1, 2) = y_intersect;
%             elseif polyout.NumRegions >= 2
%                 disp("有两个交点？")
%             else
%                 intersect_point_array(line_index1, line_index2, 1) = nan;
%                 intersect_point_array(line_index1, line_index2, 2) = nan;
%                 intersect_point_array(line_index2, line_index1, 1) = nan;
%                 intersect_point_array(line_index2, line_index1, 2) = nan;
%             end
        end
    end

end

%% test
% for line_index1 = 1:num_line
%     poly1 = poly_array(line_index1);
%     
%     for line_index2 = 1:num_line
%         if line_index1 == line_index2
%             intersect_point_array(line_index1, line_index1, 1) = nan;
%             intersect_point_array(line_index1, line_index1, 2) = nan;
%         end
%         
%         poly2 = poly_array(line_index2);
%         polyout = intersect([poly1, poly2]);
%         
%         if polyout.NumRegions == 1
%             x_intersect = sum(polyout.Vertices(:,1)) / size(polyout.Vertices, 1);  % 因为half_width_eps取得足够小，所以平均一下就行了
%             y_intersect = sum(polyout.Vertices(:,2)) / size(polyout.Vertices, 1);
%             intersect_point_array(line_index1, line_index2, 1) = x_intersect;
%             intersect_point_array(line_index1, line_index2, 2) = y_intersect;
%         elseif polyout.NumRegions >= 2
%             disp("有两个交点？")
%         else
%             intersect_point_array(line_index1, line_index2, 1) = nan;
%             intersect_point_array(line_index1, line_index2, 2) = nan;
%         end
%     end
% end
% 
% check_symm = check_symm(intersect_point_array, 1e-8);
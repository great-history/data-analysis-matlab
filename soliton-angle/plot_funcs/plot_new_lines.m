function current_fig = plot_new_lines(data_line_mid_point_list, data_line_ang_list, data_left_end_cell, data_right_end_cell, range_list, num_seg)
    current_fig = figure;
    x_min = range_list(1);
    x_max = range_list(2);
    y_min = range_list(3); 
    y_max = range_list(4);
    
    subplot(1, 2, 1);
    axis([x_min - 0.2 x_max + 0.2 y_min - 0.2 y_max + 0.2])
    sizeMarker = 1;
    colorMarker = data_line_ang_list;   % 颜色渐变
    scatter(data_line_mid_point_list(1, :), data_line_mid_point_list(2, :), sizeMarker, colorMarker, 'o', 'filled')
    colorbar

    % hold on
    % for line_index = 1:num_seg
    %     plot(data_line_segment_x_cell{line_index}, data_line_segment_y_cell{line_index})
    % end

    subplot(1, 2, 2);
    hold on
    for line_index = 1:num_seg
        poly1 = polyshape([data_left_end_cell{line_index}(1,:), fliplr(data_right_end_cell{line_index}(1,:))], ...
                          [data_left_end_cell{line_index}(2,:), fliplr(data_right_end_cell{line_index}(2,:))]);
        plot(poly1)
    end
end
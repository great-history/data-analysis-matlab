function current_fig = plot_crossing_lines(data_line_x_cell, data_line_y_cell, crossing_info_cell, line_index)
    current_fig = figure;
    hold on
    % line_index = 1; % 31
    plot(data_line_x_cell{line_index}, data_line_y_cell{line_index});
    num_crossing_line = length(crossing_info_cell{line_index, 1});
    for ii = 1:num_crossing_line
        crossing_index = crossing_info_cell{line_index, 1}(ii);
        plot(data_line_x_cell{crossing_index}, data_line_y_cell{crossing_index});
    end
end
function current_fig = plot_forbidden_regions(data_left_end_eps_cell, data_right_end_eps_cell, data_line_x_cell, data_line_y_cell, num_line)
    current_fig = figure;
    hold on
    for line_index = 1:num_line
        poly1 = polyshape([data_left_end_eps_cell{line_index}(1,:), fliplr(data_right_end_eps_cell{line_index}(1,:))], ...
                          [data_left_end_eps_cell{line_index}(2,:), fliplr(data_right_end_eps_cell{line_index}(2,:))]);
        plot(poly1);

        plot(data_line_x_cell{line_index}, data_line_y_cell{line_index});
    end

end
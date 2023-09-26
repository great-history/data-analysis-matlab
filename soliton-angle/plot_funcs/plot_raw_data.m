function current_fig = plot_raw_data(data_mesh_x, data_mesh_y, data_mesh_mag, range_list, data_line_x_cell, data_line_y_cell, data_line_ang_cell, num_line)
    % 对mag进行作图
    x_min = range_list(1);
    x_max = range_list(2);
    y_min = range_list(3); 
    y_max = range_list(4);
    
    current_fig = figure;
    set(gcf,'position',[250 300 1000 400])
    subplot(1,2,1)
    % set(gcf,'position',[250 300 1000 900])
    im1 = imagesc(data_mesh_x(:,1), data_mesh_y(1,:), data_mesh_mag');
    axis([x_min x_max y_min y_max])
    box on
    shading interp
    hold on
    set(gca, 'YDir', 'normal')
    xlabel('X($\mu m$)','interpreter','latex', 'FontSize', 12);
    ylabel('Y($\mu m$)','interpreter','latex', 'FontSize', 12);
    % colormap(gca, clc_map)
    colorbar
    title('mag', 'interpreter', 'latex', 'FontSize', 14);
    subplot(1,2,2)
    sizeMarker = 1;
    data_line_x_raw_list = [];
    data_line_y_raw_list = [];
    data_line_ang_raw_list = [];
    for line_index = 1:num_line
        data_line_x_raw_list = [data_line_x_raw_list, data_line_x_cell{line_index}];
        data_line_y_raw_list = [data_line_y_raw_list, data_line_y_cell{line_index}];
        data_line_ang_raw_list = [data_line_ang_raw_list, data_line_ang_cell{line_index}];
    end
    scatter(data_line_x_raw_list, data_line_y_raw_list, sizeMarker, data_line_ang_raw_list, 'o', 'filled')
    colorbar

    % hold on
    % for line_index = 1:num_line
    %     plot(data_line_x_cell{line_index}, data_line_y_cell{line_index});
    %     % patch([data_line_x_cell{line_index} NaN],[data_line_y_cell{line_index} NaN],[colorMarker NaN],'Marker','o','EdgeColor','interp','MarkerFaceColor','flat') 
    % end
end
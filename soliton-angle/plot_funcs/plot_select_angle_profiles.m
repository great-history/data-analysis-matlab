function current_fig = plot_select_angle_profiles(interp_x_list, interp_av_value_array, ang_list, angle_select_index_list, save_path)
    current_fig = figure;
    hold on
    legend_cell = cell(length(angle_select_index_list), 1);
    for ii = 1:length(angle_select_index_list)
        current_index = angle_select_index_list(ii);
        p1 = plot(interp_x_list, interp_av_value_array(current_index, :));
        legend_cell{ii} = ['ang @ ', num2str(round(ang_list(current_index)))];
        hold on
    end
    legend(legend_cell, 'Location','North');

    saveas(gcf, save_path); %保存当前窗口的图像
end
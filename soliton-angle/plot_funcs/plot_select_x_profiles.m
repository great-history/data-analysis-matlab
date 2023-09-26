function current_fig = plot_select_x_profiles(ang_list, interp_av_value_array, interp_x_list, x_select_index_list, save_path)
    current_fig = figure;
    hold on
    legend_cell = cell(length(x_select_index_list), 1);
    for ii = 1:length(x_select_index_list)
        current_index = x_select_index_list(ii);
        p1 = plot(ang_list, interp_av_value_array(:, current_index));
        legend_cell{ii} = ['x @ ', num2str(roundn(interp_x_list(current_index), -3))];
        hold on
    end
    legend(legend_cell, 'Location','North');

    saveas(gcf, save_path); %保存当前窗口的图像
end

% select_x_profile = interp_av_value_array(:, x0_index);
% fig8 = figure();
% plot(ang_list, select_x_profile)
function current_fig = plot_interp_av_value_array(ang_hist_values, ang_list, interp_x_list, interp_av_value_array, save_path)
    current_fig = figure;
    subplot(1,2,1);
    barh(ang_list, ang_hist_values)

    subplot(1,2,2);
    im1 = imagesc(interp_x_list, ang_list, interp_av_value_array);
    axis([interp_x_list(1) interp_x_list(end) ang_list(1) ang_list(end)])
    box on
    shading interp
    hold on
    set(gca, 'YDir', 'normal')
    xlabel('X($\mu m$)','interpreter','latex', 'FontSize', 12);
    ylabel('Ang($\deg$)','interpreter','latex', 'FontSize', 12);
    % colormap(gca, clc_map)
    colorbar
    if ~(save_path == "")
        saveas(gcf, save_path); %保存当前窗口的图像
    end
    
end
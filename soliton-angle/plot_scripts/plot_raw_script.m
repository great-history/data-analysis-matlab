%% 作图
addpath('../plot_funcs/')
addpath('..')

%% 画出原始数据的图
fig0 = plot_raw_data(data_mesh_x, data_mesh_y, data_mesh_mag, [x_min, x_max, y_min, y_max], data_line_x_cell, data_line_y_cell, data_line_ang_cell, num_line);
if flag_defect
    subplot(1,2,2)
    hold on
    for ii = 1:num_defect
        plot(defect_region_poly_list(ii))
    end
end
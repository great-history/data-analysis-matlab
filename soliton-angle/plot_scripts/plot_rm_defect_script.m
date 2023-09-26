%% 作图
addpath('../plot_funcs/')
addpath('..')

%% 画出去掉defect之后的图
if flag_defect
    fig1 = plot_raw_data(data_mesh_x, data_mesh_y, data_mesh_mag, [x_min, x_max, y_min, y_max], data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell, num_seg);
    subplot(1,2,2)
    hold on
    for ii = 1:num_defect
        plot(defect_region_poly_list(ii))
    end
end
%% 作图
addpath('../plot_funcs/')
addpath('..')

%% 测试交叉点寻找是否有误
% fig1 = plot_forbidden_regions(data_left_end_eps_cell, data_right_end_eps_cell, data_line_x_cell, data_line_y_cell, num_line);

%% 测试是否找到相交的线
% fig2 = plot_crossing_lines(data_line_x_cell, data_line_y_cell, crossing_info_cell, 1);

%% 测试是否去掉了最近的一些点
fig3 = plot_new_lines(data_line_mid_point_list, data_line_ang_list, data_left_end_cell, data_right_end_cell, [x_min, x_max, y_min, y_max], num_seg);
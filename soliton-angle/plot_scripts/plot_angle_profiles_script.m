%% 作图
addpath('../plot_funcs/')
addpath('..')

%% 画某些角度下的曲线
angle_select_list = [60, 65, 70, 75, 80, 85, 90];
angle_select_index_list = find_angle_select_index(ang_list, angle_select_list);

save_path = ['D:\matlab\soliton_angle\figs\rmp_20230301\angle_', num2str(2 * delta_ang), '_' num2str(half_width_trial), '_', num2str(half_width_forbidden), '_ang_select.jpg'];
% fig7 = plot_select_angle_profiles(interp_x_list, interp_av_value_array, ang_list, angle_select_index_list, save_path);
fig7 = plot_select_angle_profiles_with_se(interp_x_list, interp_av_value_array, ang_list, angle_select_index_list, std_error_array, save_path);
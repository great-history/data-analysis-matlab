%% 作图
addpath('../plot_funcs/')
addpath('..')

%% 画出x=0对应的angle profile
save_path = ['D:\matlab\soliton_angle\figs\rmp_20230301\angle_', num2str(2 * delta_ang), '_' num2str(half_width_trial), '_', num2str(half_width_forbidden), '_x_select.jpg'];
x_select_index_list = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50];
% x_select_index_list = [20, 50, 80];
% fig8 = plot_select_x_profiles(ang_list, interp_av_value_array, interp_x_list, x_select_index_list, save_path);
fig8 = plot_select_x_profiles_with_se(ang_list, interp_av_value_array, interp_x_list, x_select_index_list, std_error_array, save_path);
% 
% save_path = ['D:\matlab\soliton_angle\figs\rmp_20230301\angle_', num2str(2 * delta_ang), '_' num2str(half_width_trial), '_', num2str(half_width_forbidden), '_x_select_new.jpg'];
% % fig9 = plot_select_x_profiles(ang_list, interp_av_value_array_new, interp_x_list, x_select_index_list, save_path);
% fig9 = plot_select_x_profiles_with_se(ang_list, interp_av_value_array_new, interp_x_list, x_select_index_list, std_error_array, save_path);
%% 作图
addpath('../plot_funcs/')
addpath('..')

%% 从哪个角度开始 % 角度太小没有借鉴意义
start_angle = 60;
start_index = 0;
for ang_index = 1:num_angle
    if ang_list(ang_index) >= 60
        start_index = ang_index;
        break;
    end
end

%% 画图
save_path = ['D:\matlab\soliton_angle\figs\rmp_20230301\angle_', num2str(2 * delta_ang), '_' num2str(half_width_trial), '_', num2str(half_width_forbidden), '_raw.jpg'];
fig4 = plot_interp_av_value_array(ang_hist.Values, ang_list, interp_x_list, interp_av_value_array, save_path);

%% 画图
save_path = ['D:\matlab\soliton_angle\figs\rmp_20230301\angle_', num2str(2 * delta_ang), '_' num2str(half_width_trial), '_', num2str(half_width_forbidden), '_with_cut.jpg'];
fig5 = plot_interp_av_value_array(ang_hist.Values(start_index:end), ang_list(start_index:end), interp_x_list, interp_av_value_array(start_index:end, :), save_path);

%% 画图
save_path = ['D:\matlab\soliton_angle\figs\rmp_20230301\angle_', num2str(2 * delta_ang), '_' num2str(half_width_trial), '_', num2str(half_width_forbidden), '_fit.jpg'];
fig6 = plot_interp_av_value_array(ang_hist.Values(start_index:end), ang_list(start_index:end), interp_x_list, interp_av_value_array_new(start_index:end, :), save_path);

%% 开启多核
poolobj = gcp('nocreate');
if isempty(poolobj)
    disp('启动并行运算，核心数：6');
    % Perform a basic check by entering this code, where "local" is one kind of cluster profile.
    parpool('local', 6);
else
    disp(['并行运o算已启动，核心数：' num2str(poolobj.NumWorkers)]);
end

%% 数据的读取
% mag_file_path = 'D:\matlab\soliton_angle\files\Fig3a_O3A_raw_data_scale2.txt';
% angle_file_path = 'D:\matlab\soliton_angle\files\Fig3b_soliton_angle_phi2.txt';
% [data_mesh_x, data_mesh_y, data_mesh_mag] = read_mag_file(mag_file_path, 400);
% [data_line_x_cell, data_line_y_cell, data_line_ang_cell, num_line, num_point_per_line] = read_line_file(angle_file_path, 500);

mag_file_path = 'D:\matlab\soliton_angle\files\Fig2b_O3A_raw_data_scale2.txt';
angle_file_path = 'D:\matlab\soliton_angle\files\Fig2b_soliton_angle_phi2.txt';
[data_mesh_x, data_mesh_y, data_mesh_mag] = read_mag_file(mag_file_path, 300);
[data_line_x_cell, data_line_y_cell, data_line_ang_cell, num_line, num_point_per_line] = read_line_file(angle_file_path, 500);

x_min = min(data_mesh_x(:,1));
x_max = max(data_mesh_x(:,1));
y_min = min(data_mesh_y(1,:));
y_max = max(data_mesh_y(1,:));

%% 找到defect的区域
[m,im]=min(data_mesh_mag);
[m2,im2]=min(m);
defect_center_x=im(im2);
defect_center_y=im2;
% 确定defect区域的大小
defect_half_width = 25;
defect_half_height = 25;
[defect_region, defect_region_poly] = get_defect_region_poly(data_mesh_x, data_mesh_y, defect_center_x, defect_center_y, defect_half_width, defect_half_height);
[data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell, num_seg] = remove_defect_points(data_line_x_cell, data_line_y_cell, data_line_ang_cell, defect_region_poly, num_line);

%% 作图
addpath('./plot_funcs/')
%% 画出原始数据的图
fig0 = plot_raw_data(data_mesh_x, data_mesh_y, data_mesh_mag, [x_min, x_max, y_min, y_max], data_line_x_cell, data_line_y_cell, data_line_ang_cell, num_line);
subplot(1,2,1)
plot(defect_region_poly);
subplot(1,2,2)
hold on
plot(defect_region_poly)

fig1 = plot_raw_data(data_mesh_x, data_mesh_y, data_mesh_mag, [x_min, x_max, y_min, y_max], data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell, num_seg);
subplot(1,2,1)
plot(defect_region_poly);
subplot(1,2,2)
hold on
plot(defect_region_poly)
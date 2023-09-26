%% 数据的读取
mag_file_path = 'D:\matlab\soliton_angle\files\Fig2b_O3A_raw_data_scale2.txt';
angle_file_path = 'D:\matlab\soliton_angle\files\Fig2b_soliton_angle_phi2.txt';

[data_mesh_x, data_mesh_y, data_mesh_mag] = read_mag_file(mag_file_path, 300);
x_min = min(data_mesh_x(:,1));
x_max = max(data_mesh_x(:,1));
y_min = min(data_mesh_y(1,:));
y_max = max(data_mesh_y(1,:));

% [data_line_x_cell, data_line_y_cell, data_line_ang_cell, num_line, num_point_per_line] = read_line_file(angle_file_path, 500);
data_ = readmatrix(angle_file_path); %读取数据构成矩阵
num_linepoint = size(data_, 1);
data_line_x_list = data_(:, 1);
data_line_y_list = data_(:, 2);
data_line_ang_list = data_(:, 3);

num_point_per_line = 500;
num_line = num_linepoint / num_point_per_line;
data_line_ang_list = reshape(data_line_ang_list, [num_point_per_line, num_line]);
data_line_x_list = reshape(data_line_x_list, [num_point_per_line, num_line]);
data_line_y_list = reshape(data_line_y_list, [num_point_per_line, num_line]);

data_line_x_cell = cell(num_line, 1);
data_line_y_cell = cell(num_line, 1);
data_line_ang_cell = cell(num_line, 1);
for line_index = 1:num_line
    data_line_x_cell{line_index} = data_line_x_list(:, line_index)';
    data_line_y_cell{line_index} = data_line_y_list(:, line_index)';
    data_line_ang_cell{line_index} = data_line_ang_list(:, line_index)';
end

%% 对原始数据mag进行作图
% 对mag进行作图
fig1 = figure;
set(gcf,'position',[250 300 1000 400])
% set(gcf,'position',[250 300 1000 900])
im1 = imagesc(data_mesh_x(:,1), data_mesh_y(1,:), data_mesh_mag');
axis([x_min x_max y_min y_max])
box on
shading interp
hold on
set(gca, 'YDir', 'normal')
xlabel('X($\mu m$)','interpreter','latex', 'FontSize', 12);
ylabel('Y($\mu m$)','interpreter','latex', 'FontSize', 12);
% colormap(gca, clc_map)
colorbar
title('mag', 'interpreter', 'latex', 'FontSize', 14);

%% 对截取的曲线进行作图（使用scatter）
fig2 = figure;
sz = 1;
scatter(data_line_x_list(1:500), data_line_y_list(1:500), sz)
hold on

%% 对截取的曲线进行作图（使用plot）
fig2 = figure;
hold on
for line_index = 1:num_line
    plot(data_line_x_cell{line_index}, data_line_y_cell{line_index});
end

%% 找到defect的区域
[m,im]=min(data_mesh_mag);
[m2,im2]=min(m);
i=im(im2);
j=im2;
% 确定defect区域的大小
defect_length = 10;
defect_width = 10;
defect_region_corner_list = [i - defect_width, i + defect_width, i + defect_width, i - defect_width; j + defect_length, j + defect_length, j - defect_length, j - defect_length];
defect_region = zeros(2, 4);
for ii = 1:4
    x_index = defect_region_corner_list(1, ii);
    y_index = defect_region_corner_list(2, ii);
    defect_region(1, ii) = data_mesh_x(x_index, y_index);
    defect_region(2, ii) = data_mesh_y(x_index, y_index);
    % plot(data_mesh_x(x_index, y_index), data_mesh_y(x_index, y_index), 'c*')
end
defect_region_poly = polyshape(defect_region(1, :), defect_region(2, :));

%% 
poly1 = polyshape([0 0 1 1],[1 0 0 1]);
lineseg = [-0.75 -0.25; -0.56 -0.41; 0.45 0.56; 0.5 0.5; 1.5 1.5];
[in,out] = intersect(poly1,lineseg);
plot(poly1)
hold on
plot(in(:,1),in(:,2),'b',out(:,1),out(:,2),'r')
legend('Polygon','Inside','Outside','Location','NorthWest')


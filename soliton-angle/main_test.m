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

%% 得到各条曲线之间的交叉点：这很重要，可以在接下来的步骤中大大减少计算量
half_width_eps = 10; % 单位为nm
half_width_eps = half_width_eps / 1000;
[data_left_end_eps_cell, data_right_end_eps_cell] = get_two_end_cell(data_line_x_cell, data_line_y_cell, num_line, half_width_eps);
% 标注：data_left_end_eps_cell{line_index} : 第一维度是坐标，第二维度是点的指标
intersect_point_array = get_crossing_points_by_cell(data_left_end_eps_cell, data_right_end_eps_cell, num_line);
crossing_info_cell = find_crossing_lines(intersect_point_array, num_line);

%% 得到一定宽度的条带
half_width_trial = 20; % 单位为nm   0.1 / 1 / 10 / 20 / 30 / 40 / 50
half_width_trial = half_width_trial / 1000;
[data_left_end_cell, data_right_end_cell] = get_two_end_cell(data_line_x_cell, data_line_y_cell, num_line, half_width_trial);

%% 得到每条线的禁区
half_width_forbidden = 15; % 单位为nm  0.1 / 1 / 5 / 10 / 15 / 20 / 25 / 30
half_width_forbidden = half_width_forbidden / 1000;
[data_left_end_forbidden_cell, data_right_end_forbidden_cell] = get_two_end_cell(data_line_x_cell, data_line_y_cell, num_line, half_width_forbidden);
tic
poly_forbidden_list = get_poly_forbidden_list(data_left_end_forbidden_cell, data_right_end_forbidden_cell, num_line);
toc

%% Plot在各角度下的数量分布
data_line_ang_list = [];
for line_index = 1:num_line
    data_line_ang_list = [data_line_ang_list, data_line_ang_cell{line_index}];
end
delta_ang = 0.2; % 角度分辨率 0.1 / 0.2 / 0.3 / 0.4 / 0.5 / 0.55 / 0.6
max_ang = max(data_line_ang_list);
min_ang = min(data_line_ang_list);
num_bins = round((max_ang - min_ang) / (2 * delta_ang));

fig4 = figure;
subplot(1,2,1);
hist = histogram(data_line_ang_list, num_bins);
ang_list = [];
num_angle = 0;
for ang_index = 1:num_bins
    if hist.Values(ang_index) > 100
        num_angle = num_angle + 1;
        select_ang = (hist.BinEdges(ang_index) + hist.BinEdges(ang_index + 1)) / 2; % 法二
        % ang_list(ang_index) = select_ang;
        ang_list = [ang_list, select_ang];
    end
end

%% 找到那些太靠近的点
tic
[data_left_end_cell, data_right_end_cell] = find_close_points(data_left_end_cell, data_right_end_cell, data_line_x_cell, data_line_y_cell, crossing_info_cell, poly_forbidden_list, num_line);
toc

%% 消除那些太靠近的点
[data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell, data_line_segment_left_end_cell, data_line_segment_right_end_cell, num_seg] = ...
                    remove_close_points(data_left_end_cell, data_right_end_cell, data_line_x_cell, data_line_y_cell, data_line_ang_cell, num_line);
% disp(["num_seg = ", num_seg]);

%% 找到defect的区域并去掉defect区域的点
% 寻找defect的中心位置，这最好是手动找出来，一般defect的数目可能也不多
flag_defect = true;
if flag_defect
    % [m,im]=min(data_mesh_mag);
    % [~,im2]=min(m);
    % defect_center_x=im(im2);
    % defect_center_y=im2;
    
    % 确定defect区域的中心位置和大小
    defect_center_x_list = [55, 45, 100];
    defect_center_y_list = [192, 100, 80];
    defect_half_width_list = [20, 30, 21];
    defect_half_height_list = [24, 25, 12];
    num_defect = length(defect_center_x_list);
    defect_region_poly_list = [];
    % 开始去掉defect区域内的点
    for ii = 1:num_defect
        defect_center_x = defect_center_x_list(ii);
        defect_center_y = defect_center_y_list(ii);
        defect_half_width = defect_half_width_list(ii);
        defect_half_height = defect_half_height_list(ii);
        [~, defect_region_poly] = get_defect_region_poly(data_mesh_x, data_mesh_y, defect_center_x, defect_center_y, defect_half_width, defect_half_height);
        defect_region_poly_list = [defect_region_poly_list, defect_region_poly];
        [data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell, data_line_segment_left_end_cell, data_line_segment_right_end_cell, num_seg] = ...
                       remove_defect_points_new(data_line_segment_left_end_cell, data_line_segment_right_end_cell, data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell, ...
                                                defect_region_poly, num_seg);
    end
end

%% 重新设置点数:因为原始数据中不同长度的线取的点数是一样多的，而最长的线段长度是最短的15倍数
seg_length_cell = get_seg_length_cell(data_line_segment_x_cell, data_line_segment_y_cell, num_seg);
line_num_point_list = get_line_num_point_list_by_cell(seg_length_cell, num_seg);
[data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell] = ...
            get_new_data_line_cells(data_line_segment_x_cell, data_line_segment_y_cell, data_line_segment_ang_cell, ...
                                    seg_length_cell, line_num_point_list, num_seg);                
                
%% 重新得到一定宽度的条带
half_width = 50.0; % 单位为nm
half_width = half_width / 1000;
[data_left_end_cell, data_right_end_cell] = get_two_end_cell(data_line_segment_x_cell, data_line_segment_y_cell, num_seg, half_width);
num_seg = length(data_left_end_cell);

%% 将cell中的所有数组合并为一个list, 做拟合时我们能并不需要区分它们了, 但是作图时需要区分
data_line_ang_list = [];
data_line_left_end_list = [];
data_line_right_end_list = [];
data_line_mid_point_list = [];
for line_index = 1:num_seg
    data_line_ang_list = [data_line_ang_list, data_line_segment_ang_cell{line_index}];
    data_line_left_end_list = [data_line_left_end_list, data_left_end_cell{line_index}];
    data_line_right_end_list = [data_line_right_end_list, data_right_end_cell{line_index}];
    data_line_mid_point_list = [data_line_mid_point_list, [data_line_segment_x_cell{line_index}; data_line_segment_y_cell{line_index}]];
end
num_linepoint = length(data_line_ang_list);

%% 比较除点前后在各角度下数量的分布
% delta_ang = 0.55; % 角度分辨率 0.1 / 0.2 / 0.3 / 0.4 / 0.5 / 0.55 / 0.6
max_ang = max(data_line_ang_list);
min_ang = min(data_line_ang_list);
num_bins = round((max_ang - min_ang) / (2 * delta_ang));

% fig4 = figure;
hold on
subplot(1,2,2);
ang_hist = histogram(data_line_ang_list, num_bins);
ang_list = zeros(num_bins, 1);
num_angle = 0;
for ang_index = 1:num_bins
    num_angle = num_angle + 1;
    select_ang = (ang_hist.BinEdges(ang_index) + ang_hist.BinEdges(ang_index + 1)) / 2; % 法二
    % ang_list(ang_index) = select_ang;
    ang_list(ang_index) = select_ang;
end

%% 插值函数准备
scatter_x_list = reshape(data_mesh_x, [size(data_mesh_x, 1) * size(data_mesh_x, 2), 1]);
scatter_y_list = reshape(data_mesh_y, [size(data_mesh_y, 1) * size(data_mesh_y, 2), 1]);
scatter_mag_list = reshape(data_mesh_mag, [size(data_mesh_mag, 1) * size(data_mesh_mag, 2), 1]);
interp_func = scatteredInterpolant(scatter_x_list , scatter_y_list, scatter_mag_list, 'linear', 'linear');
num_interp_half = 50; % 对应half_width的插值数目
interp_x_list = linspace(-half_width, half_width, 2 * num_interp_half - 1);

%% 在每个角度下进行插值
tic
thre_num = 0;
% [interp_av_value_array, std_error_array, skip_ang_index_list] = get_interp_data(interp_func, data_line_left_end_list, data_line_right_end_list, data_line_ang_list, ang_hist, ...
%                                                                                 thre_num, num_angle, num_interp_half, num_linepoint, "renorm");
[interp_av_value_array, std_error_array, skip_ang_index_list] = get_interp_data(interp_func, data_line_left_end_list, data_line_right_end_list, data_line_ang_list, ang_hist, ...
                                                                                thre_num, num_angle, num_interp_half, num_linepoint, "");                                                                            
toc

% ang_index_interp_list = [27, 29, 36];
ang_index_interp_list = find(skip_ang_index_list == 1);
for x_index = 1:(2 * num_interp_half - 1)
    x_cut_list = interp_av_value_array(:, x_index);
    x_cut_list(ang_index_interp_list) = [];
    ang_interp_list = ang_list;
    ang_interp_list(ang_index_interp_list) = [];
    ang_fit_list = ang_list(ang_index_interp_list);
    
    val_list = interp1(ang_interp_list, x_cut_list, ang_fit_list, 'linear');
    interp_av_value_array(ang_index_interp_list, x_index) = val_list;
end

% 对角度方向进行一维高斯滤波(挺好)
sigma = 1.0;  % 半高宽为2个像素点的宽度
interp_av_value_array_new = zeros(size(interp_av_value_array));
parfor i = 1:(2 * num_interp_half - 1)
	interp_av_value_array_new(:, i) = gaussianfilter(num_angle, sigma, interp_av_value_array(:, i));
end

%% 从哪个角度开始 % 角度太小没有借鉴意义
start_angle = 60;
start_index = 0;
for ang_index = 1:num_angle
    if ang_list(ang_index) >= 60
        start_index = ang_index;
        break;
    end
end

angle_select_list = [65, 70, 75, 80, 85];
angle_select_index_list = find_angle_select_index(ang_list, angle_select_list);

str_split = split(mag_file_path, '\');
str_split = split(str_split{end}, '.');
filename = str_split{1};
save_path = ['.\data\', datestr(datetime, 'yy-mm-dd-HH-MM-SS'), filename];
save(save_path);
function [data_mesh_x, data_mesh_y, data_mesh_mag] = read_mag_file(mag_file_path, num_point)
    raw_data_mesh = readmatrix(mag_file_path);
    % num_point = 400;
    data_mesh_x = raw_data_mesh(:,1);
    data_mesh_x = reshape(data_mesh_x, [num_point, size(data_mesh_x, 1) / num_point]);
    data_mesh_y = raw_data_mesh(:,2);
    data_mesh_y = reshape(data_mesh_y, [num_point, size(data_mesh_y, 1) / num_point]);
    data_mesh_mag = raw_data_mesh(:,3);
    data_mesh_mag = reshape(data_mesh_mag, [num_point, size(data_mesh_mag, 1) / num_point]);
end
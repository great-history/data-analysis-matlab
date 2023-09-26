function [defect_region, defect_region_poly] = get_defect_region_poly(data_mesh_x, data_mesh_y, defect_center_x, defect_center_y, defect_half_width, defect_half_height)
    defect_region_corner_list = [defect_center_x - defect_half_width, defect_center_x + defect_half_width, defect_center_x + defect_half_width, defect_center_x - defect_half_width; ...
                                 defect_center_y + defect_half_height, defect_center_y + defect_half_height, defect_center_y - defect_half_height, defect_center_y - defect_half_height];
    defect_region = zeros(2, 4);
    for ii = 1:4
        x_index = defect_region_corner_list(1, ii);
        y_index = defect_region_corner_list(2, ii);
        defect_region(1, ii) = data_mesh_x(x_index, y_index);
        defect_region(2, ii) = data_mesh_y(x_index, y_index);
        % plot(data_mesh_x(x_index, y_index), data_mesh_y(x_index, y_index), 'c*')
    end
    defect_region_poly = polyshape(defect_region(1, :), defect_region(2, :));
end
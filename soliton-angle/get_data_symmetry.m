function data_mat = get_data_symmetry(data_mat, num_half)
    % 对称化
    % dims = length(data_list);
    count = size(data_mat, 1);
    for ii = 1:count
        data_list = data_mat(ii, :);
        for x_index = 1:num_half
            data_list(x_index) = (data_list(x_index) + data_list(end + 1 - x_index)) / 2;
            data_list(end + 1 - x_index) = data_list(x_index);
        end
        data_mat(ii, :) = data_list;
    end
end
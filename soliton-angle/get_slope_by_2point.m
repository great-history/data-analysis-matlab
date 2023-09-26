function slope = get_slope_by_2point(x_list, y_list)
    if x_list(1) == x_list(2)
        slope = inf;
    else
        slope = (y_list(1) - y_list(2)) / (x_list(1) - x_list(2));
    end
end
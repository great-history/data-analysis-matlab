function [x_intersect, y_intersect] = get_crossing_points(poly1, poly2)
    polyout = intersect([poly1, poly2]);

    if polyout.NumRegions == 1
        x_intersect = sum(polyout.Vertices(:,1)) / size(polyout.Vertices, 1);  % 因为half_width_eps取得足够小，所以平均一下就行了
        y_intersect = sum(polyout.Vertices(:,2)) / size(polyout.Vertices, 1);
    elseif polyout.NumRegions >= 2
        disp("有两个交点？")
    else
        x_intersect = nan;
        y_intersect = nan;
    end
end
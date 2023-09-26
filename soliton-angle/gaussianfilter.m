% 功能：对一维信号的高斯滤波，头尾r/2的信号不进行滤波
% r     :高斯模板的大小推荐奇数
% sigma :标准差
% y     :需要进行高斯滤波的序列
function y_filtered = gaussianfilter(dims, sigma, y)
    % y的维数为dims
    % dims分奇偶性讨论
    
    % 生成一维高斯滤波模板
    GaussTemp = ones(1, 2 * dims - 1);
    for i=1:(2 * dims - 1)
        GaussTemp(i) = exp(-(i - dims)^2 /(2 * sigma^2)) / ( sqrt(2*pi) * sigma);
    end

    % 高斯滤波
    y_filtered = y;
    for i = 1:dims
        gauss_fragment = GaussTemp((dims + 1 - i):(2 * dims - i));
        norm = sum(gauss_fragment);
        
        y_filtered(i) = dot(y, gauss_fragment);
        y_filtered(i) = y_filtered(i) / norm;
    end
    
end
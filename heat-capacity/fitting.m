%% load data
heat_capacity_datas = load('D:\jupyter_notebook\IJulia\heat_capacity\比热.txt');

%% 使用最小二乘法进行拟合
% 使用最小二乘法的优点是①可以知道标准差；②一般只有一个解，而ga则会存在local minima的问题会有好几个解
% 放在主函数中，主要是用来开启并行池，并将相应并行会使用的文件的路径加入
poolobj = gcp('nocreate');
if isempty(poolobj)
    disp('启动并行运算，核心数：8');
    % Perform a basic check by entering this code, where "local" is one kind of cluster profile.
    parpool('local', 8);
else
    disp(['并行运o算已启动，核心数：' num2str(poolobj.NumWorkers)]);
end

% addAttachedFiles(poolobj, {'D:\matlab\graphene-package\trilayer-graphene\trilayer_landau_level\trilayer_LLs_fitting_without_D_lsq.m'})

options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','UseParallel', true);

% x0 = [  25,  25, 165.0, 202.0, 451.0, 1280.0]; % N_e1 / N_e1 / Theta_d / Theta_e1, Theta_e2 / Theta_e3
x0 = [  15,  45, 245.0, 102.0, 601.0, 1280.0];
lb = [   0;   0;    0;    0;    0;    0];
ub = [75.9;75.9; 2000; 2000; 2000; 2000];

xdata = heat_capacity_datas(:,1);
ydata = heat_capacity_datas(:,2);

[params, resnorm2,residual2,exitflag2,output2] = lsqcurvefit(@get_ydata, x0, xdata, ydata, lb, ub, options);

% 21.7952   25.0000   84.3440  172.2462  477.7420  478.2272
% 21.7970   35.0000   84.3403  172.2536  478.1970  477.6456

ydata_fit = get_ydata(params, xdata);

%% functions to calculate heat capacity
function ydata = get_ydata(params, xdata)
    % params是各种需要拟合的参数  xdata是温度  ydata是热容
    N_d = 3;
    % N_e1的取值范围是整数的0到75，但这里N_e1是浮点数，因此需要取整
    N_e1 = params(1);
    N_el = floor(N_e1);
    
    N_e2 = params(2);
    N_e2 = floor(N_e2);
    
    N_e3 = 75 - N_e1 - N_e2;
    if N_e3 < 0 
        ydata = zeros(length(xdata),1);
    else
        Theta_d = params(3);
        Theta_e1 = params(4);
        Theta_e2 = params(5);
        Theta_e3 = params(6);

        ydata = calc_heat_capacity(N_d, N_e1, N_e2, N_e3, Theta_d, Theta_e1, Theta_e2, Theta_e3, xdata);
    end
end

%% example
% temperatures = linspace(1,300,300);
% 
% N_d = 3;
% Theta_d = 165.0;
% 
% N_e1 = 12;
% Theta_e1 = 202.0;
% 
% N_e2 = 15;
% Theta_e2 = 451.0;
% 
% N_e3 = 12;
% Theta_e3 = 1280.0;
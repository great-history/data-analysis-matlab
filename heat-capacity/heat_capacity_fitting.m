%% load data
heat_capacity_datas = load('D:\jupyter_notebook\IJulia\heat_capacity\比热.txt');
xdata = heat_capacity_datas(:,1);
ydata = heat_capacity_datas(:,2);

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

resnorm2_now = 10000;
params_now = [1, 1, 73, 245.0, 102.0, 601.0, 1280.0];

% N_e1,N_e2,N_e3是从大到小排列的
tic
for N_e1 = 25:75
    
    for N_e2 = N_e1:-1:1
        N_d = 3;
        
        N_e3 = 75 - N_e1 - N_e2;
        if N_e3 > N_e2 || N_e3 < 0
            break
        end
        
        x0 = [N_e1, N_e2, N_e3, 245.0, 175.0,   350, 1280.0];
        lb = [N_e1; N_e2; N_e3;  50;   200;   200;   200];
        ub = [N_e1; N_e2; N_e3;  150;   650;   650;   650];
        
        [params, resnorm2,residual2,exitflag2,output2] = lsqcurvefit(@get_ydata, x0, xdata, ydata, lb, ub, options);
        if resnorm2 < resnorm2_now
            resnorm2_now = resnorm2;
            params_now = params;
        end
    end
end
toc

% params = 37.0000   19.0000   19.0000   62.7848  229.8393  562.3285  562.2219

ydata_fit = get_ydata(params, xdata);
figure
plot(xdata, ydata)
hold on
plot(xdata, ydata_fit, 'r--o')
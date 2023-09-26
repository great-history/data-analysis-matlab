function ydata = get_ydata(params, xdata)
    % params是各种需要拟合的参数  xdata是温度  ydata是热容
    N_d = 3;
    N_e1 = params(1);
    N_e2 = params(2);
    N_e3 = params(3);
    
    Theta_d = params(4);
    Theta_e1 = params(5);
    Theta_e2 = params(6);
    Theta_e3 = params(7);

    ydata = calc_heat_capacity(N_d, N_e1, N_e2, N_e3, Theta_d, Theta_e1, Theta_e2, Theta_e3, xdata);
end
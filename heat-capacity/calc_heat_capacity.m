function cv_calc = calc_heat_capacity(N_d, N_e1, N_e2, N_e3, Theta_d, Theta_e1, Theta_e2, Theta_e3, temperatures)
    dims = length(temperatures);
    cv_calc = zeros(dims,1);
    
    for i = 1:dims
        temp = temperatures(i);
        
        td = Theta_d / temp;
        
        Cd = integral(@(x) Debye(x), 0.001, td);
        
        Cd = Cd * N_d * 3 / (td)^3;
        
        te1 = Theta_e1 / temp;
        C1 = N_e1 * (te1)^2 * exp(te1) / (exp(te1) - 1)^2;
        if isnan(C1)
            C1 = 0;
        end
        
        te2 = Theta_e2 / temp;
        C2 = N_e2 * (te2)^2 * exp(te2) / (exp(te2) - 1)^2;
        if isnan(C2)
            C2 = 0;
        end
        
        te3 = Theta_e3 / temp;
        C3 = N_e3 * (te3)^2 * exp(te3) / (exp(te3) - 1)^2;
        if isnan(C3)
            C3 = 0;
        end
        
        Cv = C1 + C2 + C3 + Cd;
        cv_calc(i) = Cv * 8.314;
    end
end

function val = Debye(x)
    val = x.^4 .* exp(x) ./ (exp(x) - 1).^2;
end
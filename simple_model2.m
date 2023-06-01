function p = simple_model2(bias,timee,sigma,X0)
p = 1 - normcdf(0,bias*timee+X0,sqrt(sigma*timee));
end


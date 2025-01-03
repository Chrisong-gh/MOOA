clc
clear all
close all
N = 30;
T = 500;
CEC_name = 30;
[Function_Name,runs] = get_CECname(CEC_name); %得到CEC和运行的函数个数
MaxA =7; % 优化算法的数量
pp =15;
take_F_name ="F"+""+pp;
figure 
color = ["r","b","k","y","m","g","c","[1 0.5 0]","[0 0.4470 0.7410]","[0.3010 0.7450 0.9330]"];
[lb,ub,dim,fobj] = Function_Name(take_F_name);
disp(take_F_name)

for j = 1:MaxA
    Aobj = get_Name(j);
    [best_fitness,best_position,cov]=Aobj(N,T,lb,ub,dim,fobj);
    disp(num2str(j)+" "+best_fitness)
    if j==1
        semilogy(cov,color(j),'LineWidth',2.5);%绘制半对数坐标图形
        disp(best_fitness);
%         plot(cov,'--','Color',color(j),'LineWidth',2.5);%绘制半对数坐标图形
    hold on 
    else
        semilogy(cov,'--','Color',color(j),'LineWidth',1.5);%绘制半对数坐标图形
 %        plot(cov,'--','Color',color(j),'LineWidth',1.5);%绘制半对数坐标图形
        hold on
    end
    disp(best_fitness)
end
% grid on
legend('OOA','SCSO','SSA','WOA','AOA','PSO','GTOA');
xlabel("Iteration#")
ylabel("Best score obtained so far")
title("F"+pp)
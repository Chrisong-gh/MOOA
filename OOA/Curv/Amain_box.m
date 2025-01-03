clear all;
close all;
clc
N=30;
T=500;
runs=30;   %沃里克森运行次数
CEC_name = 19; %需要运行的CEC
[Function_Name,Max_Func] = get_CECname(CEC_name); %得到CEC和运行的函数个数
Max_A = 7;%运行函数的个数，在Amainget_Name选择算法
pv = zeros(Max_A, runs);
w=zeros(Max_Func,Max_A-1);
Best_Score_Array = zeros(Max_A,Max_Func,runs);
Algorithm_name = {'OOA','SCSO','SSA','WOA','AOA','PSO','GTOA'};
fn=10;%函数名
Function_name = strcat('F',num2str(fn));
[LB,UB,dim,F_obj]=Function_Name(Function_name);   %F1-F10
figure

for a=1:Max_A
    [Aobj]=get_Name(a);
    for run=1:runs
        [Destination_fitness_1,bestPositions_1,Convergence_curve_1]=Aobj(N,T,LB,UB,dim,F_obj);
        Best_Score_Array_(run,a) = Destination_fitness_1;
    end
    Xlabels(a)=Algorithm_name(a);
end
set(gca,'LineWidth',1.5)
boxplot(Best_Score_Array_,'labels',Xlabels);
xlabel('Algorithm')
ylabel('Value')
h=findobj(gca,'Tag','Box');
color = {'r';'b';'k';'y';'m';'g';'c';[1 0.5 0];[0 0.4470 0.7410];[0.6350 0.0780 0.1840]};
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),color{length(h)-j+1},'FaceAlpha',1);
end
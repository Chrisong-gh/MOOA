clear all 
close all
clc

SearchAgents_no=30; % Number of search agents

Function_name='F22'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)

Max_iteration=100; % Maximum numbef of iterations

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details30(Function_name);

[Target_score,Target_pos,COA_cg_curve,Trajectories,fitness_history,position_history,global_fitness]=OOAnew(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

% figure('Position',[454   445   894   297])
% Draw search space
subplot(1,6,1);
func_plot(Function_name);
title(Function_name+" Parameter space")
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])
box on
axis tight

subplot(1,6,2);%

P_func_plot(Function_name);
hold on
for k1 = 1: size(position_history,1)
    for k2 = 1: size(position_history,2)
        
        plot(position_history(k1,k2,1),position_history(k1,k2,2),'^','markersize',2,'MarkerEdgeColor','g','markerfacecolor','g');
        hold on
    end
end
plot(Target_pos(1),Target_pos(2),'^','markersize',3,'MarkerEdgeColor','r','markerfacecolor','r');
title('Search history (x1 and x2 only)')
xlabel('x1')
ylabel('x2')


box on
axis tight

subplot(1,6,3);
semilogx (Trajectories(1,5:Max_iteration),'LineWidth',2);
hold on
title('Trajectory of 1st crayfish')
xlabel('Iteration#')
box on
% axis tight

subplot(1,6,4);
hold on
plot(mean(fitness_history),'LineWidth',2);
title('Average fitness of all crayfish')
xlabel('Iteration#')
% box on
axis tight

%Draw objective space
subplot(1,6,5);
semilogy(global_fitness,'Color','b','LineWidth',0.5)
% plot(global_fitness,'Color','b','LineWidth',0.5)
hold on
title('local fitness curve')
xlabel('Iteration#');
ylabel('Local score obtained so far');
box on
axis tight
%Draw objective space
subplot(1,6,6);
semilogy(COA_cg_curve,'Color','r','LineWidth',2)
hold on

title('Best fitness convergence curve')
xlabel('Iteration#');
ylabel('Best score obtained so far');
box on
axis tight
set(gcf,'position',[100 500 1727 200])
display(['The best solution obtained by COA is : ', num2str(Target_pos)]);%
display(['The best optimal value of the objective funciton found by CO is : ', num2str(Target_score)]);%

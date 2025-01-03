% Developed in MATLAB R2013b
% Source codes demo version 1.0
% _____________________________________________________


%  Author, inventor and programmer: Ali Asghar Heidari,
%  PhD research intern, Department of Computer Science, School of Computing, National University of Singapore, Singapore
%  Exceptionally Talented Ph. DC funded by Iran's National Elites Foundation (INEF), University of Tehran
%  03-03-2019

%  Researchgate: https://www.researchgate.net/profile/Ali_Asghar_Heidari

%  e-Mail: as_heidari@ut.ac.ir, aliasghar68@gmail.com,
%  e-Mail (Singapore): aliasgha@comp.nus.edu.sg, t0917038@u.nus.edu
% _____________________________________________________
%  Co-author and Advisor: Seyedali Mirjalili
%
%         e-Mail: ali.mirjalili@gmail.com
%                 seyedali.mirjalili@griffithuni.edu.au
%
%       Homepage: http://www.alimirjalili.com
% _____________________________________________________
%  Co-authors: Hossam Faris, Ibrahim Aljarah, Majdi Mafarja, and Hui-Ling Chen

%       Homepage: http://www.evo-ml.com/2019/03/02/hho/
% _____________________________________________________

%  Please refer to the main paper:
% Ali Asghar Heidari, Seyedali Mirjalili, Hossam Faris, Ibrahim Aljarah, Majdi Mafarja, Huiling Chen
% Harris hawks optimization: Algorithm and applications
% Future Generation Computer Systems, DOI: https://doi.org/10.1016/j.future.2019.02.028
% https://www.sciencedirect.com/science/article/pii/S0167739X18313530
% _____________________________________________________

% You can run the HHO code online at codeocean.com  https://doi.org/10.24433/CO.1455672.v1
% You can find the HHO code at https://github.com/aliasghar68/Harris-hawks-optimization-Algorithm-and-applications-.git
% _____________________________________________________

% _____________________________________________________
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all %#ok<CLALL>
close all
clc

N=30; % Number of search agents

Function_name='F2'; % Name of the test function 

T=500; % Maximum number of iterations

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);

[Best_score,Best_pos,HHO_curve]=soccer(N,T,lb,ub,dim,fobj);


figure('Position',[269   240   660   290])  % [left, botton, width, height]
%Draw search space
subplot(1,2,1);  % 一行两列中的第一个图
func_plot(Function_name);
title('Parameter space')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

%Draw objective space
subplot(1,2,2);
plot(HHO_curve,'Color','r')
title('Objective space')
xlabel('Iteration');
ylabel('Best score obtained so far');

axis tight
grid on
box on
legend('HHO')

display(['The best solution obtained by ,HHO is : ', num2str(Best_pos)]);
display(['The best optimal value of the objective funciton found by ,HHO is : ', num2str(Best_score)]);

        
        




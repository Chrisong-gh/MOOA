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

%       Homepage: http://www.evo-ml.com/2019/03/02/DMO/
% _____________________________________________________

%  Please refer to the main paper:
% Ali Asghar Heidari, Seyedali Mirjalili, Hossam Faris, Ibrahim Aljarah, Majdi Mafarja, Huiling Chen
% Harris hawks optimization: Algorithm and applications
% Future Generation Computer Systems, DOI: https://doi.org/10.1016/j.future.2019.02.028
% https://www.sciencedirect.com/science/article/pii/S0167739X18313530
% _____________________________________________________

% You can run the DMO code online at codeocean.com  https://doi.org/10.24433/CO.1455672.v1
% You can find the DMO code at https://github.com/aliasghar68/Harris-hawks-optimization-Algorithm-and-applications-.git
% _____________________________________________________

% _____________________________________________________
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all %#ok<CLALL>
close all
clc       


N=30; % Number of search agents

Function_name='F12'; % Name of the test function 

T=500; % Maximum number of iterations

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details_gc_2021(Function_name);


[Best_score_MDMO,Best_pos_MDMO,Best_curve_MDMO]=PSO(N,T,lb,ub,dim,fobj);
% [Best_score_DMO,Best_pos_DMO,Best_curve_DMO]=DMO(N,T,lb,ub,dim,fobj);
% [Best_score_sma,Best_pos_sma,Best_curve_sma]=SMA(N,T,lb,ub,dim,fobj);
% [Best_score_woa,Best_pos_woa,Best_curve_woa]=WOA(N,T,lb,ub,dim,fobj);
% [Best_score_AOA,Best_pos_AOA,Best_curve_AOA]=AOA(N,T,lb,ub,dim,fobj);
% [Best_score_SO,Best_pos_SO,Best_curve_SO]=SO(N,T,lb,ub,dim,fobj);
% [Best_score_GWO,Best_pos_GWO,Best_curve_GWO]=GWO(N,T,lb,ub,dim,fobj);
% [Best_score_SSA,Best_pos_SSA,Best_curve_SSA]=SSA(N,T,lb,ub,dim,fobj);
% [Best_score_ROA,Best_pos_ROA,Best_curve_ROA]=ROA(N,T,lb,ub,dim,fobj);
% [Best_score_WHO,Best_pos_WHO,Best_curve_WHO]=WHO(N,T,lb,ub,dim,fobj);

% figure('Position',[269   240   660   290])  % [left, botton, width, height]
%Draw search space
% subplot(1,2,1);  % 一行两列中的第一个图
% func_plot(Function_name);
% cec20_func(Function_name);
% title('Parameter space')
% xlabel('x_1');
% ylabel('x_2');
% zlabel([Function_name,'( x_1 , x_2 )'])
% saveas(gcf,'image/f1.jpg')
%Draw objective space
% subplot(1,2,2);
% h1 = plot(DMO_curve_erDMO,'Color','r','linewidth',2);
% hold on
% h2 = plot(DMO_curve_sma,'Color','#228B22','linewidth',2);
% hold on
% h3 = plot(DMO_curve_woa,'Color','#7A8B8B','linewidth',2);
% hold on
% h4 = plot(DMO_curve_ssa,'Color','c','linewidth',2);
% hold on
% h5 = plot(DMO_curve_sca,'Color','m','linewidth',2);
% hold on
% h6 = plot(DMO_curve_DMO,'Color','y','linewidth',2);
% hold on
% h7 = plot(DMO_curve_dDMO,'Color','#FFD700','linewidth',2);
% hold on
% h8 = plot(DMO_curve_DMOcm,'Color','b','linewidth',2);



% set(gca,'children');

% title(Function_name)
% xlabel('迭代次数');
% ylabel('适应度');
% 
% axis tight
% grid off
% box on
% legend('DMO_test','SMA','DMO','WOA','SSA','GWO','SCA')
% legend('MDMO','DMOCM','CEDMO')
% set(gca,'children',[h1,h2,h3,h4,h5,h6,h7,h8])
% set(gca,'children',[h1,h8,h9,h10])
% file_name =[ 'erDMO_image/',Function_name,'_result.jpg'];
% saveas(gcf,file_name);


% ,h2,h3,h4,h5,h6,h7,h8,h9  
display(['The best position value found by MDMO is : ', num2str(Best_pos_MDMO)]);
display(['The best optimal value found by MDMO is : ', num2str(Best_score_MDMO)]);
% display(['The best position value found by DMO is : ', num2str(Best_pos_DMO)]);
% display(['The best optimal value found by DMO is : ', num2str(Best_score_DMO)]);
% display(['The best position value found by SMA is : ', num2str(Best_pos_sma)]);
% display(['The best optimal value found by SMA is : ', num2str(Best_score_sma)]);
% display(['The best position value found by WOA is : ', num2str(Best_pos_woa)]);
% display(['The best optimal value found by WOA is : ', num2str(Best_score_woa)]);
% display(['The best position value found by AOA is : ', num2str(Best_pos_AOA)]);
% display(['The best optimal value found by AOA is : ', num2str(Best_score_AOA)]);
% display(['The best position value found by SO is : ', num2str(Best_pos_SO)]);
% display(['The best optimal value found by SO is : ', num2str(Best_score_SO)]);
% display(['The best position value found by GWO is : ', num2str(Best_pos_GWO)]);
% display(['The best optimal value found by GWO is : ', num2str(Best_score_GWO)]);
% display(['The best position value found by SSA is : ', num2str(Best_pos_SSA)]);
% display(['The best optimal value found by SSA is : ', num2str(Best_score_SSA)]);  
% display(['The best position value found by ROA is : ', num2str(Best_pos_ROA)]);
% display(['The best optimal value found by ROA is : ', num2str(Best_score_ROA)]);
% display(['The best positon value found by WHO is : ', num2str(Best_pos_WHO)]);
% display(['The best optimal value found by WHO is : ', num2str(Best_score_WHO)])


   




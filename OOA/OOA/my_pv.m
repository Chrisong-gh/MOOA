%______________________________________________________________________________________________
%  Moth-Flame Optimization Algorithm (MFO)                                                            
%  Source codes demo version 1.0                                                                      
%                                                                                                     
%  Developed in MATLAB R2011b(7.13)                                                                   
%                                                                                                     
%  Author and programmer: Seyedali Mirjalili                                                          
%                                                                                                     
%         e-Mail: ali.mirjalili@gmail.com                                                             
%                 seyedali.mirjalili@griffithuni.edu.au                                               
%                                                                                                     
%       Homepage: http://www.alimirjalili.com                                                         
%                                                                                                     
%  Main paper:                                                                                        
%  S. Mirjalili, Moth-Flame Optimization Algorithm: A Novel Nature-inspired Heuristic Paradigm, 
%  Knowledge-Based Systems, DOI: http://dx.doi.org/10.1016/j.knosys.2015.07.006
%_______________________________________________________________________________________________
% You can simply define your cost in a seperate file and load its handle to fobj 
% The initial parameters that you need are:
%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of generations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers

% To run MFO: [Best_score,Best_pos,cg_curve]=MFO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%______________________________________________________________________________________________
function[w] = my_pv(Function_name,pv,pv_name)

% 10表示一次性测试 10个算法，以第一个为基准
% pv_count = 10;
% pv = zeros(pv_count, Test_count);
w=zeros(1,size(pv,1)-1);
% ansRank = ranksum(pv1,pv2);
for  i=1:size(pv,1)-1

    ansSign = signrank(pv(1,:),pv(i+1,:));     %威尔科克森符号秩检验-Wilcoxon signed-rank test
    display([pv_name(1),'与',pv_name(i+1),'==>' , Function_name , ':P-Value = ' , num2str(ansSign)]);
    w(i)=ansSign;
%      display(num2str(ansSign));
end


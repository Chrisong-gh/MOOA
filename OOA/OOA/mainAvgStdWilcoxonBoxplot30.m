clear all;
close all;
clc
N=10;
T=500;
runs=30;       %�����ɭУ��ʱ��runs=15
Max_Func =1;                 %�����Ժ������
Max_A=7;
pv = zeros(Max_A, runs);
w=zeros(Max_Func,Max_A-1);

%% �Ƚϵ��㷨
Best_Score_Array_ = zeros(Max_A,Max_Func,runs);
Algorithm_name = {'OOA4', 'SCSO',  'SSA', 'WOA','AOA','PSO','GTOA'};


%% ���㺯��
for fn = 1:Max_Func
    Function_name = strcat('F',num2str(fn));
%             [lb,ub,dim,fobj]=CEC2014(Function_name);   %F1-F30
%             [lb,ub,dim,fobj]=CEC2017(Function_name);   %F1, F3-F30
             [LB,UB,dim,F_obj]=Get_Functions_details(Function_name);   %F1-F10 
%             [lb,ub,dim,fobj]=CEC2021(Function_name);   %F1-F10 
%     [lb,ub,dim,fobj]=Get_Functions_details500(Function_name);
    fn
    for run=1:runs
        for a=1:Max_A
            Aobj=Get_A_name(a);
            [Destination_fitness_1,bestPositions_1,Convergence_curve_1]=Aobj(N,T,LB,UB,dim,F_obj);
            Best_Score_Array_(a,fn,run) = Destination_fitness_1;
        end
    end
end


% %% �����㷨��F1-F23��ֵ�ͷ���
% avg_std(runs, Max_Func, Best_Score_Array_1, 'IWHO');
% avg_std(runs, Max_Func, Best_Score_Array_2, 'WHO');
% avg_std(runs, Max_Func, Best_Score_Array_3, 'GWO');
% avg_std(runs, Max_Func, Best_Score_Array_4, 'MFO');
% avg_std(runs, Max_Func, Best_Score_Array_5, 'SSA');
% avg_std(runs, Max_Func, Best_Score_Array_6, 'WOA');
% avg_std(runs, Max_Func, Best_Score_Array_7, 'PSO');
% avg_std(runs, Max_Func, Best_Score_Array_8, 'HSCAHS');
% avg_std(runs, Max_Func, Best_Score_Array_9, 'DSCA');
% avg_std(runs, Max_Func, Best_Score_Array_10, 'MALO');


%% �����ƿ�ɭ�����ȼ���-Wilcoxon signed-rank test, ��һ���㷨�������㷨�Ƚ�
for i=1:Max_Func
    for a=1:Max_A
        pv(a,:) = Best_Score_Array_(a,i,:);
    end

    w(i,:)=my_pv(['F',num2str(i)], pv, Algorithm_name);
    xlswrite('.\p.xlsx',w);
end


% %%  ��������ͼ
% array = zeros(runs,Algorithm_nums);
% for i = 1:Max_Func
%     for j = 1:Algorithm_nums
%         for n = 1:runs
%             tem = Best_Score_Array_1;
%             if j == 2
%                 tem = Best_Score_Array_2;
%             end
%             if j == 3
%                 tem = Best_Score_Array_3;
%             end
%             if j == 4
%                 tem = Best_Score_Array_4;
%             end
%             if j == 5
%                 tem = Best_Score_Array_5;
%             end
%             if j == 6
%                 tem = Best_Score_Array_6;
%             end
%             if j == 7
%                 tem = Best_Score_Array_7;
%             end
%             if j == 8
%                 tem = Best_Score_Array_8;
%             end
%             if j == 9
%                 tem = Best_Score_Array_9;
%             end
%             if j == 10
%                 tem = Best_Score_Array_10;
%             end
%             array(n,j) = tem(i, n);
%         end
%     end
%     boxplot(array,'Labels', Algorithm_name);
%     title(['F',num2str(i)]);
% %     title(['Anova test for training XOR'],'Fontname','Times New Roman','fontsize',18);
% %     xlabel('Algorithms','Fontname','Times New Roman','fontsize',18);
%     ylabel('MSE Value','Fontname','Times New Roman','fontsize',18);
%     set(gca,'XTickLabelRotation', 30, 'fontsize',15, 'fontname','Times New Roman');
%     axis tight
%     figure;
% end
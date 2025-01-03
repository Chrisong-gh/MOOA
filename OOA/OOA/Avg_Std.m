clear all
close all
clc

N=30;
T=500;
runs=10;
Max_Func = 23;
Max_A=8;
Best=zeros(Max_Func,Max_A);
Mean=zeros(Max_Func,Max_A);
Std=zeros(Max_Func,Max_A);

for fn = 1:Max_Func
    
    Function_name = strcat('F',num2str(fn));
    [lb,ub,dim,fobj]=Get_Functions_details(Function_name);
    fobj
    % [lb,ub,dim,fobj]=CEC2019(Function_name);
    Best_Score_Array = zeros(Max_A,runs);
    for a=1:Max_A
        tic
        for run=1:runs
            [Aobj]=Get_A_name(a);
            [Best_score,Best_pos,cg_curve]=Aobj(N,T,lb,ub,dim,fobj);
            Best_Score_Array(a,run)=Best_score;
        end
   
        toc
        Best(fn,a)=min(Best_Score_Array(a,:));
        Mean(fn,a)=mean(Best_Score_Array(a,:));
        Std(fn,a)=std(Best_Score_Array(a,:));
        disp(Aobj);
        % disp(['Best ',Function_name,': ',num2str(Best(fn,a))]);
        % disp(['Mean ',Function_name,': ',num2str(Mean(fn,a))]);
        % disp(['Std ',Function_name,': ',num2str(Std(fn,a))]);
    end

%     fn
end
% 
% xlswrite('D:\data\New_RSA\CEC2014\m.xlsx',Array(:,:,1)','best')
% xlswrite('D:\data\New_RSA\CEC2014\m.xlsx',Array(:,:,2)','mean')
% xlswrite('D:\data\New_RSA\CEC2014\m.xlsx',Array(:,:,3)','std')
%用另外的表或者新创建工作区存进去


%_________________________________________________________________________________
%  Salp Swarm Algorithm (SSA) source codes version 1.0
%
%  Developed in MATLAB R2016a
%
%  Author and programmer: Seyedali Mirjalili
%
%         e-Mail: ali.mirjalili@gmail.com
%                 seyedali.mirjalili@griffithuni.edu.au
%
%       Homepage: http://www.alimirjalili.com
%
%   Main paper:
%   S. Mirjalili, A.H. Gandomi, S.Z. Mirjalili, S. Saremi, H. Faris, S.M. Mirjalili,
%   Salp Swarm Algorithm: A bio-inspired optimizer for engineering design problems
%   Advances in Engineering Software
%   DOI: http://dx.doi.org/10.1016/j.advengsoft.2017.07.002
%____________________________________________________________________________________
%0
function [FoodFitness,FoodPosition,Convergence_curve]=SSA(N,Max_iter,lb,ub,dim,fobj)
%输出（最优食物适应度函数，最优食物位置，收敛曲线）=输入（群数目，最大迭代次数，下限，上限，维度，函数公式）
if size(ub,1)==1    %size取ub的行数
    ub=ones(dim,1)*ub;%ones产生全一矩阵，dim行1列
    lb=ones(dim,1)*lb;
end
Convergence_curve = zeros(1,Max_iter);%zeros产生全零矩阵，一行，max_iter列


%1
%Initialize the positions of salps  初始化樽海梢位置
SalpPositions=initialization(N,dim,ub,lb);%初始化的樽海鞘群数目，维度，上下限，确定群的位置
FoodPosition=zeros(1,dim);%食物位置定义
FoodFitness=inf;                              %食物适应度函数值


%2
%calculate the fitness of initial salps            计算初始鱼的适应度函数值
for i=1:size(SalpPositions,1)    %循环
    SalpFitness(1,i)=fobj(SalpPositions(i,:));%由位置计算出适应度值
end

[sorted_salps_fitness,sorted_indexes]=sort(SalpFitness);%sort（）升序排列，(列)对所算的适应度值进行排序 
% sorted_indexes返回索引序列，它表示sorted_salps_fitness中的元素与SalpFitness中元素的对应。

for newindex=1:N   %新的索引序列
    Sorted_salps(newindex,:)=SalpPositions(sorted_indexes(newindex),:);
end

FoodPosition=Sorted_salps(1,:);%排好序的种群确定食物位置
FoodFitness=sorted_salps_fitness(1);%排好序的种群的适应度值作为食物的适应度值

%3
%Main loop.(主循环）.........................................................................................................................
l=2; % start from the second iteration since the first iteration was dedicated to calculating the fitness of salps
%从第二次迭代开始，因为第一次迭代专门用于计算salps的适应度
while l<Max_iter+1
    
    c1 = 2*exp(-(4*l/Max_iter)^2); % Eq. (3.2) in the paper
    
    for i=1:size(SalpPositions,1)
        
        SalpPositions= SalpPositions';%求转置
        
        if i<=N/2
            for j=1:1:dim
                c2=rand();
                c3=rand();
                % Eq. (3.1) in the paper 
                if c3<0.5 
                    SalpPositions(j,i)=FoodPosition(j)+c1*((ub(j)-lb(j))*c2+lb(j));
                else
                    SalpPositions(j,i)=FoodPosition(j)-c1*((ub(j)-lb(j))*c2+lb(j));%j维中第i个salp的位置 
                end
              
            end
            
        elseif i>N/2 && i<N+1   %  &与运算   首先判断i>N/2，如果值为假，就可以判断整个表达式的值为假，就不需要再判断i<N+1的值.
            point1=SalpPositions(:,i-1);
            point2=SalpPositions(:,i);
            
            SalpPositions(:,i)=(point2+point1)/2; % Eq. (3.4) in the paper
        end
        
        SalpPositions= SalpPositions';%求转置
    end
    
    for i=1:size(SalpPositions,1)  %边界限定
        Tp=SalpPositions(i,:)>ub';
        Tm=SalpPositions(i,:)<lb';
%         SalpPositions(i,:)=(SalpPositions(i,:).*(~(Tp+Tm)))+ub'.*Tp+lb'.*Tm;
        tt=(SalpPositions(i,:).*(~(Tp+Tm)))+ub'.*Tp+lb'.*Tm;
        SalpPositions(i,:)=tt(1,:);
        %   ~表示非
        SalpFitness(1,i)=fobj(SalpPositions(i,:));
        
        if SalpFitness(1,i)<FoodFitness  %鱼追的上食物源，适应度函数值相等
            FoodPosition=SalpPositions(i,:);
            FoodFitness=SalpFitness(1,i);           %鱼追上食物，迭代循环直到满足条件为止
        end
    end
    
    Convergence_curve(l)=FoodFitness;%绘制食物适应度值的收敛曲线
    l = l + 1;
end




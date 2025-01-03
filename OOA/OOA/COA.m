%  Crayfish Optimization Algorithm(COA)
%
%  Source codes demo version 1.0                                                                      
%                                                                                                     
%  the 11th Gen Intel(R) Core(TM) i7-11700 processor with the primary frequency of 2.50GHz, 16GB memory, and the operating system of 64-bit windows 11 using matlab2021a.                                                                
%                                                                                                     
%  Author and programmer: Heming Jia,Raohonghua,Wen changshengSeyedali Mirjalili                                                          
%                                                                                                     
%         e-Mail: jiaheminglucky99@126.com;                                                             
%                 20200862235@fjsmu.edn.cn                  
%                                                                                                                                                   
%_______________________________________________________________________________________________
% You can simply define your cost function in a seperate file and load its handle to fobj 
% The initial parameters that you need are:
%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of iterations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single numbers

% To run SCA: [Best_score,Best_pos,cg_curve]=SCA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%______________________________________________________________________________________________
function [best_fun,best_position,cuve_f,Trajectories,fitness_history,position_history,golabl_fitness]  =PCOA(N,T,lb,ub,dim,fobj)
cuve_f=zeros(1,T); %设置曲线
X=initialization(N,dim,ub,lb); %初始化位置
t=1; %循环的次数
Trajectories=zeros(N,T);%轨迹
fitness_history=zeros(N,T);%适应度历史
position_history=zeros(N,T,dim);%位置（解）历史
golabl_fitness = zeros(1,N);
Best_fitness = inf;%定义全局最优
best_position = zeros(1,dim); %定义最优位置
fitness_f = zeros(1,N);
for i=1:N
   fitness_f(i) =  fobj(X(i,:)); %计算函数的适应度值
   if fitness_f(i)<Best_fitness
       Best_fitness = fitness_f(i);
       best_position = X(i,:);
   end
end
global_fitness = fitness_f(i);
global_position = X(i,:);
cuve_f(1)=Best_fitness;
while(t<=T)
    C = 2-(t/T);
    temp = rand*15+20;
    xf = (best_position+global_position)/2;
    Xfood = best_position;
    for i = 1:N
        if temp>30
            if rand>0.5
                Xnew(i,:) = X(i,:)+C*rand*(xf-X(i,:));
            else
                for j = 1:dim
                    z = round(rand*(N-1))+1;
                    Xnew(i,j) = X(i,j)-X(z,j)+xf(j);
                end
            end
        else
            P = 3*rand*fitness_f(i)/fobj(Xfood);
            if P>3   %食物太大
                 Xfood = exp(-1/P).*Xfood;
                for j = 1:dim
                    Xnew(i,j) = X(i,j)+cos(2*pi*rand)*Xfood(j)*p_obj(temp)-sin(2*pi*rand)*Xfood(j)*p_obj(temp);
                end
            else
                Xnew(i,:) = (X(i,:)-Xfood)*p_obj(temp)+p_obj(temp)*rand*X(i,:);
            end
        end
    end
    for i=size(ub,1)
    Xnew = min(ub(i),Xnew);
    Xnew = max(lb(i),Xnew);
    end
    global_position = Xnew(1,:);
    global_fitness = fobj(global_position);
    for i =1:N
        new_fitness = fobj(Xnew(i,:));
        
        
        if new_fitness<fitness_f(i)
             fitness_f(i) = new_fitness;
             X(i,:) = Xnew(i,:);
             if fitness_f(i)<global_fitness
                 global_fitness = fitness_f(i);
                 global_position = X(i,:);
             end
        end
        position_history(i,t,:)=X(i,:);
        fitness_history(i,t)=fitness_f(1,i);
    end
    Trajectories(:,t)=X(:,1);
    golabl_fitness(t) = global_fitness;    
    if global_fitness<Best_fitness
        Best_fitness = global_fitness;
        best_position = global_position;
    end
   cuve_f(t) = Best_fitness;
   t=t+1;
   if mod(t,50)==0
      % disp("COA"+"iter"+num2str(t)+": "+Best_fitness); 
   end
end
 best_fun = Best_fitness;
end
function y = p_obj(x)
    y = 0.2*(1/(sqrt(2*pi)*3))*exp(-(x-25).^2/(2*3.^2));
end
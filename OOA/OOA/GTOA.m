function [Leader_score,Leader_pos,Convergence_curve] = GTOA(SearchAgents_no,Max_iter,lb,ub,dim,fobj)
%TLOB 此处显示有关此函数的摘要
%   此处显示详细说明
VarSize = [1 dim];

Leader_pos=zeros(1,dim);%产生1行d列全零阵存儲位置
Leader_score=inf; %change this to -inf for maximization problems%为最大化问题将此更改为-INF
%Initialize the positions of search agents初始化搜索代理的位置
Positions=initialization(SearchAgents_no,dim,ub,lb);%初始化粒子位置
fitness=zeros(SearchAgents_no,1);

% Create Empty Solution
NewPosition = zeros(1,dim);
        
Convergence_curve=zeros(1,Max_iter);%收敛曲线

t=0;% Loop counter计数变量

for i = 1:SearchAgents_no
    Flag4ub=Positions(i,:)>ub;
    Flag4lb=Positions(i,:)<lb;
    Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
    fitness(i) = fobj(Positions(i,:));
    if fitness(i) < Leader_score
        Leader_score = fitness(i);
        Leader_pos = Positions(i,:);
    end
end

Ngood=round(SearchAgents_no/2);
Nbad=SearchAgents_no-Ngood;
[sorted_fitness,sorted_indexes]=sort(fitness);%升序排列

for newindex=1:SearchAgents_no   %新的索引序列
    Sorted_X(newindex,:)=Positions(sorted_indexes(newindex),:);
end
Positions=Sorted_X;

% Main loop主循环
while t<Max_iter
    
    % Calculate Population Mean
    Mean = 0;
    for i = 1:SearchAgents_no
        Mean = Mean + Positions(i,:);
    end
    Mean = Mean/SearchAgents_no;
    
    
    %定义老师
    TM=(Positions(1,:)+Positions(2,:)+Positions(3,:))/3;
    fTM=fobj(TM);
    if sorted_fitness(1)<fTM
        Teacher=Positions(1,:);
    else
        Teacher=TM;
    end
    
    
    % Teacher Phase
    for i = 1:SearchAgents_no
        
        if i<=Ngood
            F=round(1+rand());  %F是1或者2
            b=rand;
            c=1-b;
            NewPosition=Positions(i,:)+rand.*(Teacher-F*(b*Mean+c*Positions(i,:)));
            
        else
             NewPosition=Positions(i,:)+2*rand.*(Teacher-Positions(i,:));
        end
        %拉回边界
        NewPosition = max(NewPosition, lb);
        NewPosition = min(NewPosition, ub);

        Newfitness = fobj(NewPosition);
        % Comparision
        if Newfitness<fitness(i)
            Positions(i,:) = NewPosition;
            fitness(i)=Newfitness;
            if fitness(i) < Leader_score
                Leader_score = fitness(i);
                Leader_pos = Positions(i,:);
            end
        end
        % Teaching (moving towards teacher)
        A = 1:SearchAgents_no;
        A(i) = [];
        j = A(randi(SearchAgents_no-1));
        
        Step = Positions(i,:) - Positions(j,:);
        if fitness(j) < fitness(i)
            Step = -Step;
        end

        NewPosition=Positions(i,:)+rand.*Step+rand.*(Positions(i,:)-Sorted_X(i,:));

        NewPosition = max(NewPosition, lb);
        NewPosition = min(NewPosition, ub);
        
        Newfitness = fobj(NewPosition);
        % Comparision
        if Newfitness<fitness(i)
            Positions(i,:) = NewPosition;
            fitness(i)=Newfitness;
            if fitness(i) < Leader_score
                Leader_score = fitness(i);
                Leader_pos = Positions(i,:);
            end
        end
    end
    [sorted_fitness,sorted_indexes]=sort(fitness);%升序排列

    for newindex=1:SearchAgents_no   %新的索引序列
        Sorted_X(newindex,:)=Positions(sorted_indexes(newindex),:);
    end
    Positions=Sorted_X;

    t=t+1;
    Convergence_curve(t)=Leader_score;%收敛曲线求取
end



   

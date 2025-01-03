%_________________________________________________________________________%
%  Remora Optimization Algorithm (ROA) source codes demo 1.0              %
%  Developed in MATLAB R2017b                                             %
%  Author and programmer: Heming Jia, Xiaoxu Peng, Chunbo Lang            %
%  Contact                                                                %
%  E-Mail: jiaheminglucky99@126.com;                                      %
%  pengxiaoxu@nefu.edu.cn; langchunbo@nefu.edu.cn                         %
%_________________________________________________________________________%

% The Remora Optimization Algorithm
function [Best_score,Best_pos,Div,Trajectories,fitness_history, position_history]=ROA(SearchAgents_no,Max_iter,lb,ub,dim,fobj)
%disp('ROA is now estimating the global optimum for your problem....')

% initialize Best position_________________________________________________
Best_pos=zeros(1,dim);
%change this to -inf for maximization problems_____________________________
Best_score = inf;    

%Initialize the positions of search agents_________________________________
Positions=initialization(SearchAgents_no,dim,ub,lb);
Positions_attempt=zeros(SearchAgents_no,dim);
Positions_previous=initialization(SearchAgents_no,dim,ub,lb);
Convergence_curve=zeros(1,Max_iter);

%The drawing of the trajectory_____________________________________________
Trajectories=zeros(SearchAgents_no,Max_iter);
fitness_history=zeros(SearchAgents_no,Max_iter);
position_history=zeros(SearchAgents_no,Max_iter,dim);

fitness=zeros(1,SearchAgents_no);
H=round(rand(1,SearchAgents_no));

% Main loop________________________________________________________________
for t=1:Max_iter    
    
    %Estimate______________________________________________________________
    for i=1:size(Positions,1)
        
        % Boundary detection_______________________________________________
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb; 
        
        % Calculate objective function for each search agent_______________
        %fitness(i)=fobj(Positions(i,:));
        fitness(i)=fobj(Positions(i,:));
        fitness_history(i,t)=fitness(1,i);
        position_history(i,t,:)=Positions(i,:);
        Trajectories(:,t)=Positions(:,1);
        
        % Update the Best solution_________________________________________
        % Change this to > for maximization problem
        if fitness(i)<Best_score 
            Best_score=fitness(i); 
            Best_pos=Positions(i,:);
        end
    end
    
    %Update________________________________________________________________
    for i=1:size(Positions,1)     
        a1=2-t*((2)/Max_iter);    
        r1=rand();      
        
        %The host can be replaced properly
        %WOA Strategy______________________________________________________
        if H(i)==0  
                a2=-1+t*((-1)/Max_iter); 
                l=(a2-1)*rand+1;
                distance2Leader=abs(Best_pos-Positions(i,:));
                Positions(i,:)=distance2Leader*exp(l).*cos(l.*2*pi)+Best_pos;    
                
                
        %SFO Strategy______________________________________________________   
        elseif  H(i)==1 
                rand_leader_index = floor(SearchAgents_no*rand()+1);
                X_rand = Positions(rand_leader_index, :);
                Positions(i,:) = Best_pos - (rand(1,dim) .* (Best_pos+X_rand)/2 - X_rand);  
        end
        %Experience Attack_________________________________________________
        Positions_attempt(i,:)=Positions(i,:)+(Positions(i,:)-Positions_previous(i,:)).*randn;
        if fobj(Positions_attempt(i,:))<fobj(Positions(i,:))
            Positions(i,:)=Positions_attempt(i,:);
            H(i)=round(rand);
            
            fitness_history(i,t)=fobj(Positions_attempt(i,:));
            position_history(i,t,:)=Positions_attempt(i,:);
            Trajectories(:,t)=Positions_attempt(:,1);
        else   
        %Host Feeding______________________________________________________    
        A=(2*a1*r1-a1);                                                    
        C=0.1; %Remora factor 
        Positions(i,:)=Positions(i,:)-A*(Positions(i,:)-C*Best_pos);     
        end
        
    end
    Positions_previous=Positions;
    Convergence_curve(t)=Best_score;
    %disp(['In iteration #', num2str(t), ' , target''s objective = ', num2str(Best_score)])
    
    %%Wilcoxon_plot
    
    pTemp=zeros(SearchAgents_no,dim);
    
    for i=1:SearchAgents_no
        pTemp(i,:)=Positions(i,:);
    end

    
    pTemp2=zeros(SearchAgents_no,dim);
    for j=1:dim
        for i=1:SearchAgents_no
            pTemp2(i,j)=pTemp(i,j)+abs(min(pTemp(:,j)));
        end
        if max(pTemp2(:,j))>0
            pTemp2(:,j)=pTemp2(:,j)/max(pTemp2(:,j));
        else
            pTemp2(:,j)=0;
        end
    end
    temp=[];
    for j=1:dim
        temp(j)=mean(abs(pTemp2(:,j)-mean(pTemp2(:,j))));
    end
    Div(t)= sum(temp)/SearchAgents_no;
     t=t+1;
    
end
end
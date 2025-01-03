%% GSA
function [Fbest,Lbest,BestChart]=GSA(N,max_it,low,up,dim,fobj)
%V:   Velocity.
%a:   Acceleration.
%M:   Mass.  Ma=Mp=Mi=M;
%dim: Dimension of the test function.
%N:   Number of agents.
%X:   Position of agents. dim-by-N matrix.
%R:   Distance between agents in search space.
%[low-up]: Allowable range for search space.
%Rnorm:  Norm in eq.8.
%Rpower: Power of R in eq.7.
Rnorm=2;
ElitistCheck=1; 
Rpower=1;
min_flag=1; 
%get allowable range and dimension of the test function.
%random initialization for agents.
X=initialization(N,dim,up,low);
%create the best so far chart and average fitnesses chart.
BestChart=[];MeanChart=[];
V=zeros(N,dim);
for iteration=1:max_it
    %     iteration
    
    %Checking allowable range.
    X=space_bound(X,up,low);
    
    %Evaluation of agents.
    fitness=evaluateF(X,fobj);
    
    if min_flag==1
        [best best_X]=min(fitness); %minimization.
    else
        [best best_X]=max(fitness); %maximization.
    end
    
    if iteration==1
        Fbest=best;Lbest=X(best_X,:);
    end
    if min_flag==1
        if best<Fbest  %minimization.
            Fbest=best;Lbest=X(best_X,:);
        end
    else
        if best>Fbest  %maximization
            Fbest=best;Lbest=X(best_X,:);
        end
    end
    BestChart=[BestChart Fbest];
    MeanChart=[MeanChart mean(fitness)];
    %Calculation of M. eq.14-20
    [M]=massCalculation(fitness,min_flag);
    %Calculation of Gravitational constant. eq.13.
    G=Gconstant(iteration,max_it);
    %Calculation of accelaration in gravitational field. eq.7-10,21.
    a=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,max_it);
    %Agent movement. eq.11-12
    [X,V]=move(X,a,V);
end %iteration
end

%% 该函数计算引力常数
function G=Gconstant(iteration,max_it)
alfa=20;
G0=100;
G=G0*exp(-alfa*iteration/max_it); 
end

%% 适应度评价
function   fitness=evaluateF(X,fobj)
[N,dim]=size(X);
for i=1:N 
    L=X(i,:); 
    fitness(i)=fobj(L);
end
end

%% 更新速度和位置
function [X,V]=move(X,a,V)
[N,dim]=size(X);
V=rand(N,dim).*V+a; %eq. 11.
X=X+V; %eq. 12.
end

%% 该函数计算重力场中每个介质的加速度
function a=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,max_it)
[N,dim]=size(X);
final_per=2;
if ElitistCheck==1
    kbest=final_per+(1-iteration/max_it)*(100-final_per);
    kbest=round(N*kbest/100);
else
    kbest=N; %eq.9.
end
[Ms ,ds]=sort(M,'descend');
for i=1:N
    E(i,:)=zeros(1,dim);
    for ii=1:kbest
        j=ds(ii);
        if j~=i
            R=norm(X(i,:)-X(j,:),Rnorm);
            for k=1:dim
                E(i,k)=E(i,k)+rand*(M(j))*((X(j,k)-X(i,k))/(R^Rpower+eps));
            end
        end
    end
end
a=E.*G;
end

%%  此函数计算每个个体的质量 
function [M]=massCalculation(fit,min_flag)
Fmax=max(fit); Fmin=min(fit); 
Fmean=mean(fit); 
[i N]=size(fit);

if Fmax==Fmin
   M=ones(N,1);
else
    
   if min_flag==1 %for minimization
      best=Fmin;worst=Fmax; %eq.17-18.
   else %for maximization
      best=Fmax;worst=Fmin; %eq.19-20.
   end
  
   M=(fit-worst)./(best-worst); %eq.15,

end

M=M./sum(M); %eq. 16.
end

%% 检查边界
function  X=space_bound(X,up,low)
[N,dim]=size(X);
for i=1:N 
    Tp=X(i,:)>up;Tm=X(i,:)<low;X(i,:)=(X(i,:).*(~(Tp+Tm)))+((rand(1,dim).*(up-low)+low).*(Tp+Tm));

end
end


% Developed in MATLAB R2017b
% Source codes demo version 1.0
% _____________________________________________________

%  Author, inventor and programmer: Iraj Naruei and Farshid Keynia,
%  e-Mail: irajnaruei@iauk.ac.ir , irajnaruei@yahoo.com
% _____________________________________________________
%  Co-author and Advisor: Farshid Keynia
%
%         e-Mail: fkeynia@gmail.com
% _____________________________________________________
%  Co-authors: Amir Sabbagh Molahoseyni
%        
%         e-Mail: sabbagh@iauk.ac.ir
% 一只章鱼8只触角一个头，每个触角有自己神经系统，可以独立，触角最好位置与头替换
% 3只冲刺章鱼
% _____________________________________________________
% You can find the Wild Horse Optimizer code at 
% _____________________________________________________
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% T: maximum iterations, N: populatoin size, Convergence_curve: Convergence curve
function [pBallScore,pBall,Convergence_curve]=soccer(N,T,lb,ub,dim,fobj)


if size(ub,1)==1
    ub=ones(1,dim).*ub;
    lb=ones(1,dim).*lb;
end

% l=ub(1)-lb(1);
nAMF=floor(N/2); % attacking middle fielder
nDMF=N-nAMF; % defanding middle fielder
% nSS=N-nAMF-nDMF; % second striker
vr=1;

Convergence_curve = zeros(1,T);

pBall=zeros(1,dim);
pBallScore=inf;
pNew.pos=[];
pNew.cost=[];
% pball.pos=[];
% pball.cost=[];
 %create initial population
empty.pos=[];
empty.cost=[];

group=repmat(empty,N,1);

for i=1:N %initial tentacles position
   group(i).pos=lb+rand(1,dim).*(ub-lb);
   group(i).cost=fobj(group(i).pos);
end

[~,index]=min([group.cost]);            
if group(index).cost<pBallScore
   pBall=group(index).pos;
   pBallScore=group(index).cost;
end

t=1; % Loop counter
while t<T
    ld = vr*(1-((t-1)/T)); % linearly decrease from vr to zero
    for i=1:nAMF       
%         angle=rand()*2*pi;
%         group(i).pos=pball.pos+ld*rand()*sin(angle);
        pNew.pos=pBall-ld*abs(rand()*(pBall-group(i).pos)); %控球冲锋
        pNew.cost=fobj(pNew.pos);
        if pNew.cost<group(i).cost
            group(i).pos=pNew.pos;
            group(i).cost=pNew.cost;
        end
%         group(i).cost=fobj(group(i).pos);
    end   
    
    [~,index]=min([group.cost]);
     if group(index).cost<pBallScore
       pBall=group(index).pos;
       pBallScore=group(index).cost;
     end
    
    for j=(nAMF+1):N
%         pNew.pos = group(j-nDefence).pos+rand()*(lb+ub-2*group(j-nDefence).pos)+ld*rand()*(pBall-group(j).pos);
        K=[1:j-1 j+1:N];
        r=K(randi([1 numel(K)]));
        if lb<0.5
            pNew.pos = group(r).pos+rand()*(lb+ub-2*group(r).pos)+ld*rand()*(pBall-group(j).pos);  %一部分补位防守
            pNew.cost=fobj(pNew.pos);    
        else    
            pNew.pos = group(j).pos+ld*rand()*(pBall-group(r).pos);  %一部分补位中锋
            pNew.cost=fobj(pNew.pos);
        end
        if pNew.cost<group(j).cost
            group(j).pos=pNew.pos;
            group(j).cost=pNew.cost;
        end
    end
    
    
    for z=1:N
        group(z).pos=min(group(z).pos,ub);
        group(z).pos=max(group(z).pos,lb);
    end   
    
    [~,index]=min([group.cost]);            
    if group(index).cost<pBallScore
       pBall=group(index).pos;
       pBallScore=group(index).cost;
    end
    Convergence_curve(t)=pBallScore;
    t = t + 1;
end
%     display(['At iteration ', num2str(t), ' the best fitness is ', num2str(SP.cost)]);
    
end


% function o=Levy(d)
% beta=1.5;
% sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
% u=randn(1,d)*sigma;v=randn(1,d);step=u./abs(v).^(1/beta);
% o=step;
% end


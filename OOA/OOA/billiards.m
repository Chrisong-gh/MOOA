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
function [pBestScore,pBest,Convergence_curve]=billiards(N,T,lb,ub,dim,fobj)

if size(ub,1)==1
    ub=ones(1,dim).*ub;
    lb=ones(1,dim).*lb;
end



pBest=zeros(1,dim);
pBestScore=inf;

vr=2;

Convergence_curve = zeros(1,T);

bestRed.pos=[];
bestRed.cost=[];

bestBlue.pos=[];
bestBlue.cost=[];

pball.pos=[];
pball.cost=[];
 %create initial population
empty.pos=[];
empty.cost=[];

groupRed=repmat(empty,nred,1);
groupBlue=repmat(empty,nblue,1);


for i=1:nred %initial tentacles position
   groupRed(i).pos=lb+rand(1,dim).*(ub-lb);
   groupRed(i).cost=fobj(groupRed(i).pos);
end

for i=1:nblue %initial tentacles position
   groupBlue(i).pos=lb+rand(1,dim).*(ub-lb);
   groupBlue(i).cost=fobj(groupBlue(i).pos);
end


% Convergence_curve(1)=SP.cost;

t=1; % Loop counter
while t<T
    ld = vr*(1-((t-1)/T)); % linearly decrease from vr to zero
 
    [~,index]=min([groupRed.cost]);
    SP=groupRed(index); % global shell position
    bestRed.pos=SP.pos;
    bestRed.cost=SP.cost;
    % 
    [~,index]=min([groupBlue.cost]);
    SP=groupBlue(index); % global shell position
    bestBlue.pos=SP.pos;
    bestBlue.cost=SP.cost;

    
    p=rand();
    if p<0.5
        r=randi([1 nred]);
        pball.pos=groupRed(r).pos;
        pball.cost=groupRed(r).cost;
        
        for i=1:nred
            pball.pos=pball.pos-rand()*bestRed.pos;
            pball.cost=fobj(pball.pos);
            groupRed(i).pos=groupRed(i).pos+rand()*(pball.pos-bestRed.pos);
            groupRed(i).cost=fobj(groupRed(i).pos);
        end
        for i=1:nblue
            groupBlue(i).pos=groupBlue(i).pos+rand()*(ld*pball.pos+bestRed.pos);
            groupBlue(i).cost=fobj(groupBlue(i).pos);
        end
        
        [~,index]=min([groupRed.cost]);
        SP=groupRed(index); % global shell position
        bestRed.pos=SP.pos;
        bestRed.cost=SP.cost;
        % 
        [~,index]=min([groupBlue.cost]);
        SP=groupBlue(index); % global shell position
        bestBlue.pos=SP.pos;
        bestBlue.cost=SP.cost;
    else
        
        r=randi([1 nblue]);
        pball.pos=groupBlue(r).pos;
        pball.cost=groupBlue(r).cost;
        
        for i=1:nblue
            pball.pos=pball.pos+rand()*bestBlue.pos;
            pball.cost=fobj(pball.pos);
            groupBlue(i).pos=groupBlue(i).pos+rand()*(pball.pos-bestBlue.pos);
            groupBlue(i).cost=fobj(groupBlue(i).pos);
        end
        for i=1:nred
            groupRed(i).pos=groupRed(i).pos+rand()*(ld*pball.pos+bestBlue.pos);
            groupRed(i).cost=fobj(groupRed(i).pos);
        end

    end

    [~,index]=min([groupRed.cost]); 
    [~,index]=min([groupBlue.cost]);
           
    if groupRed(index).cost<groupBlue(index).cost
       SP=groupRed(index);
    else
        SP=groupBlue(index);
    end
    if SP.cost<pBestScore
        pBest=SP.pos;
        pBestScore=SP.cost;
        Convergence_curve(t)=SP.cost;
    end
    
    t = t + 1;
end
%     display(['At iteration ', num2str(t), ' the best fitness is ', num2str(SP.cost)]);
    
end


function o=Levy(d)
beta=1.5;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
u=randn(1,d)*sigma;v=randn(1,d);step=u./abs(v).^(1/beta);
o=step;
end

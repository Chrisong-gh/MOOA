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
function [pBestScore,pBest,Convergence_curve]=OOA4(N,T,lb,ub,dim,fobj)

if size(ub,1)==1
    ub=ones(1,dim).*ub;
    lb=ones(1,dim).*lb;
end
% %  PS=0.2;     % Octopuss Percentage 
% %  PC=0.13;    % Crossover Percentage
NScout=mod(N,9);   % number scouts 3
NHead=floor((N-NScout)/9); % number Octopus 3
NTentacles=N-NHead-NScout;  % number tenctacles 24
vr = 3; % 视野范围
Convergence_curve = zeros(1,T);
pBest=zeros(1,dim);
pBestScore=inf;
 %create initial population
empty.pos=[];
empty.cost=[];
ll=0.8;
Tgroup=repmat(empty,NTentacles,1);
Scouts=repmat(empty,NScout,1);
Octopus=repmat(empty,NHead,1);

for i=1:NTentacles %initial tentacles position
   Tgroup(i).pos=lb+rand(1,dim).*(ub-lb);
   Tgroup(i).cost=fobj(Tgroup(i).pos);
end

for i=1:NScout %initial tentacles position
   Scouts(i).pos=lb+rand(1,dim).*(ub-lb);
   Scouts(i).cost=fobj(Scouts(i).pos);
end

for i=1:NHead   % initail head position
   Octopus(i).pos=lb+rand(1,dim).*(ub-lb);
   Octopus(i).cost=fobj(Octopus(i).pos);
 
end
  nTgroup=length(Tgroup);
  a=randperm(nTgroup);
  Tgroup=Tgroup(a);

i=0;
k=1;
for j=1:nTgroup    % allocate tentacles to head 3*8
    i=i+1;    
    Octopus(i).Tgroup(k)=Tgroup(j);  
    if i==NHead
        i=0;
        k=k+1;
    end
end
Octopus=exchange(Octopus);
[~,index]=min([Octopus.cost]);
SP=Octopus(index); % global shell position
   pBest=SP.pos;
   pBestScore=SP.cost;
% 
Convergence_curve(1)=SP.cost;

t=2; % Loop counter
while t<T+1
    ld = vr*(1-((t-1)/T)); % linearly decrease from vr to zero
   
    for i=1:NHead
        ng = length(Octopus(i).Tgroup);   
        for j=1:ng  
            trans = ((2*ld)*rand)-ld; %transform between exploration and exploitation -vr~vr
            if abs(trans)<ll % 1 是触角长度  在抓取范围内，迅速抓住猎物
%                 r1 = floor(N*rand()+1);  % 0-30 随机选一个
%                 K=[1:j-1 j+1:ng];
%                 r2=K(randi([1 numel(K)]));
                [~,index]=min([Octopus(i).Tgroup.cost]);
                Octopus(i).Tgroup(j).pos= Octopus(i).Tgroup(j).pos+rand()*(pBest-Octopus(i).Tgroup(index).pos).*Levy(dim); %每个触角受头部和其他触角影响
%                 Octopus(i).Tgroup(j).pos= rand()*SP.pos-rand()*(SP.pos-Octopus(i).Tgroup(r2).pos);
            else
%                 Octopus(i).Tgroup(j).pos=Octopus(i).Tgroup(j).pos+rand()*(SP.pos-Octopus(i).Tgroup(j).pos)*cos(pi/2*((t-1)/T).^2);
%                 Octopus(i).Tgroup(j).pos=Octopus(i).Tgroup(j).pos+rand()*(SP.pos-Octopus(i).Tgroup(j).pos).*Levy(dim);
                Octopus(i).Tgroup(j).pos=Octopus(i).pos+rand()*(Octopus(i).pos-Octopus(i).Tgroup(j).pos).*Levy(dim);
            end 
        
            Octopus(i).Tgroup(j).pos=min(Octopus(i).Tgroup(j).pos,ub);
            Octopus(i).Tgroup(j).pos=max( Octopus(i).Tgroup(j).pos,lb);
            Octopus(i).Tgroup(j).cost=fobj(Octopus(i).Tgroup(j).pos);      
        end
        Octopus=exchange(Octopus);

    end
       
   
    
    flagindex=0;
    for z=1:NScout

        [~,index]=sort([Octopus.cost]);
        if z==1 %best score
            flagindex=1;
            flag= Octopus(index(flagindex));
        elseif z==2 % bad score
            flagindex=length(index);
            flag = Octopus(index(flagindex));
        else
            flagindex= randi([2, length(index)-1]);
            flag = Octopus(index(flagindex));       
        end

        Scouts(z).pos =flag.pos + rand()*ld*(ub+lb-2 * flag.pos);
%             Scouts(z).pos =flag.pos + rand()*((ub+lb)/2-flag.pos);
%         CS = (ub + lb)/2;
%         MP = (ub + lb) - flag.pos;
%         if MP > CS
%             Scouts(z).pos = CS +rand() * (MP - CS);
%         else
%             Scouts(z).pos = MP + rand() * (CS - MP);
%         end


        Scouts(z).pos=min( Scouts(z).pos,ub);
        Scouts(z).pos=max( Scouts(z).pos,lb);
        Scouts(z).cost= fobj(Scouts(z).pos); 
        
        if Scouts(z).cost< flag.cost          
             
%              Octopus(index(flagindex)).pos = Scouts(z).pos;
%             Octopus(index(flagindex)).cost = Scouts(z).cost;
            
            Octopus(index(flagindex)).pos = Scouts(z).pos;
            Octopus(index(flagindex)).cost = Scouts(z).cost;
            for i=1:8
%                 for j=1:ceil(dim/2)
%                          Octopus(index(flagindex)).Tgroup(i).pos(j)= Octopus(index(flagindex)).pos(j)+cos(i*2*pi/7);
%                 end
%                 for j=(ceil(dim/2)+1):dim
%                          Octopus(index(flagindex)).Tgroup(i).pos(j)= Octopus(index(flagindex)).pos(j)+sin(i*2*pi/7); 
%                 end

                Octopus(index(flagindex)).Tgroup(i).pos=-ones(1,dim).*(Octopus(index(flagindex)).pos-ll)+rand(1,dim).*(Octopus(index(flagindex)).pos+ll);%以头为中心的-1到1边界重新生成
                Octopus(index(flagindex)).Tgroup(i).cost=fobj(Octopus(index(flagindex)).Tgroup(i).pos);
              
            end
            Octopus=exchange(Octopus);
            
        end
    end

    [value,index]=min([Octopus.cost]);
    if value<pBestScore
       SP=Octopus(index);
    end
    pBest=SP.pos;
    pBestScore=SP.cost;
    Convergence_curve(t)=SP.cost;
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

function Octopus=exchange(Octopus)

nOctopus=length(Octopus);
%  ngroup = length(Octopus(1).Tgroup);

    for i=1:nOctopus

       [value,index]=min([Octopus(i).Tgroup.cost]);

       if value<Octopus(i).cost

           bestgroup=Octopus(i).Tgroup(index);

           Octopus(i).Tgroup(index).pos=Octopus(i).pos;
           Octopus(i).Tgroup(index).cost=Octopus(i).cost;


           Octopus(i).pos=bestgroup.pos;
           Octopus(i).cost=bestgroup.cost;

       end

    end
end

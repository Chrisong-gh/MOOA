classdef MOOA31 < ALGORITHM
% <multi> <real> <constrained/none>
% Multi-Objectives with octopus optimization algorithm

%------------------------------- Reference --------------------------------
%
%------------------------------- Copyright --------------------------------
% Copyright (c) 2022 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        function main(Algorithm,Problem)

            %% Generate random population
            Population = Problem.Initialization();
            
            p=0.7;
            Ng=floor(Problem.N/9*p);% number of group(octopus) n=100 ng 7
            Nmem=8;
            GI = 1:9:Ng*9; % group index   
            NScout = Problem.N-Ng*9;  %number of scout   
            vr = 3; % range of vision
            ll=0.8; %  length of tentacle
            
            %% Optimization
            while Algorithm.NotTerminated(Population)

                decs=Population.decs;
                ld = vr * (1-((Problem.FE-Problem.N)/Problem.maxFE));
                [Group, Gbest]=Grouping1(Population,Ng,Nmem);
                for ih=1:Ng
                    for im=2:Nmem+1
%                         ih
%                         im
                        trans =((2*ld)*rand)-ld; %transform between exploration and exploitation -vr~vr
                        if abs(trans)<ll  %transform between exploration and exploitation -vr~vr
%                             Octopus(i).Tgroup(j).pos= Octopus(i).Tgroup(j).pos+rand()*(pBest-Octopus(i).Tgroup(index).pos).*Levy(Problem.D); 
%                             Group(iHead).group(im).dec= Group(iHead).group(im).dec+rand()*(Gbest-Group(iHead).group(im).dec).*Levy(Problem.D);
                            Group(ih).group(im,:)=Group(ih).group(im,:) ...
                                +rand()*(Gbest.decs-Group(ih).group(im,:)) ...
                               .*Levy(Problem.D);
                        else
%                             Octopus(i).Tgroup(j).pos=Octopus(i).pos+rand()*(Octopus(i).pos-Octopus(i).Tgroup(j).pos).*Levy(Problem.D);
%                             Group(iHead).group(im).dec= Group(iHead).group(1).dec+rand()*(Group(iHead).group(1).dec-Group(iHead).group(im).dec).*Levy(Problem.D);
%                             k=[1:im-1 im+1:9];
%                             r=k(randi([1 numel(k)]));                           
                            Group(ih).group(im,:)=Group(ih).group(1,:)+rand()*(Group(ih).group(1,:)-Group(ih).group(im,:)) ...
                                .*Levy(Problem.D);
                        end
                    end
                decs=[decs; Group(ih).group(2:end,:)];    
                end
                ndecs=size(decs,1); %100+9*7=163
                iscout=randperm(ndecs,NScout);
                ScoutDec=decs(iscout,:);
                for i=1:length(iscout)
                   ScoutDec(i,:) = (Problem.upper+Problem.lower)/2 + rand()*( (Problem.upper+Problem.lower) /2- ScoutDec(i,:));
                end
                decs=[decs; ScoutDec];
                Population=Problem.Evaluation(decs);
                [Population,FronNo,~]=EnvironmentalSelection1(Population,Problem.N);
            end
            PF=Problem.PF;
        end
    end
end
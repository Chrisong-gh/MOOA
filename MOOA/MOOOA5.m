classdef MOOOA5 < ALGORITHM
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
            GI = 1:9:Ng*9; % group index   
            NScout = Problem.N-Ng*9;  %number of scout   
            vr = 3; % range of vision
            ll=0.8; %  length of tentacle
            Nmem=8;
            %% Optimization
            while Algorithm.NotTerminated(Population)

                [~, Gbest]=Grouping(Population,Ng,Nmem);
                ld = vr * (1-((Problem.FE-Problem.N)/Problem.maxFE));
                decs=Population.decs;
                for iHead=1:Ng
                    Group(iHead).group=Population(GI(iHead):GI(iHead)+8);
                    GroupDec= Group(iHead).group.decs;
                    [~, Head]=Grouping(Group(iHead).group,1,9);
                    for iTenta=1:9
                        trans =((2*ld)*rand)-ld; %transform between exploration and exploitation -vr~vr
                        if abs(trans)<ll  %transform between exploration and exploitation -vr~vr

                            GroupDec(iTenta,:)=GroupDec(iTenta,:)+rand()*(Gbest.decs-GroupDec(iTenta,:)).*Levy(Problem.D);
                        else
%                             Octopus(i).Tgroup(j).pos=Octopus(i).pos+rand()*(Octopus(i).pos-Octopus(i).Tgroup(j).pos).*Levy(Problem.D);
%                             Group(iHead).group(iTenta).dec= Group(iHead).group(1).dec+rand()*(Group(iHead).group(1).dec-Group(iHead).group(iTenta).dec).*Levy(Problem.D);
%                             k=[1:iTenta-1 iTenta+1:9];
%                             r=k(randi([1 numel(k)]));
                            
                            GroupDec(iTenta,:)=GroupDec(1,:)+rand()*(Head.decs-GroupDec(iTenta,:)).*Levy(Problem.D);
                        end
                    end   
                    decs=[decs; GroupDec];
                end
                ndecs=size(decs,1); %100+9*7=163
                iscout=randperm(ndecs,NScout);
                ScoutDec=decs(iscout,:);
                for i=1:length(iscout)
                   ScoutDec(i,:) = (Problem.upper+Problem.lower)/2 + rand()*( (Problem.upper+Problem.lower) /2- ScoutDec(i,:));
                end
                decs=[decs; ScoutDec];
                Population=Problem.Evaluation(decs);
                [Population,FronNo,~]=EnvironmentalSelection(Population,Problem.N);
            end
        end
    end
end
classdef SOA < ALGORITHM
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
            Ng=Problem.N/2;
            %% Optimization
            while Algorithm.NotTerminated(Population)

                [Gbest,~]=NDselector(Population,Problem.N,);
                
            end
        end
    end
end
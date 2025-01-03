function CrowdDis = CrowdingDistance1(PopObj)
%CrowdingDistance - Calculate the crowding distances of solutions front
%by front.
%
%   CD = CrowdingDistance(F) calculates the crowding distances of solutions
%   according to their objective values in F.
%
%   CD = CrowdingDistance(F,FrontNo) calculates the crowding distances of
%   solutions in each non-dominated front, where FrontNo is the front
%   numbers of solutions.
%
%   Example:
%       CrowdDis = CrowdingDistance(PopObj,FrontNo)

%------------------------------- Reference --------------------------------
% S. Kukkonen and K. Deb, Improved pruning of non-dominated solutions based
% on crowding distance for bi-objective optimization problems, Proceedings
% of the IEEE Congress on Evolutionary Computation, 2006, 1179-1186.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2023 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    [N,M] = size(PopObj);
    % if nargin < 2
    %     FrontNo = ones(1,N);
    % end
    CrowdDis = zeros(1,N);
    % Fronts   = setdiff(unique(FrontNo),inf);
    % for f = 1 : length(Fronts)
        % Front = find(FrontNo==Fronts(f));
        Fmax  = max(PopObj,[],1);
        Fmin  = 0;
        for i = 1 : M
            [~,Rank] = sortrows(PopObj(:,i));
            % CrowdDis(Front(Rank(1)))   = inf;
            % CrowdDis(Front(Rank(end))) = 1e-4;
            % if length(Rank)>1
            CrowdDis(Rank(1)) = CrowdDis(Rank(1))+(PopObj(Rank(2),i)-Fmin)/(Fmax(i)-Fmin);
            CrowdDis(Rank(end)) = CrowdDis(Rank(end))+(Fmax(i)-PopObj(Rank(end-1),i))/(Fmax(i)-Fmin);
            % else
            %     CrowdDis(Front(Rank(1))) = CrowdDis(Front(Rank(1)))+PopObj(Front(Rank(1)),i)/Fmax(i);
            % end

            
            for j = 2 : N-1
                CrowdDis(Rank(j)) = CrowdDis(Rank(j))+(PopObj(Rank(j+1),i)-PopObj(Rank(j-1),i))/(Fmax(i)-Fmin);
            end
        end
    % end
end
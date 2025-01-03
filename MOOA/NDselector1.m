function [Gbest,nGbest]=NDselector1(Population,num)

    N=length(Population);
    PopObj=Population.objs;
    % [FrontNo,~] = NDSort(PopObj,size(Population,1));
    % CrowdDis = CrowdingDistance1(PopObj);

    nGbest=[];
    Gbest=[];
    % for i=1:max(FrontNo)
        % iGbest=find(FrontNo==i);
        [~,M]=size(PopObj);
        p=zeros(1,M);
        Con =pdist2(PopObj,p);
        Con= (Con-min(Con))./(max(Con)-min(Con))+1e-6;
        % CrowdDis=CrowdDis./Con;
        
        [value,Rank]=sort(CrowdDis,'descend');
    %         find(value~=Inf,1,'first')
        last=num+1-length(nGbest);
        if last>0
            if length(Rank)>=last
                nGbest=[nGbest Rank(1:last)];
            else 
                nGbest=[nGbest Rank(1:end)];
            end
        end
        if length(nGbest)==(num+1)
            Gbest=Population(nGbest(1));
            return; 
        end          
    % end
    if isempty(Gbest)
            a=1;
    end
end
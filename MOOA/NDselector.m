function [Gbest,nGbest]=NDselector(Population,num)

    N=length(Population);
    [Population,FrontNo,CrowdDis] = EnvironmentalSelection(Population,N);
    nGbest=[];
    Gbest=[];
    for i=1:max(FrontNo)
        iGbest=find(FrontNo==i);
        [value,Rank]=sort(CrowdDis(iGbest),'descend');
    %         find(value~=Inf,1,'first')
        last=num+1-length(nGbest);
        if last>0
            if length(Rank)>=last
                nGbest=[nGbest iGbest(Rank(1:last))];
            else 
                nGbest=[nGbest iGbest(Rank(1:end))];
            end
        end
        if length(nGbest)==(num+1)
            Gbest=Population(nGbest(1));
            return; 
        end          
    end
    if isempty(Gbest)
            a=1;
    end
end
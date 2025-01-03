function [Group,Gbest] = Grouping(Population,Ng,Nmem)
% 

%------------------------------- Copyright --------------------------------
% Copyright (c) 2022 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    decs=Population.decs;
    %% Find the Global best with FrontNo==1 and Max CrowdDistance
    [Gbest,nhead]=NDselector(Population,Ng); %gbest Global best
    if isempty(Gbest)
            i=1;
    end
    %% Find the other Ng best except Gbest (candidate) solutions and divided into Ng groups (Leader)
    allheads=[];
    for i=1:Ng
%         Group(i).head=Population(nhead(i+1)).decs; 
%         Group(i).group=[];
%         allheads=[allheads; Group(i).head]  
        Group(i).group(1,:)= Population(nhead(i+1)).decs; %7*30
        allheads=[allheads; Group(i).group(1,:)]; % all head: head positions
    end
    %% calculate the Euclidean distance between Population.decs and candidate solutions for grouping (Member) 
    eucli=pdist2(decs, allheads); %100*7
    flag=0;
    for j=1:size(decs,1)
        [~,rank]=sort(eucli(j,(find(eucli(j,:)~=0))));     
%         for r=1:length(rank)
        for r=1:length(rank)
            index=size(Group(rank(r)).group,1)+1 ; % 
            if index<=9
                Group(rank(r)).group(index,:)=decs(j,:); % reorganization
                flag=flag+1;
                break;
            end
            if flag== Ng*Nmem
                for i=1:Ng
                    if size(Group(i).group,1)<9
                        b=1;
                    end
                end
               return;
            end
        end
    end
    for i=1:Ng
        index=size(Group(i).group,1); 
        if index<Nmem+1
            last=Nmem+1-index;
            while last>0
                index=index+1;
                flag=flag+1;
                Group(i).group(index,:)=decs(flag,:);
                last=last-1;
            end
        end
    end
end
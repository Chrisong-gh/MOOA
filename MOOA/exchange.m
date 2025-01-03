function Group=exchange(Group,N)

        [Groupbest,index]=NDselector(Group,N);
        if index~=1
            Group(index)=Group(1);
            Group(1)=Groupbest;
        end
        
end
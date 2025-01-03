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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
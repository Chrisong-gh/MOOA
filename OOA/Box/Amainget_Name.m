function [Aobj] = Amainget_Name(A)
switch A
    case 1
        Aobj=@OOA4;
    case 2
        Aobj=@SCSO;
    case 3
        Aobj=@SSA;
    case 4
        Aobj=@WOA;
%             Aobj=@AO;
    case 5
        Aobj=@AOA;
    case 6
        % Aobj=@GSA;
        Aobj=@PSO;
    case 7
        Aobj=@GTOA;
end
end



function [Aobj] = Get_A_name(A)
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
            Aobj=@COA;
        case 7
            Aobj=@GTOA;
        case 8
            Aobj=@soccer;
%             Aobj=@HHO;
        case 9
            Aobj=@ROA;
        case 10
            Aobj=@PSO;
%             Aobj=@RSA;
        case 11
            Aobj=@soccer;
%         case 3
%             Aobj=@SMA;
%         case 4
%             Aobj=@AO;
%         case 5
%             Aobj=@AOA;
%         case 6
%             Aobj=@GTO;
%         case 7
%             Aobj=@GWO;
%         case 8
%             Aobj=@HHO;
%         case 9
%             Aobj=@ROA;
    end

end
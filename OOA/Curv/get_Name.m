function [Aobj] = get_Name(A)
switch A
    case 1
        Aobj = @OOA4;
    case 2
        Aobj = @SCSO;  
    case 3
        Aobj = @SSA;
    case 4
        Aobj = @WOA;
    case 5
        Aobj = @AOA;
    case 6
        Aobj = @PSO;
    case 7
        Aobj = @GTOA;
    case 8
        Aobj = @PDO;
    case 9
        Aobj = @WOA;
    case 10
        Aobj = @DTLZ1;
    case 11
        Aobj = @DTLZ2;
    case 12
        Aobj = @DTLZ3;
    case 13
        Aobj = @DTLZ4;
    case 14
        Aobj = @SHO;
    case 15
        Aobj = @AOA;
    case 16
        Aobj = @PDO;
    case 17
        Aobj = @HHO;
    case 18
        Aobj = @SFO;
end
end
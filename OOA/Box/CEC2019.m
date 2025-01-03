function [lb,ub,dim,fobj] = CEC19(F)

switch F
    case 'F1'
        fobj = @F1;
        lb=-8192;
        ub=8192;
        dim=9;
        
    case 'F2'
        fobj = @F2;
        lb=-16384;
        ub=16384;
        dim=16;
        
    case 'F3'
        fobj = @F3;
        lb=-4;
        ub=4;
        dim=18;
        
    case 'F4'
        fobj = @F4;
        lb=-100;
        ub=100;
        dim=10;
        
    case 'F5'
        fobj = @F5;
        lb=-100;
        ub=100;
        dim=10;
        
    case 'F6'
        fobj = @F6;
        lb=-100;
        ub=100;
        dim=10;
        
    case 'F7'
        fobj = @F7;
        lb=-100;
        ub=100;
        dim=10;
        
    case 'F8'
        fobj = @F8;
        lb=-100;
        ub=100;
        dim=10;
        
    case 'F9'
        fobj = @F9;
        lb=-100;
        ub=100;
        dim=10;
        
    case 'F10'
        fobj = @F10;
        lb=-100;
        ub=100;
        dim=10;
end
end
% F1
function o = F1(x) 
    o = cec19_func(x',1);
end

% F2
function o = F2(x) 
    o = cec19_func(x',2);
end

% F3
function o = F3(x) 
    o = cec19_func(x',3);
end

% F4
function o = F4(x) 
    o = cec19_func(x',4);
end

% F5
function o = F5(x) 
    o = cec19_func(x',5);
end

% F6
function o = F6(x) 
    o = cec19_func(x',6);
end

% F7
function o = F7(x) 
    o = cec19_func(x',7);
end

% F8
function o = F8(x) 
    o = cec19_func(x',8);
end

% F9
function o = F9(x) 
    o = cec19_func(x',9);
end

% F10
function o = F10(x) 
    o = cec19_func(x',10);
end

function CEC_2020_plot(func_name)
[lb,ub,dim,f_obj] = CEC2020(func_name);

switch func_name
    case 'F1'
        x=-100:1:100; y=x; %[-100,100]
        
    case 'F2'
        x=-100:1:100; y=x; %[-10,10]
        
    case 'F3'
        x=-100:1:100; y=x; %[-100,100]
        
    case 'F4'
        x=-100:1:100; y=x; %[-100,100]
    case 'F5'
        x=-100:1:100; y=x; %[-5,5]
    case 'F6'
        x=-100:1:100; y=x; %[-100,100]
    case 'F7'
        x=-100:1:100; y=x;  %[-1,1]
    case 'F8'
        x=-100:1:100;y=x; %[-500,500]
    case 'F9'
        x=-100:1:100; y=x; %[-5,5]
    case 'F10'
        x=-100:1:100; y=x;%[-500,500]
end
L = length(x);
f=[];
for i=1:L
    for j=1:L
        f(i,j) = f_obj([x(j),y(i),0,0,0]);
    end
end
xlabel('[x]');
ylabel('[y]');
surf(x,y,f,'LineStyle','none');
end

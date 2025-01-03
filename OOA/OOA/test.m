% N=30;
% dim=30;
% lb=-100;
% ub=100;
% 
% empty.pos=[];
% empty.cost=[];
% 
% group=repmat(empty,N,1);
% 
% 
% for i=1:N %initial tentacles position
%    group(i).pos=lb+rand(1,dim).*(ub-lb);
%    group(i).cost=fobj(group(i).pos);
% end
% 
% x=1:N;
% y=group(1:end).pos;
% stem(x,y,'*');

T=500;
t=1:T;
y=cos(pi.*(t/T).^2./2);
plot(t,y)



%Chebyshev map
T = 60;
x=1:1:T;
y=chaos(1,T,1);
subplot(251);plot(x,y,'LineWidth',1);
title([['\fontsize{10}\bf ', 'Chebyshev map']],'FontName','Times New Roman');
xlabel('\fontsize{10}\bf xi');ylabel('\fontsize{10}\bf Amplitude');

%Circle map
y=chaos(2,T,1);
subplot(252);plot(x,y,'LineWidth',1);
title([['\fontsize{10}\bf ', 'Circle map']],'FontName','Times New Roman');
xlabel('\fontsize{10}\bf xi');ylabel('\fontsize{10}\bf Amplitude');

%Gauss/mouse map
y=chaos(3,T,1);
subplot(253);plot(x,y,'LineWidth',1);
title([['\fontsize{10}\bf ', 'Gauss/mouse Map']],'FontName','Times New Roman');
xlabel('\fontsize{10}\bf xi');ylabel('\fontsize{10}\bf Amplitude');

%Iterative map
y=chaos(4,T,1);
subplot(254);plot(x,y,'LineWidth',1);
title([['\fontsize{10}\bf ', 'Iterative Map']],'FontName','Times New Roman');
xlabel('\fontsize{10}\bf xi');ylabel('\fontsize{10}\bf Amplitude');

%Logistic map
y=chaos(5,T,1);
% y=chaos(5,30,4);
subplot(255);plot(x,y,'LineWidth',1);
title([['\fontsize{10}\bf ', 'Logistic Map']],'FontName','Times New Roman');
xlabel('\fontsize{10}\bf xi');ylabel('\fontsize{10}\bf Amplitude');

%Piecewise map
y=chaos(6,T,1);
subplot(256);plot(x,y,'LineWidth',1);
title([['\fontsize{10}\bf ', 'Piecewise Map']],'FontName','Times New Roman');
xlabel('\fontsize{10}\bf xi');ylabel('\fontsize{10}\bf Amplitude');

%Sine map
y=chaos(7,T,1);
subplot(257);plot(x,y,'LineWidth',1);
title([['\fontsize{10}\bf ', 'Sine Map']],'FontName','Times New Roman');
xlabel('\fontsize{10}\bf xi');ylabel('\fontsize{10}\bf Amplitude');

%Singer map 
y=chaos(8,T,1);
subplot(258);plot(x,y,'LineWidth',1);
title([['\fontsize{10}\bf ', 'Singer Map']],'FontName','Times New Roman');
xlabel('\fontsize{10}\bf xi');ylabel('\fontsize{10}\bf Amplitude');

%Sinusoidal map
y=chaos(9,T,1);
subplot(259);plot(x,y,'LineWidth',1);
title([['\fontsize{10}\bf ', 'Bernoulli Map']],'FontName','Times New Roman');
xlabel('\fontsize{10}\bf xi');ylabel('\fontsize{10}\bf Amplitude');

%Tent map
y=chaos(10,T,1);
subplot(2,5,10);
plot(x,y,'LineWidth',1);
title([['\fontsize{10}\bf ', 'Tent Map']],'FontName','Times New Roman');
xlabel('\fontsize{10}\bf xi');ylabel('\fontsize{10}\bf Amplitude');

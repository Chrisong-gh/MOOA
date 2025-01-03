function [lb,ub,dim,fobj] = Get_Functions_details_gc_2021(F)
switch F
    case 'F1' %OK
        fobj = @Gear_train_design;  
        lb=[12 12 12 12];
        ub=[60 60 60 60];
        dim=4; 
        
    case 'F2' %OK
        fobj = @Welded_Design;  
        lb=[0.10 0.10 0.10 0.10];
        ub=[2 10 10 2];
        dim=4;
        
    case 'F3' %OK
        fobj = @Pressure_Vessel_design;  
        lb=[0 0 10 10];       
        ub= [99 99 200 200];    
        dim=4;
        
    case 'F4'
        fobj = @I_beam_design_problem;  
        lb=[10 10 0.9 0.9];        
        ub=[50 80 5 5];       
        dim=4;
        
    case 'F5' %OK
        fobj = @Spring_Design;  
        lb=[0.05 0.25 2.00];
        ub=[2.00 1.30 15.0];
        dim=3;
        
    case 'F6' %OK
        fobj = @Speed_Reducer_design;  
        lb=[2.6 0.7 17 7.3 7.8 2.9 5];        
        ub= [3.6 0.8 28 8.3 8.3 3.9 5.5];      
        dim=7;
        
    case 'F7' 
        fobj = @Himmelblaus_Problem;  
        lb=[78 33 27 27 27]; 
        ub=[102 45 45 45 45];   
        dim=5;
        
    case 'F8' %OK
        fobj = @Three_Bar_Truss_Design;  
        lb=[0 0]; 
        ub=[1 1];   
        dim=2;
        
    case 'F9'
        fobj = @Stepped_Cantilever_Beam_Design;  
        lb=[1 1 1 1 1 30 30 30 30 30]; 
        ub=[5 5 5 5 5 65 65 65 65 65];  
        dim=10;
    case 'F10' %OK
        fobj = @Multiple_Disc_Clutch_Brake_Design;  
        lb=[60 90 1 600 2]; 
        ub=[80 110 3 1000 9];   
        dim=5;
        
    case 'F11' %OK
        fobj = @Hydrostatic_Thrust_Bearing_Design;  %流体动力推力轴承设计
        lb=[1 1 1e-6 1];        
        ub=[16 16 16e-6 16];  
        dim=4;
        
    case 'F12' %OK
        fobj = @Cantilever_Beam_Design;  %悬臂梁的设计
        lb=[0.01 0.01 0.01 0.01 0.01];        
        ub=[100 100 100 100 100];     
        dim=5;
        
    case 'F13'
        fobj = @Rolling_element_bearing_problem;  %滚动轴承问题
        lb=[125 10.5 4 0.515 0.515 0.4 0.6 0.3 0.02 0.6];       
        ub=[150 31.5 50 0.6 0.6 0.5 0.7 0.4 0.1 0.85];      
        dim=10;

    case 'F14' %OK
        fobj = @Car_crashworthiness;  
        lb=[0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.192 0.192 -30.0 -30.0];
        ub=[1.5 1.5 1.5 1.5 1.5 1.5 1.5 0.345 0.345 30.0 30.0];
        dim=11;
    case 'F15' %OK
        fobj = @Tubular_Column_Design; 
        lb=[0.01 0.01];        
        ub=[100 100];
        dim=2;
    case 'F16' %OK
        fobj = @Corrugated_Bulkhead_Design; 
        lb=[0 0 0 0];        
        ub=[100 100 100 5];
        dim=4;
    case 'F17' %OK
        fobj = @Frequency_Modulated_Sound_Waves; 
        lb=[-6.4 -6.4 -6.4 -6.4 -6.4 -6.4];        
        ub=[6.35 6.35 6.35 6.35 6.35 6.35];
        dim=6;
end
end

%% Gear train design
function fit=Gear_train_design(x)
fit=((1/6.931)- (floor (x(3))*floor (x(2)))/(floor (x(1))*floor (x(4))))^2;
end

%% WELDED BEAM DESIGN PROBLEM DEFINITION (all units are in british system)
function fit=Welded_Design(x)  %焊接梁设计问题
PCONST = 100000; % PENALTY FUNCTION CONSTANT
P = 6000; % APPLIED TIP LOAD
E = 30e6; % YOUNGS MODULUS OF BEAM
G = 12e6; % SHEAR MODULUS OF BEAM
tem = 14; % LENGTH OF CANTILEVER PART OF BEAM
TAUMAX = 13600; % MAXIMUM ALLOWED SHEAR STRESS
SIGMAX = 30000; % MAXIMUM ALLOWED BENDING STRESS
DELTMAX = 0.25; % MAXIMUM ALLOWED TIP DEFLECTION
M =  P*(tem+x(2)/2); % BENDING MOMENT AT WELD POINT
R = sqrt((x(2)^2)/4+((x(1)+x(3))/2)^2); % SOME CONSTANT
J =  2*(sqrt(2)*x(1)*x(2)*((x(2)^2)/4+((x(1)+x(3))/2)^2)); % POLAR MOMENT OF INERTIA
fit =  1.10471*x(1)^2*x(2)+0.04811*x(3)*x(4)*(14+x(2)); % OBJECTIVE FUNCTION
SIGMA = (6*P*tem)/(x(4)*x(3)^2); % BENDING STRESS
DELTA = (4*P*tem^3)/(E*x(3)^3*x(4)); % TIP DEFLECTION
PC = 4.013*E*sqrt((x(3)^2*x(4)^6)/36)*(1-x(3)*sqrt(E/(4*G))/(2*tem))/(tem^2); % BUCKLING LOAD
TAUP =  P/(sqrt(2)*x(1)*x(2)); % 1ST DERIVATIVE OF SHEAR STRESS
TAUPP = (M*R)/J; % 2ND DERIVATIVE OF SHEAR STRESS
TAU = sqrt(TAUP^2+2*TAUP*TAUPP*x(2)/(2*R)+TAUPP^2); % SHEAR STRESS
G1 = TAU-TAUMAX; % MAX SHEAR STRESS CONSTRAINT
G2 =  SIGMA-SIGMAX; % MAX BENDING STRESS CONSTRAINT
G3=DELTA-DELTMAX;
G4=x(1)-x(4);
G5=P-PC;
G6=0.125-x(1); 
G7=1.10471*x(1)^2+0.04811*x(3)*x(4)*(14+x(2))-5;
fit = fit + PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+...
    max(0,G6)^2+max(0,G7)^2); % PENALTY FUNCTION
end

%% Pressure Vessel design
function fit=Pressure_Vessel_design(x)
PCONST = 100000; % PENALTY FUNCTION CONSTANT
fit= 0.6224*x(1)*x(3)*x(4)+ 1.7781*x(2)*x(3)^2 + 3.1661 *(x(1)^2)*x(4) + 19.84 * (x(1)^2)*x(3);
G1= -x(1)+ 0.0193*x(3);
G2= -x(2) + 0.00954* x(3);
G3= -pi*(x(3)^2)*x(4)-(4/3)* pi*(x(3)^3) +1296000;
G4= x(4) - 240;
fit =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2); % PENALTY FUNCTION
end

%% I-BEAM DESIGN PROBLEM DEFINITION (all units are in british system)
function fit=I_beam_design_problem(x)
PCONST= 100000; % PENALTY FUNCTION CONSTANT
fit=5000/(((x(3)*(x(2)-2*x(4))^3)/12+(x(1)*(x(4)^3))/6+2*x(1)*x(4)*((x(2)-x(4))/2)^2));
G1 = 2*x(1)*x(3)+x(3)*(x(2)-2*x(4)); % MAX SHEAR STRESS CONSTRAINT
fit = fit + PCONST*(min(0,G1)^2); % PENALTY FUNCTION
end

%% TENSION/COMPRESSION SPRING DESIGN PROBLEM DEFINITION (all units are in british system) 
function fit=Spring_Design(x)
PCONST = 100000; % PENALTY FUNCTION CONSTANT
fit=(x(3)+2)*x(2)*(x(1)^2);
G1=1-((x(2)^3)*x(3))/(71785*x(1)^4);
G2=(4*x(2)^2-x(1)*x(2))/(12566*x(2)*x(1)^3-x(1)^4)+1/(5108*x(1)^2)-1;
G3=1-(140.45*x(1))/((x(2)^2)*x(3));
G4=(2*(x(1)+x(2))/3)-1;
fit = fit + PCONST*(max(0,G1)^2+max(0,G2)^2+max(0,G3)^2+max(0,G4)^2); % PENALTY FUNCTION
end

%% Speed Reducer design
function fit=Speed_Reducer_design(x)
PCONST = 10^(6); % PENALTY FUNCTION CONSTANT
fit=0.7854*x(1)*x(2)^2*(3.3333*x(3)^2+14.9334*x(3)-43.0934)-1.508*x(1)*(x(6)^2+x(7)^2)+7.4777*(x(6)^3+x(7)^3)+0.7854*(x(4)*x(6)^2+x(5)*x(7)^2);
G1=27/(x(1)*x(2)^2*x(3))-1;
G2=397.5/(x(1)*x(2)^2*x(3)^2)-1;
G3=1.93*x(4)^3/(x(2)*x(3)*x(6)^4)-1;
G4=1.93*x(5)^3/(x(2)*x(3)*x(7)^4)-1;
G5=((745.0*x(4)/(x(2)*x(3)))^2+16.9*(10)^6)^0.5/(110*x(6)^3)-1;
G6=((745.0*x(4)/(x(2)*x(3)))^2+157.5*(10)^6)^0.5/(85*x(7)^3)-1;
G7=x(2)*x(3)/40-1;
G8=5*x(2)/(x(1))-1;
G9=x(1)/(12*x(2))-1;
G10=(1.5*x(6)+1.9)/(x(4))-1;
G11=(1.1*x(7)+1.9)/(x(5))-1;
fit =fit+ PCONST*(max(0,G1)^2+max(0,G2)^2+max(0,G3)^2+max(0,G4)^2+...
    max(0,G5)^2+max(0,G6)^2+max(0,G7)^2+max(0,G8)^2+max(0,G9)^2+max(0,G10)^2+max(0,G11)^2); % PENALTY FUNCTION
end

%% Himmelblau's Problem
function fit=Himmelblaus_Problem(x)
PCONST = 100000; % PENALTY FUNCTION CONSTANT
fit= 5.3578547* x(3)^2 + 0.8356891 *x(1)*x(5)+ 37.293239*x(1)-40792.141;
G1= 85.334407 +0.0056858*x(2)*x(5)+0.0006262*x(1)*x(4)-0.0022053*x(3)*x(5)-92;
G2= -85.334407-0.0056858*x(2)*x(5)-0.0006262*x(1)*x(4)+0.0022053*x(3)*x(5);
G3= 80.51249+ 0.0071317*x(2)*x(5)+0.0029955*x(1)*x(2)+0.0021813*x(3)^2-110;
G4= -80.51249- 0.0071317*x(2)*x(5)-0.0029955*x(1)*x(2)-0.0021813*x(3)^2+90;
G5= 9.300961+0.0047026*x(3)*x(5)+0.0012547*x(1)*x(3)+0.0019085*x(3)*x(4)-25;
G6= -9.300961-0.0047026*x(3)*x(5)-0.0012547*x(1)*x(3)-0.0019085*x(3)*x(4)+20;
fit =fit + PCONST*(max(0,G1)+max(0,G2)+ max(0,G3));
end

%% Three Bar Truss Design
function fit=Three_Bar_Truss_Design(x)
PCONST= 100000; % PENALTY FUNCTION CONSTANT
P=2;
RU=2;
L=100;
fit=(((8)^0.5)*(x(1))+x(2))*L;
G1=(((2)^0.5)*x(1)+ x(2))/(((2)^0.5)*(x(1)^2)+ 2*x(1)*x(2))*P-RU;
G2= (x(2))/(((2)^0.5)*(x(1)^2)+2*x(1)*x(2))*P-RU;
G3= P/(x(1)+ ((2)^0.5)*x(2))-RU;
fit =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+ max(0,G3)^2);
end

%% Stepped Cantilever Beam Design
function fit=Stepped_Cantilever_Beam_Design(x)
PCONST= 100000; % PENALTY FUNCTION CONSTANT
L=100;
P=50000;
E=2*107;
fit=(x(1)*x(6)+x(2)*x(7)+x(3)*x(8)+x(4)*x(9)+x(5)*x(10))*L;
G1= ((600*P)/(x(5)*x(10)^2))-14000;
G2= ((6*P*2*L)/(x(4)*x(9)^2))-14000;
G3= ((6*P*3*L)/(x(3)*x(8)^2))-14000;
G4= ((6*P*4*L)/(x(2)*x(7)^2))-14000;
G5= ((6*P*5*L)/(x(1)*x(6)^2))-14000;
G6= (((P*L^3)/(3*E))*(125/L))-2.7;
G7=(x(10)/x(5))-20;
G8=(x(9)/x(4))-20;
G9=(x(8)/x(3))-20;
G10=(x(7)/x(2))-20;
G11=(x(6)/x(1))-20;
fit =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+...
    max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+max(0,G6)^2+max(0,G7)^2+max(0,G8)^2+max(0,G9)^2+max(0,G10)^2+max(0,G11)^2); % PENALTY FUNCTION
end

%% Multiple Disc Clutch Brake Design F10
function fit=Multiple_Disc_Clutch_Brake_Design(x)
PCONST= 100000; % PENALTY FUNCTION CONSTANT
DR=20;
% tm=3;
LM=30;
% Z=10;
MU=0.5;
PM=1;
r=0.0000078;
% r=1;
VSRM=10;
s=1.5;
TM=15;
n=250;
MS=40;
MF=3;
Iz=55;
delta=0.5;
% t=1.5;
% F=1000;
% RI=55;
% RO=110;
MH=(2/3)*MU*x(4)*x(5)*((x(2)^3-x(1)^3)/(x(2)^2-x(1)^2));
omega=pi*n/30;
A=pi*(x(2)^2-x(1)^2);
% PRZ=x(4)/A;
PRZ=(2/3)*x(4)/(pi*(x(2)^2-x(1)^2));
VSR= ((2/90)*pi*n*((x(2)^3-x(1)^3)))/(x(2)^5-x(1)^5);
RSR=(2/3)*((x(2)^3-x(1)^3)/(x(2)^2-x(1)^2));
% VSR=(pi*RSR*n)/30;
T= (Iz*omega)/(MH-MF);
fit=pi*(x(2)^2-x(1)^2)*x(3)*(x(5)+1)*r;
G1= x(2)-x(1)-DR;
G2= LM-(x(5)+1)*(x(3)+delta);
G3= PM-PRZ;
G4= PM*VSRM-PRZ*VSR;
G5=VSRM-VSR;
G6= TM-T;
G7= MH-s*MS;
G8= T;
% fit= fit+PCONST*(min(0,G1)^2+min(0,G2)^2+...
%     min(0,G3)^2+min(0,G4)^2+min(0,G5)^2+min(0,G6)^2+min(0,G7)^2+min(0,G8)^2);
fit= fit-PCONST*(min(0,G1)+min(0,G2)+...
    min(0,G3)+min(0,G4)+min(0,G5)+min(0,G6)+min(0,G7)+min(0,G8));
end

%% Hydrostatic Thrust Bearing Design 
function fit=Hydrodynamic_Thrust_Bearing_Design(x)  %F11
PCONST= 100000; % PENALTY FUNCTION CONSTANT
WS=101000;
PMAX=1000;
DTM=50;
HM=0.001;
Y=0.0307;
C=0.5;
C1=10.04;
n=-3.55;
Ne=750;
Ge=386.4;
P= (log10(log10(8.122*1e6*x(3)+0.8))-C1)/n;
DT= 2*(10^P-559.7);
EF= 9336*x(4)*Y*C*DT;
H= (((2*pi*Ne)/60)^2)*((2*pi*x(3))/EF)*(((x(1)^4)/4)-((x(2)^4)/4));
P0= ((6*x(3)*x(4))/(pi*(H^3)))* (log(x(1)/x(2)));
W=((pi*P0)/2)*((x(1)^2-x(2)^2)/log(x(1)/x(2)));
fit=((x(4)*P0)/0.7)+EF;
G1= W-WS;
G2=PMAX-P0;
G3= DTM-DT;
G4= H-HM;
G5=x(1)-x(2);
G6= 0.001-(Y/(Ge*P0))*(x(4)/(2*pi*x(1)*H));
G7= 5000-W/(pi*(x(1)^2-x(2)^2));
fit =fit - PCONST*(min(0,G1)+min(0,G2)+...
    min(0,G3)+min(0,G4)+min(0,G5)+min(0,G6)+min(0,G7));
end

%% Cantilever Beam Design
function fit=Cantilever_Beam_Design(x)
PCONST= 10^6; % PENALTY FUNCTION CONSTANT
fit=0.0624*(x(1)+x(2)+x(3)+x(4)+x(5));
G1= (61/(x(1)^3)+37/(x(2)^3)+19/(x(3)^3)+7/(x(4)^3)+1/(x(5)^3))-1;
fit =fit + PCONST*(max(0,G1)^2); % PENALTY FUNCTION
end

%% Rolling element bearing problem 
function fit=Rolling_element_bearing_problem(x)
% PCONST= 100000;
D = 160;
d = 90;
Bw = 30;
ri = 11.033;
r0 = 11.033;
T = D-d-(2*x(2));
A = ((D-d)/2-3*(T/4))^2+(D/2-(T/4)-x(2))^2-(d/2+(T/4))^2;
B = 2*((D-d)/2-3*(T/4))*(D/2-(T/4)-x(2));
fi0 = 2*pi-2*((cos(A/B))^(-1));
gama = x(2)/x(1);
x(4) = ri/x(2);
x(5) = r0/x(2);
fc = 37.91*((1+(1.04*((((1-gama)/(1+gama))^1.72)*(((x(4)*(2*x(5)-1))/(x(5)*(2*x(4)-1)))^0.41)))^(10/3))^(-0.3))*(((gama^0.3)*((1-gama)^1.39))/((1+gama)^(1/3)))*(((2*x(4))/(2*x(4)-1))^0.41);
if x(2) > 25.4
    fit = 3.647*fc*(x(3)^(2/3))*(x(2)^1.4);
else
    fit = fc*(x(3)^(2/3))*(x(2)^1.8);
end

G1= fi0/(2*(sin(x(2)/x(1)))^(-1))-x(3)+1;
G2= 2*x(2)-x(6)*(D-d);
G3= x(7)*(D-d)-2*x(2);
G4= x(10)*Bw-x(2);
G5= x(1)-(0.5-x(9))*(D+d);
G6= (0.5+x(9))*(D+d)-x(1);
G7= 0.5*(D-x(1)-x(2))-(x(8)*x(2));
G8= x(4)-0.515;
G9= x(5)-0.515;

fit =fit-(min(0,G1)+min(0,G2)+min(0,G3)+min(0,G4)+min(0,G5)+min(0,G6)+min(0,G7)+min(0,G8)+min(0,G9));
end

%% Car_crashworthiness DESIGN PROBLEM DEFINITION (all units are in british system) 
function fit=Car_crashworthiness(x)
PCONST = 100000; % PENALTY FUNCTION CONSTANT
fit=1.98+4.90*x(1)+6.67*x(2)+6.98*x(3)+4.0*x(4)+1.78*x(5)+2.73*x(7);
% G1=1.16-0.3717*x(2)*x(10)-0.484*x(3)*x(9)+0.01343*x(6)*x(10)-1;
% G2=0.261-0.0159*x(1)*x(2)-0.19*x(2)*x(7)+0.0144*x(3)*x(5)+0.008757*x(5)*x(10)+...
%     0.08045*x(6)*x(9)+0.00139*x(8)*x(11)-0.32;
% G3=0.214+0.00817*x(5)-0.131*x(1)*x(8)-0.0704*x(1)*x(9)+0.03099*x(2)*x(6)-0.018*x(2)*x(7)+...
%     0.0208*x(3)*x(8)+0.121*x(3)*x(9)-0.00364*x(5)*x(6)+0.0007715*x(5)*x(10)-...
%     0.0005354*x(6)*x(10)+0.00121*x(8)*x(11)-0.32;
% G4=0.74-0.61*x(2)-0.13*x(3)*x(8)+0.001232*x(3)*x(10)-0.166*x(7)*x(9)+0.0227*(x(2)^2)-0.32;
% G5=28.9-4.2*x(1)*x(2)+0.0207*x(5)*x(10)+6.63*x(6)*x(9)-7.7*x(7)*x(8)+...
%     0.32*x(9)*x(10)-32;
% G6=33.86+2.95*x(3)+0.1792*x(10)-5.057*x(1)*x(2)-11.0*x(2)*x(8)-0.0215*x(5)*x(10)-...
%     9.98*x(7)*x(8)+22.0*x(8)*x(9)-32;
% G7=46.36-9.9*x(2)-12.9*x(1)*x(8)+0.1107*x(3)*x(10)-32;
% G8=4.72-0.5*x(4)-0.19*x(2)*x(3)-0.0122*x(4)*x(10)+0.009325*x(6)*x(10)+0.000191*x(11)*x(11)-4.0;
% G9=10.58-0.674*x(1)*x(2)-1.95*x(2)*x(8)+0.02054*x(3)*x(10)-0.0198*x(4)*x(10)+0.28*x(6)*x(10)-9.9;
% G10=16.45-0.489*x(3)*x(4)-0.843*x(5)*x(6)+0.432*x(9)*x(10)-0.556*x(9)*x(11)+0.000786*(x(11)^2)-15.7;
% 
% fit = fit+PCONST*(max(0,G1)^2+max(0,G2)^2+max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+...
%     max(0,G6)^2+max(0,G7)^2+max(0,G8)^2+max(0,G9)^2+max(0,G10)^2); % PENALTY FUNCTION

G1=1.163-0.3717*x(2)*x(10)-0.484*x(3)*x(9)+0.01343*x(6)*x(10)-1;
G2=0.28-0.016*x(1)*x(2)-0.19*x(2)*x(7)+0.014*x(3)*x(5)+0.01*x(5)*x(10)+...
    0.08*x(6)*x(9)+0.001*x(8)*x(11)-0.32;
G3=10.6-0.67*x(1)*x(2)-2.0*x(2)*x(8)+0.02*x(3)*x(10)-0.02*x(4)*x(10)+0.28*x(6)*x(10)-9.9;
G4=0.74-0.61*x(2)-0.13*x(3)*x(8)+0.0012*x(3)*x(10)-0.17*x(7)*x(9)+0.023*(x(2)^2)-0.32;
G5=29-4.2*x(1)*x(2)+0.021*x(5)*x(10)+6.6*x(6)*x(9)-7.8*x(7)*x(8)+...
    0.32*x(9)*x(10)-32;
G6=16.4-0.49*x(3)*x(4)-0.84*x(5)*x(6)+0.43*x(9)*x(10)-0.56*x(9)*x(11)+0.0008*(x(11)^2)-15.7;
G7=46.4-9.9*x(2)-12.89*x(1)*x(8)+0.11*x(3)*x(10)-32;
G8=4.7-0.5*x(4)-0.19*x(2)*x(3)-0.012*x(4)*x(10)+0.009*x(6)*x(10)+0.0002*x(11)*x(11)-4.0;

fit = fit+PCONST*(max(0,G1)^2+max(0,G2)^2+max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+...
    max(0,G6)^2+max(0,G7)^2+max(0,G8)^2);
end

%% Tubular_Column_Design
function fit=Tubular_Column_Design(x)
PCONST= 10^6; % PENALTY FUNCTION CONSTANT
P=2500;
sigma=500;
E=0.85e6;
rho=0.0025;
L=250;
fit=9.82*x(1)*x(2)+2*x(1);
G1= (P/(pi*x(1)*x(2)*sigma))-1;
G2= (8*P*(L^2))/((pi^3)*E*x(1)*x(2)*(x(1)^2+x(2)^2))-1;
G3= (2.0/x(1))-1;
G4= (x(1)/14.0)-1;
G5= (0.2/x(2))-1;
G6= (x(2)/0.8)-1;
fit =fit + PCONST*(max(0,G1)^2+max(0,G2)^2+max(0,G3)^2+max(0,G4)^2+max(0,G5)^2+max(0,G6)^2); % PENALTY FUNCTION
end

%% Corrugated_Bulkhead_Design
function fit=Corrugated_Bulkhead_Design(x)
PCONST= 10^6; % PENALTY FUNCTION CONSTANT
fit=(5.885*x(4)*(x(1)+x(3)))/(x(1)+sqrt(x(3)^2-x(2)^2));
G1= x(2)*x(4)*(0.4*x(1)+x(3)/6)-8.94*(x(1)+sqrt(x(3)^2-x(2)^2));
G2= (x(2)^2)*x(4)*(0.2*x(1)+x(3)/12)-2.2*((8.94*(x(1)+sqrt(x(3)^2-x(2)^2)))^(4/3));
G3= x(4)-0.0156*x(1)-0.15;
G4= x(4)-0.0156*x(3)-0.15;
G5= x(4)-1.05;
G6= x(3)-x(2);
fit =fit - PCONST*(min(0,G1)+min(0,G2)+min(0,G3)+min(0,G4)+min(0,G5)+min(0,G6)); % PENALTY FUNCTION
end

%% Frequency_Modulated_Sound_Waves
function fit=Frequency_Modulated_Sound_Waves(x)
PCONST= 100000; % PENALTY FUNCTION CONSTANT
theta=2*pi/100;
fit=0;
for t=0:100
    y=x(1)*sin(x(2)*t*theta+x(3)*sin(x(4)*t*theta+x(5)*sin(x(6)*t*theta)));
    y0=1.0*sin((5.0)*t*theta-(1.5)*sin(4.8*t*theta+2.0*sin(4.9*t*theta)));
    fit=fit+(y-y0)^2;
end
% fit = fit + PCONST*(min(0,G1)^2); % PENALTY FUNCTION
end
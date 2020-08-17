clear all;

tspan=0:0.1:10;
 
M1=1; M2=1; L1=1; L2=1; g=9.8;

Kp1=-1.640008163265306e+03; Kp2=-4.481632653061224e+02;
Kd1=-5.004040816326531e+02; Kd2=-2.040816326530612e+02;

PID=[Kp1 Kd1 Kp2 Kd2];

q1=deg2rad(5); %Joint-angle 1
dq1=deg2rad(0);
q2=deg2rad(-5); %Joint-angle 2
dq2=deg2rad(0);
 
y0=[q1 q2 dq1 dq2]; %Init states
 
opts=odeset('RelTol',10e-9,'AbsTol',10e-10);
[t,y]=ode45(@(t,y) New_PID(t,y,PID),tspan,y0,opts);
 
q1=y(:,1);
q2=y(:,2);
dq1=y(:,3);
dq2=y(:,4);

%Plot%
figure(1)
plot(t,rad2deg(q1))
hold on
legend('q1');
title('PID Control');
xlabel('time(steps)');
ylabel('Angle(deg)');
%{
K=(0.5*(M1+M2).*(L1^2).*(dq1.^2))+(0.5*M2*(L2^2).*(dq2.^2))+(M2*(L1*L2*cos(q1-q2)).*dq1.*dq2);
P=(M1*g*L1.*cos(q1))+(M2*g*((L1.*cos(q1))+(L2.*cos(q2))));
 
E=K+P; %Total Energy
E_error=zeros(length(t),1);
  
for i=1:length(t)
    E_error(i)=abs(E(i)-Ei);
end
 
 
figure(1)
plot(t,E)
hold on
plot(t,E_error)
hold on
legend('E','E_error')
title('Energy of Eq^n of Motion');
xlabel('Time Steps');
ylabel('Energy (J)')
%}

Robot_Movie(q1,q2)

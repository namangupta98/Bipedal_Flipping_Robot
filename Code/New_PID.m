function dY=New_PID(t,y,PID)
 
M1=1; M2=1; L1=1; L2=1; g=9.8;

Kp1=PID(1); Kp2=PID(3);
Kd1=PID(2); Kd2=PID(4);
 
q1=y(1);
q2=y(2);
dq1=y(3);
dq2=y(4);
q1_des=deg2rad(0);
q2_des=deg2rad(0);


u1=-((Kp1*(q1_des-q1))+(Kd1*(-dq1)));
u2=-((Kp2*(q2_des-q2))+(Kd2*(-dq2)));
U=[0; u1];

dq=[dq1; dq2];
 
m11=((M1+M2)*(L1^2))+(M2*((L2^2)+(2*L1*L2*cos(q2))));
m12=-M2*((L1^2)+(L1*L2*cos(q2)));
m21=m12;
m22=M2*(L1^2);

M=[m11 m12; m21 m22];
 
c11=M2*L1*L2*sin(q2)*(-2*dq1+dq2)*dq2;
c21=M2*L1*L2*sin(q2)*(dq1^2);

C=[c11; c21];
 
g11=-(((M1*L1)+(M2*L2))*g*sin(q1))-(M2*g*L1*cos(deg2rad(90)-q1+q2));
g21=M2*g*L1*cos(deg2rad(90)-q1+q2);
G=[g11; g21];

T=M*U;
t1=0; t2=T(2);
 
ddq1=(((t1-(c11+g11))*m22)-((t2-(c21+g21))*m12))/((m11*m22)-(m12*m21));
ddq2=(-((t1-(c11+g11))*m21)+((t2-(c21+g21))*m11))/(-(m12*m21)+(m11*m22));

%ddq=M\(-C-G+T);
%ddq=(inv(M))*(-C-G+T);

ddq=[ddq1; ddq2];
 
dY=[dq; ddq];
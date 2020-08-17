function Anmt=Robot_Movie(q1,q2)

tsol=0:0.1:100;  %controlling frame speed
L1=1; L2=1;

j1=q1;
j2=q2;

x1=L1.*sin(j1); 
y1=L1.*cos(j1);
x2=(L2.*cos(deg2rad(90)-j1+j2))+(L1.*sin(j1));  
y2=(L2.*sin(deg2rad(90)-j1+j2))+(L1.*cos(j1));

i=1; j=1:i:length(tsol);   %% generating images in 2D 

figure(10) 
 for i=1:length(j)-1    
    hold off     
    plot([x1(j(i)) x2(j(i))],[y1(j(i)) y2(j(i))],'o',[0 x1(j(i))],[0 y1(j(i))],'k',[x1(j(i)) x2(j(i))],[y1(j(i)) y2(j(i))],'k')
    xlabel('x')    
    ylabel('y')     
    axis([-2 2 -2 2]);    
    grid     
    hold on   
    MM(i)=getframe(gcf); 
 end
drawnow; %% exporting to 
Anmt=mpgwrite(MM,'RGB','trajectory.mpg');
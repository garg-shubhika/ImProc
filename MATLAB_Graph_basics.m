%% SECTION1
% plot a line graph
x=1 : 0.5 : 10;
subplot(2,1,1);
plot(x,'*-','MarkerEdgeColor','red');
title('Line Graphs');
y=x+2;
subplot(2,1,2);
plot(x,y,'o-','MarkerEdgeColor','red');
xlabel('X-Axis');
ylabel('Y-Axis');
%% SECTION2
%sine function between -pi and pi
x = -pi : 0.1 :pi;
y = sin(x);
plot(x, y,'*-','MarkerEdgeColor','red');
%% SECTION3
%cosine and sine function on same figure
%subplot(rows,colums,index)
x = -pi : 0.1 : pi;
y = sin(x);
z = cos(x);
subplot(3, 1, 1)
plot(x, y);
subplot(3, 1, 2)
plot(x, z);
%% SECTION4
%plotting two graphs on same figure and the use of hold command
x = -pi : 0.1 : pi;
y = sin(x);
z = cos(x);
plot(x, y);
hold
plot(x, z);
legend('Deaths','Recoveries');
title('Covid positive patients');
%% SECTION5
x= -pi : 0.1 : pi;
y=sin(x);
plot(x,y);
hold
z=cos(x);
plot(x,z);
legend('f(x)=sin(x)','f(x)=cos(x)','Location','southeast');
title('Funtions sin and cos')
grid;
%% SECTION6
z=[1 2; 3 4];
surf(z); 
%3-D Graph
%% SECTION7
t = 0:pi/20:10*pi;
xt2 = sin(2*t);
yt2 = cos(2*t);
plot3(xt2,yt2,t);
title('Helix Example 3-D Graph');
%% SECTION8
%use of quiver 
load('wind','x','y');
X = x(10:13,10:13,1);
Y = y(10:13,10:13,1);
quiver(X,Y,'cyan');
%% SECTION9
%Plotting a histogram
x=randn(100,2);
h=histogram(x,'DisplayStyle','bar',EdgeColor='black',FaceColor='red',BinWidth=1);
title('HISTOGRAM');
%% SECTION10
%Plotting pie charts
X = [1 3 0.5 2.5 2 0.5 0.25 0.25];
pie(X);
X=1 : 5;
labels={'Cricket','Football','Tennis','Swimming','Basketball'};
pie(X,labels);
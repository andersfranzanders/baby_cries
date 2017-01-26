
support = 1:150;
x1 = sin(support/10);
x2 = 1.3* sin(support/5);

set(gcf,'color','w');
hold on;
plot(x1,'b')
hold on;
plot(x2,'m')
hold on;
plot(x1.*x2,'k')



h = hamming(50);
h = h';
x = [zeros(1,25), h, zeros(1,75)];

set(gcf,'color','w');


y1 = [zeros(1,100), h];
y2 = [zeros(1,50), h, zeros(1,50)];
cor_y = sum(x.*y2)/sqrt(sum(x.^2)*sum(y2.^2))
y3 = [zeros(1,25), h, zeros(1,75)];
y4 = [zeros(1,25), -h, zeros(1,75)];
%cor_y = sum(x.*y)/sqrt(sum(x.^2)*sum(y.^2))

subplot(1,4,1)
plot(x)
hold on;
plot(y1)

subplot(1,4,2)
plot(x)
hold on;
plot(y2)

subplot(1,4,3)
plot(x)
hold on;
plot(y3)

subplot(1,4,4)
plot(x)
hold on;
plot(y4)
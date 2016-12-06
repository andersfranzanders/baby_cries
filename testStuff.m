x = sin(1:0.1:20);

%Plot Input Signal
figure('Name', 'Teststuffi','position', [200, 200, 700, 300])
subplot(2,1,1);
plot(x);

x = centerClipping(x);
subplot(2,1,2);
plot(x);
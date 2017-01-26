support = 1:500;
x = sin(support/10) + 1.3* sin(support/5) + 0.8* sin(support/4) + 0.2* sin(support);

set(gcf,'color','w');

noise = ones(1,length(support)) 
for i = 1:length(noise)
	noise(i) = noise(i)*rand*2-1;
end

x_n = x+noise;

msv_xn = mean(x_n.^2)
mse = mean(noise.^2)
rmse = sqrt(mean(noise.^2))

msv_x =  mean(x.^2)
snr = 10*log(msv_x/mse)
%plot(x_n,'k')
%plot(x,'k')

noise(1) = 4;
noise(end) = -4;
plot(noise,'k')
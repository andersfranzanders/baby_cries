
support = 1:230;
x = sin(support/10) + 1.3* sin(support/5) + 0.8* sin(support/4);

set(gcf,'color','w');
plot(x,'k')

interval = 50:200;
avg = mean(x(interval))
avgSig = ones(length(interval))*avg;
hold on;
plot(support(interval), avgSig);

msv = mean(x(interval).^2)
msvSig = ones(length(interval))*msv;
hold on;
plot(support(interval), msvSig);

rms = sqrt(mean(x(interval).^2))
rmsSig = sqrt(msvSig);
hold on;
plot(support(interval), rmsSig);

e = sum(x(interval).^2)


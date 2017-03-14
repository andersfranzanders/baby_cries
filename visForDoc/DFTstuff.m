

support = 1:200;

cos1 = cos(2*pi*1*support/length(support));
cos8 = 2*cos(2*pi*8*support/length(support));
sin2 = 0.5*sin(2*pi*2*support/length(support));
sin15 = sin(2*pi*15*support/length(support));

figure();
set(gcf,'color','w');

subplot(1,4,1)
plot(cos1);
axis([0 200 -2 2])
subplot(1,4,2)
plot(cos8);
axis([0 200 -2 2])
subplot(1,4,3)
plot(sin2);
axis([0 200 -2 2])
subplot(1,4,4)
plot(sin15);
axis([0 200 -2 2])



x = cos1+cos8+sin2+sin15 ;
%plot(x)
spec = fft(x)
%stem(real(spec)/(0.5*length(support)))
%plot(x,'k')

fftSupport = 0:length(support)/2;
specRe = zeros(1,length(support)/2+1);
specRe(2) = 1;
specRe(9) = 2;

specIm = zeros(1,length(support)/2+1);
specIm(3) = 0.5;
specIm(16) = 1;

figure();
subplot(1,4,1)
bar(fftSupport,specRe)
axis([0 100 0 2])
subplot(1,4,2)
bar(fftSupport,specIm)
axis([0 100 0 2])

mag = sqrt(specRe.^2 + specIm.^2);
phi = atan(specIm./specRe);

subplot(1,4,3)
bar(fftSupport,mag)
axis([0 100 0 2])

subplot(1,4,4)
bar(fftSupport,phi)
axis([0 100 0 2])



Fs = 44100;
length = 0.5;
h = hamming(length*Fs);

set(gcf,'color','w');
plot(h, 'Color','k');
axis([0 Fs*length 0 1.1])
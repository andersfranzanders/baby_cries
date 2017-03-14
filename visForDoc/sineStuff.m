
support = 1:44100;
f = 5;
fs = 44100;
c = 2 * cos(2*pi*f*support./fs);

set(gcf,'color','w');
plot(c,'k')
axis([0 44100 -2.5 2.5])
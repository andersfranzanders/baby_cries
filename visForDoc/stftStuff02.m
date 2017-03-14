pathToAudio = '../audiobase/truncated/misc/justSquare';
[x,Fs,classSignal] = readInAudioAndClassification(pathToAudio);
Fs
support = 1:length(x); 

set(gcf,'color','w');
subplot(2,1,1);
plot(support/Fs,x, 'Color','k');

X = fft(x);
spectrum = abs(X(1:length(X)/2+1));
specSupport = 0:length(spectrum)-1;
specSupport = specSupport*Fs/length(X);
subplot(2,1,2);
loglog(specSupport,spectrum+1, 'Color','k');
axis([0 Fs/2 0 10000])

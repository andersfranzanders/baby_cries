pathToAudio = '../audiobase/truncated/misc/justSquare';
[x,Fs,classSignal] = readInAudioAndClassification(pathToAudio);

support = 1:length(x); 

set(gcf,'color','w');
%subplot(2,1,1);
%plot(support/Fs,x, 'Color','k');


xInWindows = cutSignalIntoWindows(x, 500,Fs);
[rows,cols] = size(xInWindows)
support = 1:cols;
support = support/Fs;
numRows = rows-3;
for i = 1:numRows
    xWin = xInWindows(i,:);
    subplot(3,numRows,i);
    plot(support,xWin,'Color','k');
    axis([0 0.5 -1 1])
    
    xHam = xWin.*hamming(cols)';
    subplot(3,numRows,numRows+i);
    plot(support,xHam,'Color','k');
    axis([0 0.5 -1 1])
    hold on;
    
    subplot(3,numRows,numRows+i);
    plot(support,hamming(cols),'Color','r');
    axis([0 0.5 -1 1])
    hold on;
    
    X = fft(xHam);
    spectrum = abs(X(1:length(X)/2 + 1));
    specSupport = 0:length(spectrum)-1;
    specSupport = specSupport*Fs/length(X);
    
    subplot(3,numRows,2*numRows+i);
    loglog(specSupport,spectrum+1,'Color','k');
end


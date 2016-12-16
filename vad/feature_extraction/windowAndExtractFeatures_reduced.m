function [ support, M,xInWindows,specto,ceptogram] = windowAndExtractFeatures( x,classSignal,windowSizeInMs,Fs )

%cut Signal into overlapping Windows and calculate spectogram by STFT
xInWindows = cutSignalIntoWindows(x,windowSizeInMs,Fs);
xInWindows = xInWindows(1:end-1,:);
specto = calSpectogram(xInWindows, 2^11);
ceptogram = calCeptogram(specto);

%calculate support vector for output signal of voice-detection-signals
[rows,cols] = size(xInWindows);
lengthOfOriginalSignal = rows*cols/2;
support = 1:(cols/2):lengthOfOriginalSignal;

% calculate Features
M = zeros(rows, 10);

[RMSfeats] = calTimeDomainFeatures(xInWindows);
%[unnormSpecEntsFeats, normSpecEntsFeats, domFreqFeats ] = calFrequencyDomainFeatures( specto, Fs,200, 8000);
[cepstrmDomPeakFeat]  = calCepstralFeatures(ceptogram,Fs,200,2000);
%[corMagPeakFeat, corPeakCountFeat] =  calCorrelationFeatures( xInWindows, 200,800, Fs );

M(:,1) = RMSfeats;
M(:,6) = cepstrmDomPeakFeat;

%calculate Classes for every Window
Cs = calculateClasses(xInWindows, classSignal);
M(:,end) = Cs(:);

M = addMinsMaxsToMByMirroring(M,4,windowSizeInMs);
%M = addMinAndMaxToM(M,4,windowSizeInMs);


end


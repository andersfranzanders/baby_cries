function [ support,M] = windowAndExtractFeatures_2000( x,classSignal,windowSizeInMs,Fs )

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

[RMSfeats, ZCRfeats] = calTimeDomainFeatures(xInWindows);
[unnormSpecEntsFeats, normSpecEntsFeats, domFreqFeats ] = calFrequencyDomainFeatures( specto, Fs,200, 8000);
[cepstrmDomPeakFeat, cepstrumLocPeakFeat]  = calCepstralFeatures(ceptogram,Fs,200,2000);
[corMagPeakFeat, corPeakCountFeat] =  calCorrelationFeatures( xInWindows, 200,2000, Fs );

M(:,1) = RMSfeats;
M(:,2) = ZCRfeats;
M(:,3) = unnormSpecEntsFeats;
M(:,4) = normSpecEntsFeats;
M(:,5) = domFreqFeats;
M(:,6) = cepstrmDomPeakFeat;
M(:,7) = cepstrumLocPeakFeat;
M(:,8) = corMagPeakFeat;
M(:,9) = corPeakCountFeat;
%featureMatrix(:,11:end-1) = calMFCCgram( specto, 30, 13, 50, 10000, Fs );

%calculate Classes for every Window
Cs = calculateClasses(xInWindows, classSignal);
M(:,end) = Cs(:);

M = addMinsMaxsToMByMirroring(M,4,windowSizeInMs);
%M = addMinAndMaxToM(M,4,windowSizeInMs);


end


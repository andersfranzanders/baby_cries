function [ support, featureMatrix] = windowAndExtractFeatures( x,classSignal,windowSizeInMs,Fs )

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
featureMatrix = zeros(rows, 10);

[RMSfeats, ZCRfeats] = calTimeDomainFeatures(xInWindows);
[unnormSpecEntsFeats, normSpecEntsFeats, domFreqFeats ] = calFrequencyDomainFeatures( specto, Fs,200, 8000);
[cepstrmDomPeakFeat, cepstrumLocPeakFeat]  = calCepstralFeatures(ceptogram,Fs,200,800);
[corMagPeakFeat, corPeakCountFeat] =  calCorrelationFeatures( xInWindows, 200,800, Fs );

featureMatrix(:,1) = RMSfeats;
featureMatrix(:,2) = ZCRfeats;
featureMatrix(:,3) = unnormSpecEntsFeats;
featureMatrix(:,4) = normSpecEntsFeats;
featureMatrix(:,5) = domFreqFeats;
featureMatrix(:,6) = cepstrmDomPeakFeat;
featureMatrix(:,7) = cepstrumLocPeakFeat;
featureMatrix(:,8) = corMagPeakFeat;
featureMatrix(:,9) = corPeakCountFeat;
%featureMatrix(:,11:end-1) = calMFCCgram( specto, 30, 13, 50, 10000, Fs );

%calculate Classes for every Window
Cs = calculateClasses(xInWindows, classSignal);
featureMatrix(:,end) = Cs(:);


end


function [ x_seg,c ] = produceAcceleratingSegment(crySet,Fs,maxCryEvents, startBurstLength, burstAcceleration, avgVtoPFraction, VtoPVariance,  gainVariance)

if avgVtoPFraction + VtoPVariance > 1
     error ('the sum of the Voice-To-Pause-Ratio and the Voice-To-Pause-Variance must be <= 1!! ');   
end


x_seg = [];
c = [];

% first, stretch crysignal of maximum possible length
[numSignals, notImportant ] = size(crySet);
maxPossibleLength = 0;
if burstAcceleration >= 1
    maxPossibleLength = startBurstLength*Fs;
else
    %maxPossibleLength = (startBurstLength + (startBurstLength - (startBurstLength * burstAcceleration )) * (maxCryEvents-1)) * Fs;
    
    maxPossibleLength = startBurstLength * (1/burstAcceleration)^(maxCryEvents-1)*Fs;
end
stretchedCrySet = [];

for i = 1:numSignals;
    x_stretched = crySet{i};
    
    while length(x_stretched ) < maxPossibleLength
        x_stretched = [x_stretched, crySet{i}];
    end
    stretchedCrySet = [stretchedCrySet;{x_stretched}];
end


%construct signal by concatinating random cry segments

burstLengthToAdd = startBurstLength - startBurstLength * burstAcceleration;
burstLengthToSubstract = startBurstLength * burstAcceleration - startBurstLength;
minVtoPFraction = avgVtoPFraction - VtoPVariance;
maxVtoPFraction = avgVtoPFraction + VtoPVariance;
minGain = 1 - gainVariance;
maxGain = 1;

numCries = 0;
currentBurstLength = startBurstLength;
nextBurstLength = 0;
while numCries < maxCryEvents
    %Calculate this burst length
%     if burstAcceleration > 1
%        %nextBurstLength = startBurstLength - numCries * burstLengthToSubstract;
%        if nextBurstLength <= 0
%             error('Acceleration set to high, burst length reached 0!');
%        end
%     else
%        nextBurstLength = startBurstLength + numCries * burstLengthToAdd;
%     end
    
     nextBurstLength = startBurstLength * (1/burstAcceleration)^numCries;
     %calculate random Gain;
    thisGain = minGain +(maxGain-minGain)*rand();
    
    %Calculate this random Voiced-Fraction
    randomVoicedFraction = minVtoPFraction + (maxVtoPFraction-minVtoPFraction)*rand();
    
    %Calculate voice-Length and pause-Length and convert seconds so samples.
    voicedLength = floor(nextBurstLength*randomVoicedFraction * Fs);
    pauseLength = floor((nextBurstLength*Fs - voicedLength));
    
    %select random cry from cryset
    randCrySegment = floor(1+(numSignals)*rand());
    x = stretchedCrySet{randCrySegment};
    
    %Cal and add voice and pause   
    x_i = x(1:voicedLength)*thisGain;
    p_i = zeros(1,pauseLength);
    x_seg = [x_seg, x_i,p_i];
    
    %Cal Class-Signal;
    c = [c,ones(1,voicedLength)];
    c = [c,p_i];
    
    numCries = numCries+1;
end

end



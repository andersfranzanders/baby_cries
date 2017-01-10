function [ x_seg,c ] = produceConstantSegment(crySet,Fs,segmentLength, avgBurstLength, burstVariance, avgVtoPFraction, VtoPVariance, gainVariance)

if burstVariance < 0 || burstVariance > 1 ...
        || VtoPVariance < 0 || VtoPVariance > 1 ...
            || gainVariance < 0 || gainVariance > 1
   error ('burstVariance, Voice-To-Pause-Variance and Gain-Variance must be between 0 and 1!! ');   
end
if avgVtoPFraction + VtoPVariance > 1
     error ('the sum of the Voice-To-Pause-Ratio and the Voice-To-Pause-Variance must be <= 1!! ');   
end


x_seg = [];
c = [];

% first, stretch crysignal of maximum possible length
[numSignals, notImportant ] = size(crySet);
maxPossibleLength = (avgBurstLength + avgBurstLength*burstVariance)*Fs;
stretchedCrySet = [];

for i = 1:numSignals;
    x_stretched = crySet{i};
    
    while length(x_stretched ) < maxPossibleLength
        x_stretched = [x_stretched, crySet{i}];
    end
    stretchedCrySet = [stretchedCrySet;{x_stretched}];
end

%construct signal by concatinating random cry segments

minBurst = avgBurstLength - avgBurstLength*burstVariance;
maxBurst = avgBurstLength + avgBurstLength*burstVariance;
minVtoPFraction = avgVtoPFraction - VtoPVariance;
maxVtoPFraction = avgVtoPFraction + VtoPVariance;
minGain = 1 - gainVariance;
maxGain = 1;

while length(x_seg)/Fs < segmentLength
    %Calculate this burst length
    randomBurstLength = minBurst +(maxBurst-minBurst)*rand();
    
     %calculate random Gain;
    thisGain = minGain +(maxGain-minGain)*rand();
    
    %Calculate this random Voiced-Fraction
    randomVoicedFraction = minVtoPFraction + (maxVtoPFraction-minVtoPFraction)*rand();
    
    %Calculate voice-Length and pause-Length and convert seconds so samples.
    voicedLength = floor(randomBurstLength*randomVoicedFraction * Fs);
    pauseLength = floor((randomBurstLength*Fs - voicedLength));
    
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
end

end


function [ thresholdedM ] = thresholdFeatures_50u3db_CeDFD( M )

[rows,cols] = size(M);
thresholdedM = zeros(1,rows);

for i =1:rows
     cepstralMostDominantPeak_min = M(i,15);
     cepstralMostDominantPeak = M(i,6);
     normalizedSpectralEntropy = M(i,4);
     
    if cepstralMostDominantPeak_min < 0.02
        if  cepstralMostDominantPeak_min < 0.01 
            thresholdedM(i) = 0;
        else
            if  normalizedSpectralEntropy < 4.82 
                thresholdedM(i) = 1;
            else
                thresholdedM(i) = 0;
            end
        end
    else
        if   cepstralMostDominantPeak < 0.05
            if  normalizedSpectralEntropy < 5.35 
                thresholdedM(i) = 1;
            else
                thresholdedM(i) = 0;
            end
        else
            thresholdedM(i) = 1;
        end
    end

end

% cepstralMostDominantPeak_min < 0.02
% |   cepstralMostDominantPeak_min < 0.01 : 0 (11752/645) [5862/340]
% |   cepstralMostDominantPeak_min >= 0.01
% |   |   normalizedSpectralEntropy < 4.82 : 1 (921/430) [401/188]
% |   |   normalizedSpectralEntropy >= 4.82 : 0 (2559/731) [1365/394]
% cepstralMostDominantPeak_min >= 0.02
% |   cepstralMostDominantPeak < 0.05
% |   |   normalizedSpectralEntropy < 5.35 : 1 (2007/263) [990/142]
% |   |   normalizedSpectralEntropy >= 5.35 : 0 (199/66) [93/37]
% |   cepstralMostDominantPeak >= 0.05 : 1 (9732/17) [4874/10]


end


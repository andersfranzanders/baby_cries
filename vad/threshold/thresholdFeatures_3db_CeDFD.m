function [ thresholdedM ] = thresholdFeatures_3db_CeDFD( M )

[rows,cols] = size(M);
thresholdedM = zeros(1,rows);

for i =1:rows
     cepstralMostDominantPeak_min = M(i,15);
     normalizedSpectralEntropy = M(i,4);
     
    if cepstralMostDominantPeak_min < 0.02
        thresholdedM(i) = 0;
    else
        if cepstralMostDominantPeak_min < 0.03
            if   normalizedSpectralEntropy < 5.32 
                thresholdedM(i) = 1;
            else
                thresholdedM(i) = 0;
            end
        else
            thresholdedM(i) = 1;
        end
    end
end

% cepstralMostDominantPeak_min < 0.02 : 0 (8044/1356) [4011/670]
% cepstralMostDominantPeak_min >= 0.02
% |   cepstralMostDominantPeak_min < 0.03
% |   |   normalizedSpectralEntropy < 5.32 : 1 (704/86) [353/46]
% |   |   normalizedSpectralEntropy >= 5.32 : 0 (138/42) [71/26]
% |   cepstralMostDominantPeak_min >= 0.03 : 1 (4700/20) [2358/13]



end


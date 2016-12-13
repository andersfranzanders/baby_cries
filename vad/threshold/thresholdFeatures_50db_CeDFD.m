function [ thresholdedM ] = thresholdFeatures_3db_CeDFD( M )

[rows,cols] = size(M);
thresholdedM = zeros(1,rows);

for i =1:rows
     cepstralMostDominantPeak_min = M(i,15);
     normalizedSpectralEntropy = M(i,4);
     unnormalizedSpectralEntropy_min = M(i,12);
     
    if unnormalizedSpectralEntropy_min < 112.16
        if  cepstralMostDominantPeak_min < 0.01 
            thresholdedM(i) = 0;
        else
            if  normalizedSpectralEntropy < 4.83
                thresholdedM(i) = 1;
            else
                thresholdedM(i) = 0;
            end
        end
    else
        thresholdedM(i) = 1;
    end
     
   
end

% unnormalizedSpectralEntropy_min < 112.16
% |   cepstralMostDominantPeak_min < 0.01 : 0 (6530/264) [3233/109]
% |   cepstralMostDominantPeak_min >= 0.01
% |   |   normalizedSpectralEntropy < 4.83 : 1 (302/48) [143/24]
% |   |   normalizedSpectralEntropy >= 4.83 : 0 (664/182) [341/85]
% unnormalizedSpectralEntropy_min >= 112.16 : 1 (6090/94) [3076/41]



end


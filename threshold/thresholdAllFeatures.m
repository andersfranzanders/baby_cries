function [ thresholdedM ] = thresholdAllFeatures( M )

[rows,cols] = size(M);
thresholdedM = zeros(1,rows);

for i =1:rows
    unnormalizedSpectralEntropy = M(i,3);
    normalizedSpectralEntropy = M(i,4);
    mostDominantFrequency = M(i,5);
    
    if unnormalizedSpectralEntropy < 596.59
        if normalizedSpectralEntropy < -5.93 
            thresholdedM(i) = 0;
        else
            if mostDominantFrequency < 484.5 
                thresholdedM(i) = 0;
            else
                if unnormalizedSpectralEntropy < -33.63 
                    thresholdedM(i) = 0;
                else
                   thresholdedM(i) = 0.8;
                end
            end
        end
    else 
        if mostDominantFrequency < 549.1
            if unnormalizedSpectralEntropy < 988.35
                if normalizedSpectralEntropy < -4.79 
                    thresholdedM(i) = 0.8;
                else
                    thresholdedM(i) = 0;
                end
            else
                thresholdedM(i) = 0.8;
            end
        else
            thresholdedM(i) = 0.8;
        end
    end
end




% unnormalizedSpectralEntropy < 596.59
% |   normalizedSpectralEntropy < -5.93 : 0 (3397/125) [1679/57]
% |   normalizedSpectralEntropy >= -5.93
% |   |   mostDominantFrequency < 484.5 : 0 (4954/1002) [2450/480]
% |   |   mostDominantFrequency >= 484.5
% |   |   |   unnormalizedSpectralEntropy < -33.63 : 0 (868/197) [459/94]
% |   |   |   unnormalizedSpectralEntropy >= -33.63 : 1 (2057/453) [1006/205]
% unnormalizedSpectralEntropy >= 596.59
% |   mostDominantFrequency < 549.1
% |   |   unnormalizedSpectralEntropy < 988.35
% |   |   |   normalizedSpectralEntropy < -4.79 : 1 (887/237) [427/125]
% |   |   |   normalizedSpectralEntropy >= -4.79 : 0 (398/116) [198/58]
% |   |   unnormalizedSpectralEntropy >= 988.35 : 1 (2937/213) [1465/117]
% |   mostDominantFrequency >= 549.1 : 1 (7079/105) [3605/49]











% for i =1:rows
%    unnormalizedSpectralEntropy = M(i,3);
%    corMagPeak = M(i,9);
%    normalizedSpectralEntropy = M(i,4);
%    cepstralMostDominantPeak = M(i,6);
%     
% if unnormalizedSpectralEntropy < 596.59
%     if   corMagPeak < 1
%         thresholdedM(i) = 0;
%     else
%           if  unnormalizedSpectralEntropy < -37.65
%                 if normalizedSpectralEntropy < -5.02
%                     thresholdedM(i) = 0;
%                 else
%                     thresholdedM(i) = 0.8;
%                 end
%           else
%               thresholdedM(i) = 0.8;
%           end
%     end
% else
%     if cepstralMostDominantPeak < 0.02
%           if corMagPeak < 0.88
%                 if cepstralMostDominantPeak < 0.01 
%                     thresholdedM(i) = 0;
%                 else
%                     thresholdedM(i) = 0.8;
%                 end
%           else
%               thresholdedM(i) = 0.8;
%           end
%     else 
%         thresholdedM(i) = 0.8;
%     end
% end
%    
%    
% end

% unnormalizedSpectralEntropy < 596.59
% |   corMagPeak < 1 : 0 (9642/1577) [4775/752]
% |   corMagPeak >= 1
% |   |   unnormalizedSpectralEntropy < -37.65
% |   |   |   normalizedSpectralEntropy < -5.02 : 0 (188/32) [96/18]
% |   |   |   normalizedSpectralEntropy >= -5.02 : 1 (22/0) [13/2]
% |   |   unnormalizedSpectralEntropy >= -37.65 : 1 (1424/127) [710/59]
% unnormalizedSpectralEntropy >= 596.59
% |   cepstralMostDominantPeak < 0.02
% |   |   corMagPeak < 0.88
% |   |   |   cepstralMostDominantPeak < 0.01 : 0 (422/98) [198/40]
% |   |   |   cepstralMostDominantPeak >= 0.01 : 1 (633/256) [268/118]
% |   |   corMagPeak >= 0.88 : 1 (726/66) [370/36]
% |   cepstralMostDominantPeak >= 0.02 : 1 (9520/191) [4859/119]

end


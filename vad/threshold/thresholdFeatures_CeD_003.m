function [ thresholdedM ] = thresholdFeatures_CeD_003( M )

[rows,cols] = size(M);
thresholdedM = zeros(1,rows);

for i =1:rows
     cepstralMostDominantPeak_min = M(i,15);
     
    if cepstralMostDominantPeak_min < 0.03
        thresholdedM(i) =  0; 
    else
        thresholdedM(i) =  1;
    end
end



end


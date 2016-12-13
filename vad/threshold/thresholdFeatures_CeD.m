function [ thresholdedM ] = thresholdFeatures_CeD( M )

[rows,cols] = size(M);
thresholdedM = zeros(1,rows);

for i =1:rows
     cepstralMostDominantPeak_min = M(i,15);
     
    if cepstralMostDominantPeak_min < 0.02
        
        thresholdedM(i) =  0;
           
    else
        thresholdedM(i) =  1;
    end
end



% cepstralMostDominantPeak_min < 0.02
% |   cepstralMostDominantPeak_min < 0.01 : 0 (11969/697) [5982/370]
% |   cepstralMostDominantPeak_min >= 0.01
% |   |   energy < 0.13 : 0 (2671/811) [1353/393]
% |   |   energy >= 0.13 : 1 (587/224) [286/109]
% cepstralMostDominantPeak_min >= 0.02 : 1 (11943/422) [5964/208]






% for i =1:rows
%     cepstralMostDominantPeak_min = M(i,15);
%     cepstralLocPeak = M(i,7);
%     
%     if     cepstralMostDominantPeak_min < 0.02
%         if   cepstralMostDominantPeak_min < 0.01
%             thresholdedM(i) = 0;
%         else
%             if   cepstralMostDominantPeak_min < 0.02 
%                 thresholdedM(i) = 0;  
%             else
%                 if  cepstralLocPeak < 54.5 
%                     thresholdedM(i) = 0;
%                 else
%                     thresholdedM(i) = 1;
%                 end
%             end
%         end
%     else
%        thresholdedM(i) =  1;
%     end  
% end

% cepstralMostDominantPeak_min < 0.02
% |   cepstralMostDominantPeak_min < 0.01 : 0 (11969/697) [5982/370]
% |   cepstralMostDominantPeak_min >= 0.01
% |   |   cepstralMostDominantPeak_min < 0.02 : 0 (1586/405) [834/191]
% |   |   cepstralMostDominantPeak_min >= 0.02
% |   |   |   cepstralLocPeak < 54.5 : 0 (634/192) [334/119]
% |   |   |   cepstralLocPeak >= 54.5 : 1 (1038/461) [471/211]
% cepstralMostDominantPeak_min >= 0.02 : 1 (11943/422) [5964/208]



end


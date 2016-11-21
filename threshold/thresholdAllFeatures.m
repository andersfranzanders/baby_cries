function [ thresholdedM ] = thresholdAllFeatures( M )

[rows,cols] = size(M);
thresholdedM = zeros(1,rows);

for i =1:rows
    unnormalizedSpectralEntropy = M(i,3);
    normalizedSpectralEntropy = M(i,4);
    mostDominantFrequency = M(i,5);
    
    if unnormalizedSpectralEntropy < 683.94
        if unnormalizedSpectralEntropy < -16.83 
            thresholdedM(i) = 0;
        else 
            if mostDominantFrequency < 484.5
                thresholdedM(i) = 0;
            else 
                thresholdedM(i) = 0.8;
            end
        end
    else
        if mostDominantFrequency < 549.1
            if   unnormalizedSpectralEntropy < 995.37
                if  normalizedSpectralEntropy < -5.02 
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




% for i =1:rows
%     unnormalizedSpectralEntropy = M(i,3);
%     normalizedSpectralEntropy = M(i,4);
%     mostDominantFrequency = M(i,5);
%     
%     if unnormalizedSpectralEntropy < 596.59
%         if normalizedSpectralEntropy < -5.93 
%             thresholdedM(i) = 0;
%         else
%             if mostDominantFrequency < 484.5 
%                 thresholdedM(i) = 0;
%             else
%                 if unnormalizedSpectralEntropy < -33.63 
%                     thresholdedM(i) = 0;
%                 else
%                    thresholdedM(i) = 0.8;
%                 end
%             end
%         end
%     else 
%         if mostDominantFrequency < 549.1
%             if unnormalizedSpectralEntropy < 988.35
%                 if normalizedSpectralEntropy < -4.79 
%                     thresholdedM(i) = 0.8;
%                 else
%                     thresholdedM(i) = 0;
%                 end
%             else
%                 thresholdedM(i) = 0.8;
%             end
%         else
%             thresholdedM(i) = 0.8;
%         end
%     end
% end






end


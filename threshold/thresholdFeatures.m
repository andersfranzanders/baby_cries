function [ thresholdedM ] = thresholdFeatures( M )

[rows,cols] = size(M);
thresholdedM = zeros(1,rows);

%% for clean features
for i = 1:rows
    if M(i,2) <0
        thresholdedM(i) = 0;
    else
        if M(i,2) >= 0.08
            thresholdedM(i) = 0.8;
        else
            if M(i,3) < 0.14
                thresholdedM(i) = 0;
            else
                thresholdedM(i) = 0.8;
            end
        end
    end
end

% %% for noised features
% for i = 1:rows
%     entropy = M(i,2);
%     domfreq = M(i,3);
%     
%     if entropy >= 0.11
%         thresholdedM(i) = 0.8;
%     else
%         if domfreq < 0.22
%             thresholdedM(i) = 0; 
%         else 
%             thresholdedM(i) = 0.8; 
%         end
%     end    
% 
% end


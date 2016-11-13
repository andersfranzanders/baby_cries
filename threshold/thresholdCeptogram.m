function [ support,Cs ] = thresholdCeptogram( ceptogram,support )

[rows,cols] = size(ceptogram);
Cs = zeros(1,rows);
for i = 1:rows
    ceptoLength = length(ceptogram(i,:));
    [max_value, index] = max(ceptogram(i,30:100));
    Cs(i) = index;
    
    %mean_value = mean(ceptogram(i,floor(0.2*ceptoLength):floor(0.3*ceptoLength)));
    
%     if max_value*10 > 0.15
%         Cs(i) = 0.7;
%     else
%         Cs(i) = 0;
%     end
end


end


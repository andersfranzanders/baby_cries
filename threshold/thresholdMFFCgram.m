function [ support, mfccs ] = thresholdMFFCgram(mfccgram, support)
[rows,cols] = size(mfccgram);
maxes = zeros(1,cols);
for i = 1:cols
    maxes(i) = max(mfccgram(:,i));
end

mfccs = zeros(1,rows);
for i = 1:rows
    ratio = mfccgram(i,1)/maxes(1);
    if(ratio > 0.05)
        mfccs(i) = 0.75;
    else
        mfccs(i) = 0;
    end
end


end


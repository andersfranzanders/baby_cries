function [ mfccgram ] = calMFCCgram( spectogram, numOfFilters, coeffsToKeep, lowerFreq, upperFreq, Fs )
[rows, cols] = size(spectogram);

mfccgram = zeros(rows,coeffsToKeep);

for i = 1:rows
   mfccgram(i,:) = calculateMFCC(spectogram(i,:),numOfFilters,coeffsToKeep,lowerFreq, upperFreq, Fs);
end

%displaySpecto(mfccgram,1);

end

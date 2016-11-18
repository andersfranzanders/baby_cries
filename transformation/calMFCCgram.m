function [ mfccgram ] = calMFCCgram( spectogram, numOfFilters, coeffsToKeep, lowerFreq, upperFreq, Fs )
[rows, cols] = size(spectogram);

mfccgram = zeros(rows,coeffsToKeep);

for i = 1:rows
   mfccgram(i,:) = calculateMFCC(spectogram(i,:),numOfFilters,coeffsToKeep,lowerFreq, upperFreq, Fs);
end

%displaySpecto(mfccgram,1);

% figure('Name','mfccs');
% hold on;
% size(mfccgram)
% for i =1:7
%     subplot(7,1,i)
%     plot(mfccgram(:,i));
% end

end

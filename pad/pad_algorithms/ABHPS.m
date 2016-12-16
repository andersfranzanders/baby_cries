function [ pitch ] = ABHPS( x,X,minFreq,maxFreq,Fs,frameNum )

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);

acf = autocorr(x,minLag*2);
acfIndexes = 1:length(acf);
acfIndexes = Fs./(acfIndexes-1);
indexedACF = zeros(2,length(acf));
indexedACF(1,:) = acf;
indexedACF(2,:) = acfIndexes;



FFTSize = (length(X)-1)*2;
specIndexes = 1:length(X);
specIndexes = specIndexes*Fs/FFTSize;
indexedSpec = zeros(2,length(X));
indexedSpec(1,:) = X;
indexedSpec(2,:) = specIndexes;


if frameNum == 80
    
    figure('Name', 'Thatshit','position', [200, 200, 700, 400])
    subplot(2,1,1);
    plot(indexedACF(2,:),indexedACF(1,:));
    subplot(2,1,2);
    plot(indexedSpec(2,:),indexedSpec(1,:));
end
 pitch = 0;

end


function [ pitch ] = CepstrumPitch(cepstrum,Fs,minFreq,maxFreq)

lowerBound = floor((1/maxFreq)*Fs);
upperBound = floor((1/minFreq)*Fs);

truncedCeps = cepstrum(lowerBound:upperBound);

% weight cepstrum
maxWeight = 2.5;
weights = (1:(maxWeight-1)/(length(truncedCeps)-1):maxWeight);
truncedCeps = truncedCeps.*weights;

[pks,locs,w,p] = findpeaks(truncedCeps);
 
[maximumP,index] = max(pks);
if isempty(p)
   maximumP = 0;
end
pitch = Fs/(locs(index)+lowerBound);
   
end


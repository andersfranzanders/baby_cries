function [ mostDomPeak, numPeaks, locFirstPeak ] = calCeptralPeaks(ceptogram,Fs, lowerHz, upperHz )

[rows,cols] = size(ceptogram);
mostDomPeak = zeros(1,rows);
numPeaks = zeros(1,rows);
locFirstPeak = zeros(1,rows);

FFtSize = (cols-1)*2;
lowerBound = floor(lowerHz*FFtSize/Fs);
upperBound = floor(upperHz*FFtSize/Fs);

M = zeros(rows,6);
for i = 1:rows
   cepstrum = ceptogram(i,:);
   truncedCeps = cepstrum(lowerBound:upperBound);
   [pks,locs,w,p] = findpeaks(truncedCeps);
  
   numOfPromPeaks = sum(p>0.01);
   firstPeak = locs(find(p>0.01,1));
   if isempty(firstPeak)
       firstPeak = 0;
   end
   maximumP = max(p);
   if isempty(p)
       maximumP = 0;
   end
   mostDomPeak(i) = maximumP;
   numPeaks(i) = numOfPromPeaks;
   locFirstPeak(i) = firstPeak;
   
end

end


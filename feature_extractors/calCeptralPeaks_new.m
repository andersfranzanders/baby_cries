function [ mostDomPeak, locFirstPeak ] = calCeptralPeaks(ceptogram,Fs, lowerHz, upperHz )

[rows,cols] = size(ceptogram);
mostDomPeak = zeros(1,rows);
locFirstPeak = zeros(1,rows);
lowerBound = floor((1/upperHz)*Fs);
upperBound = floor((1/lowerHz)*Fs);

M = zeros(rows,6);
for i = 1:rows
   cepstrum = ceptogram(i,:);
   truncedCeps = cepstrum(lowerBound:upperBound);
   [pks,locs,w,p] = findpeaks(truncedCeps);
 
   [maximumP,index] = max(p);
   if isempty(p)
       maximumP = 0;
   end
   firstPeak = locs(index);
   
   mostDomPeak(i) = maximumP;
   locFirstPeak(i) = firstPeak;
   
end

end


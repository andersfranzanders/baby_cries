function [ magPeak, peakCount ] = calCorrelationFeatures( xInWindows,minFreq,maxFreq,Fs )

[rows,cols] = size(xInWindows);
magPeak = zeros(1,rows);
peakCount = zeros(1,rows);

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);

for i = 1:rows
    window = xInWindows(i,:);
    acf = autocorr(window,minLag);
    acf = acf(maxLag:end);
    [pks,locs,w,p] = findpeaks(acf);
    
    if isempty(pks)
        pks = 0;
    end 
    if isempty(p)
        p = 0;
    end 
    magPeak(i) = max(p);
    peakCount(i) = numel(pks);
end

end


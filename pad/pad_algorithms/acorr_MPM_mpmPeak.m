function [ pitch, clarity ] = acorr_MPM_mpmPeak( x,Fs,minFreq,maxFreq,k )

% Attention: Best Threshold found at k = 0.86

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);
pitch = 0;
clarity = 0;

%cal autocorrelation
r = zeros(1,minLag);
for i = 1:minLag
    x_j = x(1:minLag-i+1);
    x_jr = x(i:minLag);
    r(i) = sum ( x_j.*x_jr );
end

%cal SDF-type III
m = zeros(1,minLag);
for i =1:minLag
    x_j = x(1:minLag-i+1);
    x_jr = x(i:minLag);
    m(i) = sum(x_j.^2 + x_jr.^2);
end


n = (2*r)./m;


% segment the n-signal
startEndPoints = [];
startPoint = 0;
endPoint = 0;
for i = 1:length(n)
    if sign(n(i)) == 1 && startPoint == 0
       startPoint = i;
       endPoint = 0;
    end
    if sign(n(i)) == -1 && endPoint == 0;
       endPoint = i;
       startEndPoints = [startEndPoints; startPoint endPoint];
       startPoint = 0;
       
    end
    if i == length(n) && endPoint == 0;
         endPoint = i;
       startEndPoints = [startEndPoints; startPoint endPoint];
    end
end

%calculate key-peaks
[rows,cols] = size(startEndPoints);
keyPeaks = [];
for i = 2:rows
    startPoint = startEndPoints(i,1);
    endPoint = startEndPoints(i,2);
    [maxvalue, maxindex] = max(n(startPoint:endPoint));
    maxindex = startPoint + maxindex - 1;
    if maxindex >= maxLag
        keyPeaks = [keyPeaks;maxvalue,maxindex];
    end
end

if ~isempty(keyPeaks)
    n_max = max(keyPeaks(:,1));
    threshold = n_max*k;
    
    %Pick first keyPeak above threshold
    [rows,cols] = size(keyPeaks);
    pitchIndex = 0;
    for i = 1:rows
        if keyPeaks(i,1) >= threshold 
           pitchIndex = keyPeaks(i,2);
           clarity = keyPeaks(i,1);
           threshold = 100; 
        end
    end

    pitch = Fs/pitchIndex;
end
end
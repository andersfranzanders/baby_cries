function [ pitch ] = acorr_ACF_mpmPeak( x,Fs,minFreq,maxFreq,k )

%%% attention: Winnerthreshold is k = 0.95

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);

pitch = 0;

acf = autocorr(x,minLag);

n = acf;

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


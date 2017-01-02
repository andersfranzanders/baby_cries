function [ errors ] = calPitchErrors( gt,pitchMatrix )

[rows,cols] = size(pitchMatrix);
errors = zeros(1,rows);

for i =1:rows
   thisPitchSignal = pitchMatrix(i,:);
%    theDiff = (gt-thisPitchSignal);
%    [maxvalue,maxindex] = max(theDiff);
%    theSquare = theDiff.^2;
%    [maxvalue,maxindex] = max(theSquare);
%    theSum = sum(theSquare);
%    theFrac = theSum/cols;
   errors(i) = sqrt( sum( (gt-thisPitchSignal).^2)/cols );
%    theDiff = (gt-thisPitchSignal);
%    [maxvalue,maxindex] = max(theDiff);
%    [minvalue,minindex] = min(theDiff);
%    theAbs = abs(theDiff);
%    [maxvalue,maxindex] = max(theAbs);
%    theSum = sum(theAbs);
%    errors(i) = sum( abs(gt-thisPitchSignal)/cols );
end


end


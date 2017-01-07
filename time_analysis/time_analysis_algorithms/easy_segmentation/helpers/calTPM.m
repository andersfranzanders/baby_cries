function [ tpm ] = calTPM( segment,windowLengthInMs )

segLengthInSec = length(segment)*windowLengthInMs/(2*1000);

tpm = sum( diff(segment) == 1) / (segLengthInSec*0.01666);


end


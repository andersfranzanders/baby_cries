function [ Cs ] = calculateClasses(xInWindows, classSignal)

[rows, cols] = size(xInWindows);
classSignalInWindows = zeros(size(xInWindows));
windowLength = cols;

hopsize = windowLength/2;
zerosToAdd = zeros(1,(windowLength - mod(length(classSignal), windowLength)) + hopsize);
classSignal = cat(2,classSignal,zerosToAdd);


for i = 1:rows
    start = (i-1)*hopsize+1;
    buffer = classSignal(start:start+windowLength-1);
    classSignalInWindows(i,:) = buffer(:); 
end

Cs = zeros(1,rows);

for i= 1:rows
    meanClass = mean(classSignalInWindows(i,:));
    if meanClass > 0.5
        Cs(i) = 1;
    else
        Cs(i) = 0;
    end
end


end


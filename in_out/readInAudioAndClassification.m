function [ x,Fs,classSignal ] = readInAudioAndClassification( fileName )

[x,Fs] = readInAudio(fileName);
x = compressDynamicly(x,0.18);
%x = limitDynamicly(x,0.12);

classTimes = importdata((strcat(fileName,'.txt')),' ');

classSignal = zeros(1,length(x));
[rows,cols] = size(classTimes);
for i = 1:rows
    startTime = classTimes(i,1);
    endTime = classTimes(i,2);
    for sample = 1:length(x)
        if sample > startTime*Fs && sample < endTime*Fs
            classSignal(sample) = 1;
        end
    end
end

end


function [ x,Fs ] = readInAudio( fileName )

[y,Fs] = audioread(strcat(fileName,'.wav'));
[samples, channels] = size(y);
x = zeros(samples, 1);
for i = 1:samples
   x(i) = sum(y(i,1:channels)) / channels;
end

end


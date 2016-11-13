function [ domfreqs ] = calMostDominantFrequency( spectogram,Fs )

[rows,cols] = size(spectogram);
FFtsize = (cols-1)*2;
domfreqs = zeros(1,rows);
for i = 1:rows
    [max_value,index] = max(spectogram(i,:));
    %%domfreqs(i) = 10*index/cols;
    domfreqs(i) = index * (Fs/FFtsize);
end

%Smooth and normalize feauture-signal
% L = 10;
% bb = ones(1,L)/L;
% domfreqs_out = filter2(bb,domfreqs,'same');
% domfreqs_out =normalize(domfreqs_out);


end

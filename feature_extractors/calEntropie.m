function [ ents_out ] = calEntropie( specto )

[rows,cols] = size(specto);
ents = zeros(1,rows);
for i =1:rows
    abs_fft = specto(i,:);
    %px = normalize(abs_fft);
    px = abs_fft;
    ents(i) = -sum(px.*log(1+px));
end

%Smooth and normalize feauture-signal
L = 10;
bb = ones(1,L)/L;
ents_out = filter2(bb,ents,'same');
ents_out =normalize(ents_out);


end


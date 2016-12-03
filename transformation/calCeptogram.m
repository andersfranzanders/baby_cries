function [ ceptogram ] = calCeptogram( spectogram )

[rows,cols] = size(spectogram);
ceptogram = zeros(size(spectogram));

for i = 1:rows
    ceptogram(i,:) = calCepstrum(spectogram(i,:));
end

%displaySpecto(ceptogram,0.5);

end


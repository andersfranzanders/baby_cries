function [ ceptogram ] = calCeptogram( spectogram )

[rows,cols] = size(spectogram);
ceptogram = zeros(size(spectogram));

for i = 1:rows
    ceptogram(i,:) = calCepstrum(spectogram(i,:));
end

% figure('Name', 'Cepstrum');
%  
% subplot(2,1,1);
% plot(spectogram(100,:));
% subplot(2,1,2);
% plot(ceptogram(100,:));

%displaySpecto(ceptogram,0.5);

end


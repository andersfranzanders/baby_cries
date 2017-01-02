function [ pitch ] = CBHPS( spectrum, cepstrum, lowerHz, upperHz, Fs )
FFTSize = (length(spectrum)-1)*2;
spectrumPitches = 1:length(spectrum);
spectrumPitches = spectrumPitches.*Fs;
spectrumPitches = spectrumPitches/FFTSize;

cepstrumPitches = 1:length(cepstrum);
cepstrumPitches = Fs./cepstrumPitches;

cepstrumPitches2 = 1:length(cepstrum);
cepstrumPitches2 = floor(length(cepstrum)./cepstrumPitches2);


[pksS,locsS] = findpeaks(spectrum);
locsS = locsS.*(Fs/FFTSize);
[pksC,locsC] = findpeaks(cepstrum);
locsC = Fs./locsC;



pitch = 0;
end


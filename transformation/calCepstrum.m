function [ cepstrum ] = calCepstrum( abs_fft )

full_abs_fft = zeros(1,(length(abs_fft)-1)*2);
for i = 1:length(abs_fft)
    full_abs_fft(i) = abs_fft(i);
    if i>1 && i<length(abs_fft)
        full_abs_fft(end+2-i) = abs_fft(i);
    end
end

logSpectrum = log(full_abs_fft+1);
full_cepstrum = ifft(logSpectrum);
cepstrum = full_cepstrum(1:(length(full_cepstrum)/2+1));

end


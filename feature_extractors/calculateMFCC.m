function [ mfcc ] = calculateMFCC( abs_fft, numOfCoeffs, coeffsToKeep, lowerFreq, upperFreq, Fs)

% figure('Name', 'Spectogram')
% subplot(5,1,1)
% plot(abs_fft);

lowerMel = 1125*log(1+lowerFreq/700);
upperMel = 1125*log(1+upperFreq/700);
%%% follwing:
%%% http://practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/#eqn1
 
% cal power spoctrum
powerSpectrum = 1/length(abs_fft) * abs_fft.^2;
% subplot(5,1,2)
% plot(powerSpectrum);


%calculate Filter Bank
m = lowerMel : ((upperMel - lowerMel)/(numOfCoeffs+1)):upperMel;
h = 700*(exp(m/1125)-1);
nfft = (length(abs_fft)-1) * 2;
f = floor((nfft+1)*h/Fs);

H = zeros(numOfCoeffs,length(abs_fft));


for m = 1:numOfCoeffs
    for k = 1:length(abs_fft)
        if k<f(m)
            H(m,k) = 0;
        end
        if (f(m)<= k) && (k <= f(m+1))
           H(m,k) = (k-f(m))/(f(m+1)-f(m));
        end
        if (f(m+1)<= k) && (k <= f(m+2))
           H(m,k) = (f(m+2)-k)/(f(m+2)-f(m+1));
        end
        if k>f(m+2)
            H(m,k) = 0;
        end
    end
end

%calculate Energies
Es = zeros(1,numOfCoeffs);

% subplot(5,1,3);
% for m = 1:numOfCoeffs
%     plot(H(m,:));
%     hold on;
% end

% subplot(5,1,4);
for i = 1:numOfCoeffs
    filtered = H(i,:).*powerSpectrum;
    
%     plot(filtered(:));
%     hold on;
    
     Es(i) = sum(filtered);
%     Es(i) = sum(filtered.^2);
end

% subplot(5,1,5);
% stem(Es);


%log Energies
logEs = log(1+Es);


%Take DCT
decorrelated = dct(logEs);
decorrelated = decorrelated.^2;
% subplot(5,1,5);
% stem(decorrelated);

% mfcc = decorrelated(2:coeffsToKeep+1);
mfcc = decorrelated(1:coeffsToKeep);
end


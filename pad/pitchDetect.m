function [ pitchByAMFD, pitchByACF,pitchByMACF,pitchByMAMFD,pitchByCepstrum,pitchByHPS,pitchByDomFreq] = pitchDetect( xInWindows,Cs,Fs,minFreq,maxFreq,ceptogram,specto)

[rows,cols] = size(xInWindows);
pitchByAMFD = zeros(1,rows);
pitchByACF = zeros(1,rows);
pitchByMACF = zeros(1,rows);
pitchByMAMFD = zeros(1,rows);
pitchByCepstrum = zeros(1,rows);
pitchByHPS = zeros(1,rows);
pitchByCBHPS = zeros(1,rows);
pitchByDomFreq = zeros(1,rows);
for i = 1:rows
    
    if Cs(i) > 0.5
        
        x = xInWindows(i,:);
        cepstrum = ceptogram(i,:);
        X = specto(i,:);
        
         pitchByAMFD(i) = AMDF(x,Fs,minFreq,maxFreq);
%         pitchByMAMFD(i) = MAMDF(x,Fs,minFreq,maxFreq);
         pitchByACF(i) = ACF(x,Fs,minFreq,maxFreq);
%         pitchByMACF(i) = MACF(x,Fs,minFreq,maxFreq);
         pitchByCepstrum(i) = CepstrumPitch(cepstrum,Fs,minFreq,maxFreq); 
         pitchByHPS(i) = HPS(X,Fs,minFreq,maxFreq,5);
%         pitchByCBHPS(i) = CBHPS(X,cepstrum,minFreq,maxFreq,Fs);
         pitchByDomFreq(i) = DomFreq(X,Fs);
    end
end

% pitchByAMFD = medfilt1(pitchByAMFD,8);
% pitchByMAMFD = medfilt1(pitchByMAMFD,8);
% pitchByACF = medfilt1(pitchByACF,8);
% pitchByMACF = medfilt1(pitchByMACF,8);
% pitchByCepstrum = medfilt1(pitchByCepstrum,8);
% pitchByHPS = medfilt1(pitchByHPS,8);

end


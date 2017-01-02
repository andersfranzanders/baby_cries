function [ pitchMatrix ] = pitchDetect( xInWindows,Cs,Fs,minFreq,maxFreq,ceptogram,specto)

[rows,cols] = size(xInWindows);

pitch_acorr_ACF_maxPeak = zeros(1,rows);
pitch_acorr_ACF_mpmPeak = zeros(1,rows);
pitch_acorr_nACF_mpmPeak = zeros(1,rows);
pitch_acorr_MPM_mpmPeak = zeros(1,rows);

for i = 1:rows
    
    if Cs(i) > 0.5
        x = xInWindows(i,:);
        cepstrum = ceptogram(i,:);
        X = specto(i,:);

        pitch_acorr_ACF_maxPeak(i) = acorr_ACF_maxPeak(x,Fs,minFreq,maxFreq);
        pitch_acorr_ACF_mpmPeak(i) = acorr_ACF_mpmPeak(x,Fs,minFreq,maxFreq,0.95);
        pitch_acorr_nACF_mpmPeak(i) = acorr_nACF_mpmPeak(x,Fs,minFreq,maxFreq,0.85);
        pitch_acorr_MPM_mpmPeak(i) =  acorr_MPM_mpmPeak(x,Fs,minFreq,maxFreq,0.85);
    end
end
% clarityByMPM = medfilt1(clarityByMPM,10);
% pitchByMPM = medfilt1(pitchByMPM,10);
% pitchByAMFD = medfilt1(pitchByAMFD,8);
% pitchByMAMFD = medfilt1(pitchByMAMFD,8);
% pitchByACF = medfilt1(pitchByACF,8);
% pitchByMACF = medfilt1(pitchByMACF,8);
% pitchByCepstrum = medfilt1(pitchByCepstrum,8);
% pitchByHPS = medfilt1(pitchByHPS,8);

pitchMatrix = [];
pitchMatrix = [pitchMatrix;pitch_acorr_ACF_maxPeak];
pitchMatrix = [pitchMatrix;pitch_acorr_ACF_mpmPeak];
pitchMatrix = [pitchMatrix;pitch_acorr_nACF_mpmPeak];
pitchMatrix = [pitchMatrix;pitch_acorr_MPM_mpmPeak];

end


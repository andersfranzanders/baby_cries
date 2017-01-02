function [ x,Fs,pitchSignal ] = readInAudioAndPitchdata( filename )

[x,Fs] = readInAudio(filename);

x = compressDynamicly(x,0.18);
pitchSignal = zeros(1,length(x));
try
    pitchSignal = importdata((strcat(filename,'.txt')),' ');
    pitchSignal = pitchSignal';

catch
    warning('Could not find file providing voiced/unvoiced-classification.');
end


end


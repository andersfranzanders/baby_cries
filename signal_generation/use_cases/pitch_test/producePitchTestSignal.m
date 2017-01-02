function [ outSignal,classSignal,Fs ] = producePitchTestSignal( pathToCrySet,pathToNoiseSignal,aimSNRinDB )

%read in all the cry segments into a set.
cry_set_names = getAllFileNamesInDirectory(pathToCrySet);
Fs = 0;
crySet = [];
for i = 1:length(cry_set_names)
    [audio,samplingrate] = readInAudio(strcat(pathToCrySet,cry_set_names{i}));
    Fs = samplingrate;
    audio = normalize(audio');
    crySet = [{audio}; crySet];
end

[numOfSignals, cols] = size(crySet);


crySignal = [];
classSignal = [];

%begin cry with random pause
randomPause = 0.5;
randomPause = zeros(1, floor(randomPause*Fs));
crySignal = [randomPause,crySignal];
classSignal = [randomPause,classSignal];

%construct signal by concatinating random cry segments
for i =1:length(crySet)
    %select random cry
    audio = crySet{i};
    
    
    %concatinate to output-signal
    crySignal = [audio,crySignal];
    classSignal = [ones(1,length(audio)), classSignal];
    %add random pause between cry
    Pause = 0.5;
    randomPause = zeros(1, floor(Pause*Fs));
    crySignal = [randomPause,crySignal];
    classSignal = [randomPause,classSignal];
    
end

%read in noise signal and concatinated it to match the cry signals size
noise = readInAudio(pathToNoiseSignal);
noise = noise';
concatNoiseSignal = [];
while length(concatNoiseSignal) < length(crySignal)
    concatNoiseSignal = [noise, concatNoiseSignal];
end

concatNoiseSignal = concatNoiseSignal(1:length(crySignal));

outSignal = addNoiseToCry(crySignal, concatNoiseSignal, aimSNRinDB);


end


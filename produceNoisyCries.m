pathToCrySet = '../audiobase/truncated/clean/';
pathToNoise = '../audiobase/truncated/noise/';
outPath = '../audiobase/truncated/real_noise/50+3db/';


crySignals = {'cry_clean01','cry_clean02','cry_clean03','cry_clean04','cry_clean05','cry_clean06'};
SNRsinDB = [50,3];
noiseSignals = {'corridor','hospital','barcelona'};

%Plot Input Signal
%figure('Name', 'Signal','position', [100, 100, 700, 700])

for noiseIndex = 1:length(noiseSignals)
    for snrIndex = 1:length(SNRsinDB)
        for cryIndex = 1:length(crySignals)

            crySignal = crySignals{cryIndex}
            SNRinDB = SNRsinDB(snrIndex)
            noiseSignal = noiseSignals{noiseIndex}

            [x,Fs] = readInAudio(strcat(pathToCrySet,crySignal));
            [n,Fs] = readInAudio(strcat(pathToNoise,noiseSignal));
            n = n(1:length(x));

            noisedX = addNoiseToCry(x,n,SNRinDB);

            filename = strcat(outPath,crySignal,'_',noiseSignal,'_',num2str(SNRinDB),'db');
            audiowrite(strcat(filename,'.wav'),noisedX,Fs,'BitsPerSample',16);
            
            classTimesMatrix = importdata(strcat(pathToCrySet,crySignal,'.txt'),' ');
            dlmwrite(strcat(filename,'.txt'),classTimesMatrix,'delimiter',' ');
            
        end
    end
end
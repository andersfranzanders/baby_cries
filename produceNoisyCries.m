pathToCrySet = '../audiobase/truncated/clean/';
pathToNoise = '../audiobase/truncated/noise/';
outPath = '../audiobase/truncated/real_noise/25db/';


crySignals = {'cry_clean01','cry_clean02','cry_clean03','cry_clean04','cry_clean05','cry_clean06'};
SNRsinDB = [25];
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

            t = (0:1/Fs:(length(x)-1)/Fs);
    %         subplot(3,1,1)
    %         plot(t,x);
    % 
    %         hold on;
    %         subplot(3,1,2)
    %         plot(t,n);

            noisedX = addNoiseToCry(x,n,SNRinDB);
    %         subplot(3,1,3)
    %         plot(t,noisedX);

            filename = strcat(outPath,crySignal,'_',noiseSignal,'_',num2str(SNRinDB),'db');
            audiowrite(strcat(filename,'.wav'),noisedX,Fs,'BitsPerSample',16);
            
            classTimesMatrix = importdata(strcat(pathToCrySet,crySignal,'.txt'),' ');
            dlmwrite(strcat(filename,'.txt'),classTimesMatrix,'delimiter',' ');
            
        end
    end
end
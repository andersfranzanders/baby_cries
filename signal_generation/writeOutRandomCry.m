pathToCrySet = '../audiobase/single_cries/clean/';
noiseSignal = '../audiobase/truncated/noise/corridor';
outPath = '../audiobase/random_cries/';
cryEvents = 7;
SNRinDB = -5;

figure('Name', 'RandomSignal','position', [100, 100, 700, 700])
[x,Cs,Fs] = produceRandomCry(pathToCrySet,noiseSignal,cryEvents,2, SNRinDB);
CMatrix = convertClassSignalToMatrix(Cs,Fs);

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
plot(t,x);
hold on;
plot(t,Cs);

CMatrix

filename = strcat(outPath,'RandomCry_',num2str(cryEvents),'events_',num2str(SNRinDB),'dbSNR');
audiowrite(strcat(filename,'.wav'),x,Fs,'BitsPerSample',16);

dlmwrite(strcat(filename,'.txt'),CMatrix,'delimiter',' ');

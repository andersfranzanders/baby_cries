pathToCrySet = '../audiobase/single_cries/clean/';
noisePath = '../audiobase/truncated/noise/';
noiseName = 'hospital';
outPath = '../audiobase/random_cries/';
cryEvents = 3;
SNRinDB = 50;
maxPaus = 2;

figure('Name', 'RandomSignal','position', [100, 100, 700, 200])
%[x,Cs,Fs] = produceRandomCry(pathToCrySet,strcat(noisePath,noiseName),cryEvents,maxPaus, SNRinDB);
[x,Cs,Fs] = producePitchTestSignal(pathToCrySet,strcat(noisePath,noiseName),SNRinDB);
CMatrix = convertClassSignalToMatrix(Cs,Fs);

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
plot(t,x);
hold on;
plot(t,Cs);

%CMatrix

filename = strcat(outPath,'RandomCry_',num2str(cryEvents),'events_',num2str(SNRinDB),'dbSNR_',noiseName);
audiowrite(strcat(filename,'.wav'),x,Fs,'BitsPerSample',16);

dlmwrite(strcat(filename,'.txt'),CMatrix,'delimiter',' ');

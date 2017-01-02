pathToCrySet = '../audiobase/single_cries/clean/';
noisePath = '../audiobase/truncated/noise/';
noiseName = 'barcelona';
outPath = '../audiobase/testsignals/pitchTesting/';
SNRinDB = 50;

figure('Name', 'RandomSignal','position', [100, 100, 700, 200])
[x,Cs,Fs] = producePitchTestSignal(pathToCrySet,strcat(noisePath,noiseName),SNRinDB);
CMatrix = convertClassSignalToMatrix(Cs,Fs);

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
plot(t,x);
hold on;
plot(t,Cs);

%CMatrix

 filename = strcat(outPath,'PitchTest_',num2str(SNRinDB),'dbSNR_',noiseName);
 audiowrite(strcat(filename,'.wav'),x,Fs,'BitsPerSample',16);
 dlmwrite(strcat(filename,'.txt'),CMatrix,'delimiter',' ');

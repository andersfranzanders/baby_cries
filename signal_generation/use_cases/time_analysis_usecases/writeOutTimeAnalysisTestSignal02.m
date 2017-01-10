pathToCrySet = '../audiobase/single_cries/use_case_timeAnaylsis/';
noisePath = '../audiobase/truncated/noise/';
noiseName = 'barcelona';
outPath = '../audiobase/testsignals/time_analysis_testing/';
SNRinDB = 20;
useCaseNum = 1;

figure('Name', 'RandomSignal','position', [100, 100, 700, 200])
[x,Cs,Fs] = timeAnalysis_useCase01(pathToCrySet,strcat(noisePath,noiseName),SNRinDB);
CMatrix = convertClassSignalToMatrix(Cs,Fs);

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
plot(t,x);
hold on;
plot(t,Cs);

%CMatrix
% 
filename = strcat(outPath,'TimeAnalysis_testSignal_useCase'...
    ,num2str(useCaseNum),'_',num2str(SNRinDB),'dbSNR_',noiseName);
audiowrite(strcat(filename,'.wav'),x,Fs,'BitsPerSample',16);
dlmwrite(strcat(filename,'.txt'),CMatrix,'delimiter',' ');

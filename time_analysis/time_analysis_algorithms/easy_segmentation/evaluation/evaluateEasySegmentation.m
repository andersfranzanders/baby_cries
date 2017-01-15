pathToCrySet = '../audiobase/single_cries/use_case_timeAnaylsis/';
noisePath = '../audiobase/truncated/noise/';
noiseName = 'barcelona';
outPath = '../audiobase/testsignals/time_analysis_testing/';
SNRinDB = 20;

[x,classSignal,Fs,segmentsMetaData] = timeAnalysis_evaluationUseCase(pathToCrySet,strcat(noisePath,noiseName),SNRinDB);
segmentsMetaData
x = x';

figure('Name', 'EvaluationSignal','position', [100, 100, 700, 200])
t = (0:1/Fs:(length(x)-1)/Fs);

hold on;
subplot(2,1,1);    
plot(t,x,'Color',[0.5,0.5,0.5]);

new_x = convertToBlackX(x,classSignal,1:length(classSignal));
hold on;
subplot(2,1,1);    
plot(t,new_x,'k');

[ support,xInWindows,specto,ceptogram] = windowAndTransform( x,25,Fs );
Cs = calculateClasses(xInWindows, classSignal);
[ segmentDensities,burstLengths, cryLengths, pauseLengths, energies,durations ] = easySegmentation( Cs, support, x, 25, 10);

hold on;
subplot(2,1,2);    
stem(support/Fs,segmentDensities, 'c');

hold on;
subplot(2,1,2);    
plot(t,x,'Color',[0.5,0.5,0.5]);

new_x = convertToBlackX(x,Cs,support);
hold on;
subplot(2,1,2);    
plot(t,new_x,'k');

assertStuff(segmentsMetaData, burstLengths, cryLengths, pauseLengths, energies,durations );
pathToTrainingset = '../audiobase/random_cries/';
trainingSignal = 'RandomCry_3events_5dbSNR'

featureMatrix = zeros(1,4);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

[x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,trainingSignal));

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
subplot(4,1,1);    
plot(t,x);

[support,M] = windowAndExtractFeatures( x,classSignal,25,Fs );

thresholdedM = thresholdAllFeatures(M);
smoothedM = postProcessM03(thresholdedM);

hold on;
subplot(4,1,1);    
plot(support/Fs,smoothedM,'g');

hold on;
subplot(4,1,1);    
plot(support/Fs,smoothedM,'r');
% 
% 
% 
% legend('Signal','Labeled Class','Smoothed Class');

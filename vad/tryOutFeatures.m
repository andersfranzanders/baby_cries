pathToTrainingset = '../audiobase/truncated/real_noise_test/';
trainingSignal = 'cry_clean07_ambience_7db'

featureMatrix = zeros(1,4);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

[x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,trainingSignal));

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
subplot(4,1,1);    
plot(t,x);

[support,M] = windowAndExtractFeatures( x,classSignal,25,Fs );


%MwithMins = addMinAndMaxToM(M,4,25);

hold on
subplot(4,1,1);    
plot(support/Fs,M(:,end),'r');

hold on
subplot(4,1,2);    
plot(support/Fs,M(:,15),'b');





% thresholdedM = thresholdAllFeatures(MwithMins);
% processedM = postProcessM03(thresholdedM);
% 
% hold on;
% subplot(4,1,1);    
% plot(support/Fs,processedM,'g');
% 
% 
% 
% legend('Signal','Labeled Class','Smoothed Class');

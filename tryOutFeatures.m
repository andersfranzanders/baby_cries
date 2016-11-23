pathToTrainingset = '../audiobase/truncated/real_noise/5db/';
trainingSignal = 'cry_clean01_hospital_5db'

featureMatrix = zeros(1,4);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

[x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,trainingSignal));

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
subplot(4,1,1);    
plot(t,x);

[support,M] = windowAndExtractFeatures( x,classSignal,25,Fs );


MwithMins = addMinsToM(M,1,25);

hold on;
subplot(4,1,1);    
plot(support/Fs,MwithMins(:,end));

hold on;
subplot(4,1,2);    
plot(support/Fs,MwithMins(:,6));

hold on;
subplot(4,1,2);    
plot(support/Fs,MwithMins(:,16));



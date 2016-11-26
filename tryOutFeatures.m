pathToTrainingset = '../audiobase/truncated/real_noise/50db/';
trainingSignal = 'cry_clean05_hospital_50db'

featureMatrix = zeros(1,4);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

[x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,trainingSignal));

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
subplot(4,1,1);    
plot(t,x);

[support,M] = windowAndExtractFeatures_newFeats( x,classSignal,25,Fs );


MwithMins = addMinsToM_new(M,3,25);

hold on;
subplot(4,1,1);    
plot(support/Fs,MwithMins(:,end));

% hold on;
% subplot(4,1,2);    
% plot(support/Fs,newFeatures);

hold on;
subplot(4,1,2);    
plot(support/Fs,MwithMins(:,[1,10]));
hold on;
subplot(4,1,3);    
plot(support/Fs,MwithMins(:,[8,17]));
hold on;
subplot(4,1,4);    
plot(support/Fs,MwithMins(:,[9,18]));



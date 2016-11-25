pathToTrainingset = '../audiobase/truncated/real_noise/0db/';
trainingSignal = 'cry_clean06_corridor_0db'

featureMatrix = zeros(1,4);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

[x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,trainingSignal));

t = (0:1/Fs:(length(x)-1)/Fs);
hold on;
subplot(4,1,1);    
plot(t,x);

[support,M] = windowAndExtractFeatures_newFeats( x,classSignal,25,Fs );


MwithMins = addMinsToM(M,1,25);

hold on;
subplot(4,1,1);    
plot(support/Fs,MwithMins(:,end));

% hold on;
% subplot(4,1,2);    
% plot(support/Fs,newFeatures);

hold on;
subplot(4,1,2);    
plot(support/Fs,MwithMins(:,9));
hold on;
subplot(4,1,3);    
plot(support/Fs,MwithMins(:,10));
hold on;
subplot(4,1,4);    
plot(support/Fs,MwithMins(:,6));



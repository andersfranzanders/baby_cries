pathToTrainingset = '../audiobase/truncated/clean/';
training_set = {'cry_clean01','cry_clean02','cry_clean03','cry_clean04'};

% pathToTrainingset = '../audiobase/truncated/real_noise/';
% training_set = {
% 'cry_clean01_corridor_5db'
% 'cry_clean01_corridor_15db'
% 'cry_clean01_hospital_5db'
% 'cry_clean01_hospital_15db'};

featureMatrix = zeros(1,4);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));

   
    %sound(x,Fs);
    t = (0:1/Fs:(length(x)-1)/Fs);
    subplot(length(training_set),1,i);    
    plot(t,x);
    
    [support,M] = windowAndExtractFeatures( x,classSignal,25,Fs );
    thresholdedM = thresholdFeatures(M);
    postProcessedM = postProcessM(thresholdedM);
    
    hold on;
    subplot(length(training_set),1,i);    
    plot(support/Fs,M(:,end));
    
    hold on;
    subplot(length(training_set),1,i);    
    plot(support/Fs,postProcessedM);

end
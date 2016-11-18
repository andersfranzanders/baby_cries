pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    subplot(length(training_set),1,i);    
    plot(t,x);
    
    [support,M] = windowAndExtractFeatures( x,classSignal,25,Fs );
    thresholdedM = thresholdAllFeatures(M);
    postProcessedM = postProcessM(thresholdedM);
    
    hold on;
    subplot(length(training_set),1,i);    
    plot(support/Fs,M(:,end));
    
     hold on;
    subplot(length(training_set),1,i);    
    plot(support/Fs,postProcessedM);
    

end
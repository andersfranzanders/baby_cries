pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);



for i = 1:length(training_set)
    training_set{i}
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    
    [calCs,support] = voiceActivityDetection( x,classSignal,25,Fs );
    [segments,ampelDensities,ampelTempos,ampelBursts,ampelDurations] = easySegmentation_ampelplot( calCs, support, x, 25, 5);
    
    %Plot Input Signal
    figure('Name', training_set{i},'position', [200, 200, 900, 600])
    
    plotAmpelValues(4,1,1,85,Fs,ampelDensities);
    plotAmpelValues(4,1,2,85,Fs,ampelTempos);
    plotAmpelValues(4,1,3,85,Fs,ampelBursts);
    plotAmpelValues(4,1,4,85,Fs,ampelDurations);
    
    hold on;
    subplot(4,1,1);    
    plot(t,x,'Color',[0.5,0.5,0.5]);
    
    new_x = convertToBlackX(x,calCs,support);
    subplot(4,1,1);    
    plot(t,new_x,'k');
    


end

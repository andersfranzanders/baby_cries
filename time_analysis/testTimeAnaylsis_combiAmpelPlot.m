pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);



for i = 1:length(training_set)
    training_set{i}
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    
    [calCs,support] = voiceActivityDetection( x,classSignal,25,Fs );
    [combiAmpel] = easySegmentation_combiAmpelplot( calCs, support, x, 25, 5);
    
    %Plot Input Signal
    figure('Name', training_set{i},'position', [200, 200, 600, 300])
    
    plotCombiAmpelValues(2,1,1,80,Fs,combiAmpel);
    plotCombiAmpelValues(2,1,2,80,Fs,combiAmpel);
    
    hold on;
    subplot(2,1,1);    
    plot(t,x,'Color',[0.5,0.5,0.5]);
    
    new_x = convertToBlackX(x,calCs,support);
    hold on;
    subplot(2,1,1);    
    plot(t,new_x,'k');
    


end

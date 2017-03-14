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
    figure('Name', training_set{i},'position', [200, 200, 800, 550])
    set(gcf,'color','w');
    %plotAmpelValues(4,1,1,90,Fs,ampelDensities);
    %plotAmpelValues(4,1,2,90,Fs,ampelTempos);
    %plotAmpelValues(4,1,3,90,Fs,ampelBursts);
    plotAmpelValues(2,1,2,90,Fs,ampelDurations);
    axis([0,350,-1,1])
    
    
    hold on;
    subplot(2,1,1);    
    plot(support/Fs,calCs*0.95, 'r');
    axis([0,350,-1,1])
    
    hold on;
    subplot(2,1,1);    
    plot(t,x,'Color','k');
    axis([0,350,-1,1])
    
%     hold on;
%     subplot(2,1,1);    
%     plot(t,x,'Color',[0.5,0.5,0.5]);
%     axis([0,350,-1,1])
%     
%     new_x = convertToBlackX(x,calCs,support);
%     hold on;
%     subplot(2,1,1);    
%     plot(t,new_x,'k');
%     axis([0,350,-1,1])
    

end

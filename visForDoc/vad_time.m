pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 200])
set(gcf,'color','w');

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    subplot(1,1,1);    
    plot(t,x,'k');
    
    [support,M] = windowAndExtractFeatures_2000( x,classSignal,25,Fs );
    
    hold on;
    subplot(1,1,1);    
    plot(support/Fs,M(:,end)*0.95, 'g');
    
%     hold on;
%     subplot(1,1,1);    
%     plot(support/Fs,M(:,1), 'r');
    hold on;
    subplot(1,1,1);    
    plot(support/Fs,M(:,10), 'r');

end
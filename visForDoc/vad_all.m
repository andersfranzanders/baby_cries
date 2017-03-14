pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal
 figure('Name', 'Signal','position', [200, 200, 700, 400])
set(gcf,'color','w');

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    hold on;
    t = (0:1/Fs:(length(x)-1)/Fs);
    subplot(10,1,1);    
    plot(t,x,'k');
    
    [support,M] = windowAndExtractFeatures_2000( x,classSignal,25,Fs );
    
    hold on;
    subplot(10,1,1);    
    plot(support/Fs,M(:,end)*0.95, 'r');
    
    hold on;
    subplot(10,1,2);    
    plot(support/Fs,M(:,1), 'r');
    
    hold on;
    subplot(10,1,3);    
    plot(support/Fs,M(:,2), 'r');
    
    hold on;
    subplot(10,1,4);    
    plot(support/Fs,M(:,3), 'r');
    
    hold on;
    subplot(10,1,5);    
    plot(support/Fs,M(:,4), 'r');
    
    hold on;
    subplot(10,1,6);    
    plot(support/Fs,M(:,5), 'r');
    
    hold on;
    subplot(10,1,7);    
    plot(support/Fs,M(:,6), 'r');
    
    hold on;
    subplot(10,1,8);    
    plot(support/Fs,M(:,7), 'r');
    
    hold on;
    subplot(10,1,9);    
    plot(support/Fs,M(:,8), 'r');
    
    hold on;
    subplot(10,1,10);    
    plot(support/Fs,M(:,9), 'r');


end
pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

%Plot Input Signal

for i = 1:length(training_set)
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    [calCs,support,realCs,xInWindows,spectogram,ceptogram] = pipeline_vad( x,classSignal,25,Fs );
    cryUnits = pipeline_markCryUnits(support, calCs, Fs);
    [segments,segmentMarkerSignal ] = pipeline_segment( cryUnits, 1.3, Fs, support );
    [start_ends,seg_length, density, tempo, cu_stats] = pipeline_calTimeFeatures(segments,Fs);
    [ pain_scores,max_score ] = pipeline_regressPainscore( start_ends,seg_length );
    [ viz_data ] = pipeline_calVizData( start_ends, length(x)/Fs, pain_scores, max_score );
    
    
    
    figure('Name', training_set{i},'position', [200, 200, 700, 400])
    
    drawPainScoreLine( viz_data,[2,1,2],100,Fs );
    
    %hold on;
    %subplot(1,2,1);
    %stem(support/Fs,segmentMarkerSignal,'Color','c');
    
    hold on;
    subplot(2,1,1);    
    plot(t,x,'Color',[0.5,0.5,0.5]);
    
    new_x = convertToBlackX(x,calCs,support);
    subplot(2,1,1); 
    hold on;
    plot(t,new_x,'k');
    
  

end
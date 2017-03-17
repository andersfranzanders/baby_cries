pathToTrainingset = '../audiobase/temptestbase/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);

t_s = 10;
t_a = 5;
%Plot Input Signal

for i = 1:length(training_set)
    training_set{i}
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));
    
    t = (0:1/Fs:(length(x)-1)/Fs);
    
    [calCs,support,realCs,xInWindows,spectogram,ceptogram] = pipeline_vad( x,classSignal,25,Fs );
    cryUnits = pipeline_markCryUnits(support, calCs, Fs);
    [segments,segmentMarkerSignal ] = pipeline_segment( cryUnits, t_s, Fs, support );    
    [ all_start_ends, all_seg_length, all_densities, all_mins] = pipeline_calTimeFeatures_t( segments,Fs,t_a,t_s);
    [ all_pain_scores, max_score ] = pipeline_regressPainscore_t( all_start_ends,all_seg_length,all_densities,all_mins );
    [ viz_data ] = pipeline_calVizData_t( all_start_ends, length(x)/Fs, all_pain_scores, max_score );
    
    
    figure('Name', training_set{i},'position', [200, 200, 700, 400])
    
    drawPainScoreLine( viz_data,[2,1,2],100,Fs );
    
    %hold on;
    %subplot(1,2,1);
    %stem(support/Fs,segmentMarkerSignal,'Color','c');
    
    hold on;
    subplot(2,1,1);    
    plot(t,x,'Color',[0.5,0.5,0.5]);
    axis([0 length(x)/Fs -1 1]);
    
    new_x = convertToBlackX(x,calCs,support);
    subplot(2,1,1); 
    hold on;
    plot(t,new_x,'k');
    axis([0 length(x)/Fs -1 1]);
    
  

end
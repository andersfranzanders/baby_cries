function [ x,c ] = produceTimeAnalysisSegment(crySignal,Fs,cryEvents, minCryLength, maxCryLength, minPauseLength, maxPauseLength  )

x = [];
c = [];

%construct signal by concatinating random cry segments
minRandomGain = 0.6;
maxRandomGain = 1;
for i =1:cryEvents
    %truncated long cry to length
    randomCryLength = minCryLength + (maxCryLength-minCryLength)*rand();
    x_i = crySignal(1:floor(randomCryLength*Fs));
    
    %apply random gain to cry
    randomGain = minRandomGain + (maxRandomGain-minRandomGain)*rand();
    x_i = x_i.*randomGain;
    
    %concatinate to output-signal
    x = [x,x_i];
    c = [c, ones(1,length(x_i))];
    
    %add random pause between cry
    randomPauseLength = minPauseLength + (maxPauseLength-minPauseLength)*rand();
    p_i = zeros(1, floor(randomPauseLength*Fs));
    x = [x,p_i];
    c = [c,p_i];
    
end

end


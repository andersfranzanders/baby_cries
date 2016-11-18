function M = postProcessM(M)


minSilenceRun = 5;
minVoiceRun = 5;
voicedSegmentStart = 1;
silenceStart = 1;




for i = 2:length(M)
    
    if M(i-1) == 0 && M(i) == 0.8
       voicedSegmentStart = i;
    end
    if M(i-1) == 0.8 && M(i) == 0
       voicedSegmentEnd = i;
       if (voicedSegmentEnd - voicedSegmentStart) < minVoiceRun
            M(voicedSegmentStart:voicedSegmentEnd) = 0;
       end
    end
  
end

for i = 2:length(M)
    if M(i-1) == 0 && M(i) == 0.8
       silenceEnd = i;
       if (silenceEnd - silenceStart) < minSilenceRun
            M(silenceStart:silenceEnd) = 0.8;
       end
    end
    if M(i-1) == 0.8 && M(i) == 0
       silenceStart = i;
    end
end




end


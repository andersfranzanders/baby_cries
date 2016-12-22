function M = decisionSmoothing(M)


minVoiceRun = 4;
minSilenceRun = 4;


erasedElement = 0;
nextSilenceStart = 0;
for i = 2:length(M)
    
    if M(i-1) == 0 && M(i) == 1
       
       silenceEnd = i;
       if erasedElement == 0
            thisSilenceStart = nextSilenceStart;  
       end
       
       voicedSegmentStart = i;
       erasedElement = 0;
    end
    
    if M(i-1) == 1 && M(i) == 0
       voicedSegmentEnd = i;
        nextSilenceStart = i;
       if (voicedSegmentEnd - voicedSegmentStart) < minVoiceRun
           if (silenceEnd - thisSilenceStart) > minSilenceRun
               M(voicedSegmentStart:voicedSegmentEnd) = 0;
               erasedElement = 1;
           else
                M(thisSilenceStart:silenceEnd) = 1;
           end
           
       end
    end
  
end

silenceStart = 0;
for i = 2:length(M)
    if M(i-1) == 1 && M(i) == 0
        silenceStart = i;
    end
    
    if M(i-1) == 0 && M(i) == 1
        silenceEnd = i;
        if silenceEnd - silenceStart <= minSilenceRun
            M(silenceStart:silenceEnd) = 1;
        end
    end
end


% for i = 1:length(M)
%     if M(i) == 1
%         M(i) = 0.8;
%     end
% end

end


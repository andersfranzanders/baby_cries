function [ all_start_ends, all_seg_length] = pipeline_calTimeFeatures_t( segments,Fs,t_act,t_s)

all_start_ends = [];
all_seg_length = [];

for segNum = 1:length(segments)

    cs = segments{segNum};
    subseg_start = cs(1,1)/Fs;
    currentEnd = subseg_start + t_act;
    totalEnd = cs(end,2)/Fs;


    seg_start_ends = [];
    seg_length_all = [];
    lastKnownEnd = subseg_start;

    while currentEnd < (totalEnd + t_s)
       subseg = [];
       numCryUnits = size(cs);
       for i = 1:numCryUnits
            if cs(i,2)/Fs < currentEnd
                subseg = [subseg; cs(i,1)/Fs, cs(i,2)/Fs];
            end
       end
       x = 2;
       if ~isempty(subseg) && subseg(end,2)>lastKnownEnd

           subseg_end = subseg(end,2);
           subseg_startEnd = [subseg_start;subseg_end];
           seg_start_ends = [seg_start_ends,subseg_startEnd];

           subseg_length = subseg_end - subseg_start;
           seg_length_all = [seg_length_all, subseg_length];
            
           lastKnownEnd = subseg_end;

       end

       currentEnd = currentEnd + t_act;
    end
   
    all_start_ends = [all_start_ends,{seg_start_ends}];
    all_seg_length = [all_seg_length, {seg_length_all}];
end

end


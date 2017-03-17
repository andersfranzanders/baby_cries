function [ all_start_ends, all_seg_length, all_densities, all_mins] = pipeline_calTimeFeatures_t( segments,Fs,t_act,t_s)

all_start_ends = [];
all_seg_length = [];
all_densities = [];
all_mins = [];


for segNum = 1:length(segments)

    cs = segments{segNum};
    subseg_start = cs(1,1)/Fs;
    currentEnd = subseg_start + t_act;
    totalEnd = cs(end,2)/Fs;


    seg_start_ends = [];
    seg_length_all = [];
    seg_densities = [];
    seg_mins = [];
    lastKnownEnd = subseg_start;

    while currentEnd < (totalEnd + t_s)
       subseg = [];
       numCryUnits = size(cs);
       for i = 1:numCryUnits
            if cs(i,2)/Fs < currentEnd
                subseg = [subseg; cs(i,1)/Fs, cs(i,2)/Fs];
            end
       end
      
       if ~isempty(subseg) && subseg(end,2)>lastKnownEnd

           subseg_end = subseg(end,2);
           subseg_startEnd = [subseg_start;subseg_end];
           seg_start_ends = [seg_start_ends,subseg_startEnd];

           subseg_length = subseg_end - subseg_start;
           seg_length_all = [seg_length_all, subseg_length];
           
           subseg_density = sum(subseg(:,2) - subseg(:,1))/(subseg_length);
           seg_densities = [seg_densities, subseg_density];
           
           subseg_min = min(subseg(:,2) - subseg(:,1));
           seg_mins = [seg_mins, subseg_min];
           
           
           lastKnownEnd = subseg_end;

       end

       currentEnd = currentEnd + t_act;
    end
   
    all_start_ends = [all_start_ends,{seg_start_ends}];
    all_seg_length = [all_seg_length, {seg_length_all}];
    all_densities = [all_densities, {seg_densities}];
    all_mins = [all_mins,{seg_mins}]
end

end


function [ viz_data ] = pipeline_calVizData_t( all_start_ends, endTime, all_pain_scores, max_score )

numOfSegs  = length(all_start_ends);

pauseGreen = getDescreteColorForScore(0,max_score);
current_start = 0;
viz_data =[]; 

for i = 1:numOfSegs
    currentSeg = all_start_ends{i};
    current_end = currentSeg(1,1);
    viz_entry = [current_start; current_end; pauseGreen];
    viz_data = [viz_data, viz_entry];
    
    current_start = currentSeg(end,end);
    
end

viz_entry = [current_start; endTime; pauseGreen];
viz_data = [viz_data, viz_entry];

for currentSegNum =1:numOfSegs
    
    start_ends = all_start_ends{currentSegNum};
    pain_scores = all_pain_scores{currentSegNum};
    [rows,cols] = size(start_ends);
    current_start = 0;
    for i = 1:cols
        if i == 1
           current_start = start_ends(1,i);
        else
           current_start = start_ends(2,i-1);
        end
        current_end = start_ends(2,i);
        current_score = pain_scores(i);
       
        %score_n = 1 - current_score/max_score;
        %[r,g,b] = hsv2rgb(score_n*120/360,0.8,1);
        color = getDescreteColorForScore(current_score,max_score);
        viz_entry = [current_start; current_end; color];
        viz_data = [viz_data, viz_entry];
    end
end

end


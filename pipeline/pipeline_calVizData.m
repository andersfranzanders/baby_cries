function [ viz_data ] = pipeline_calVizData( start_ends, endTime, pain_scores, max_score )

pauseGreen = [0;0.95;0];

current_start = 0;
viz_data =[]; 
[rows,cols] = size(start_ends);

for i = 1:cols
    current_end = start_ends(1,i);
    viz_entry = [current_start; current_end; pauseGreen];
    viz_data = [viz_data, viz_entry];
    
    current_start = start_ends(2,i);
    
end

viz_entry = [current_start; endTime; pauseGreen];
viz_data = [viz_data, viz_entry];

for i = 1:cols
    current_start = start_ends(1,i);
    current_end = start_ends(2,i);
    current_score = pain_scores(i);
    score_n = 1 - current_score/max_score;
    
    [r,g,b] = hsv2rgb(score_n*120/360,0.8,1);
    viz_entry = [current_start; current_end; r; g; b];
    viz_data = [viz_data, viz_entry];
end


end


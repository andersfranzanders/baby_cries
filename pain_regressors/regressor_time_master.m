function [ pain_scores,max_value ] = regressor_time_master( seg_lengths )

max_value = 2;
pain_scores = zeros(1,length(seg_lengths));
for i =1:length(seg_lengths)
    
    if seg_lengths(i) < 60
        score = 1;
    else 
        score = 2;
    end
    pain_scores(i) = score;
end    


end


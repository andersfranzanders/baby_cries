function [ pain_scores,max_value ] = regressor_time_continuous( seg_lengths,max_length )

max_value = 3;
pain_scores = zeros(1,length(seg_lengths));
for i =1:length(seg_lengths)
    score = (seg_lengths(i)/max_length) * max_value;
    if score > max_value
        score = max_value;
    end
    pain_scores(i) = score;
end    


end


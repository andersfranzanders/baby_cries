function [ pain_scores,max_value ] = regressor_min_master( mins )

max_value = 3;
pain_scores = zeros(1,length(mins));
for i =1:length(mins)
    
    score = 0;
    
    if mins(i) >= 0.3
        score = 1;
    end
    
    if mins(i) >= 1.1
        score = 2;
    end
    
    if mins(i) > 2
        score = 3;
    end
    
    pain_scores(i) = score;
end    


end


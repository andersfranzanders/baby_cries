function [ pain_scores,max_value ] = regressor_density_continuous( densities )

max_value = 2;
pain_scores = zeros(1,length(densities));
for i =1:length(pain_scores)
    score = densities(i)/0.9 * max_value;
    if score > max_value
        score = max_value;
    end
    pain_scores(i) = score;
end    


end


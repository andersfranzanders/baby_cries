function [ pain_scores,max_score ] = regressor_trivial( start_ends )

max_score = 3;

[rows,cols] = size(start_ends);

pain_scores = ones(1,cols)*max_score;

end


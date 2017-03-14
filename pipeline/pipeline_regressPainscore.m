function [ pain_scores,max_score ] = pipeline_regressPainscore( start_ends,seg_lengths )


%[ pain_scores,max_score ] = regressor_trivial( start_ends );
[ pain_scores,max_score ] = regressor_time_continuous( seg_lengths,4 );

end


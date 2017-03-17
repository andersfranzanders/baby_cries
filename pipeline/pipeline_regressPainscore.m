function [ pain_scores,max_score ] = pipeline_regressPainscore( start_ends,seg_lengths,density )


%[ pain_scores,max_score ] = regressor_trivial( start_ends );
%[ pain_scores,max_score ] = regressor_time_continuous( seg_lengths,90 );
%[ pain_scores,max_score ] = regressor_density_continuous( density );
[ pain_scores,max_score ] = regressor_time_master( seg_lengths );


end


function [ all_pain_scores,max_score ] = pipeline_regressPainscore_t( all_start_ends,all_seg_lengths )


%[ pain_scores,max_score ] = regressor_trivial( start_ends );
all_pain_scores = [];
for i = 1:length(all_start_ends)
    seg_lengths = all_seg_lengths{i};
    [ pain_scores,max_score ] = regressor_time_continuous( seg_lengths,90 );
    all_pain_scores = [all_pain_scores,{pain_scores}];
end
end


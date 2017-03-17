function [ all_pain_scores,max_score ] = pipeline_regressPainscore_t( all_start_ends,all_seg_lengths,all_densities,all_mins )


%[ pain_scores,max_score ] = regressor_trivial( start_ends );
all_pain_scores = [];
for i = 1:length(all_seg_lengths)
    
    lengths = all_seg_lengths{i};
    [ pain_scores,max_score ] = regressor_time_master( lengths );
    
    %mins = all_mins{i};
    %[ pain_scores,max_score ] = regressor_min_master( mins );
    all_pain_scores = [all_pain_scores,{pain_scores}];
end
end


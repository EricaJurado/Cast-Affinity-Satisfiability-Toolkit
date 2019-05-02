character(mario).
character(bowser).
character(1..6).

%specify facet details about characters
level(modesty, mario, 2).
level(assertiveness, mario, 7).
level(impulsivenss, mario, 6).

%specify interest details about characters
level(kidnapping_princesses, mario, 1).
level(kidnapping_princesses, bowser, 9).
level(plumbing, mario, 9).
level(plumbing, 2, 7).

%specify similarity levels
pair_facet_similarity(mario, bowser, -2). 

%make exactly 4 characters have at least a slight preference for kidnapping princesses
%can effectively ensure we have an equal number of "bad" and "good" characters
match_n_attribute_level_min(4,kidnapping_princesses,7).
match_n_attribute_level_max(4,kidnapping_princesses,4).

%min_n_min_sim(10, 4).
%min_n_max_sim(10, -3).


character(mario).
character(luigi).
character(petey_piranha).
character(bowser).
character(yoshi).
character(wario).


%specify facet details about characters
%level(modesty, mario, 2).
level(assertiveness, mario, 7).
level(impulsivenss, mario, 6).

%specify interest details about characters
level(kidnapping_princesses, mario, 1).
level(kidnapping_princesses, wario, 9).
level(kidnapping_princesses, bowser, 9).
level(plumbing, mario, 9).
level(plumbing, wario, 8).

%specify similarity levels
pair_facet_similarity(mario, luigi, 2). 

pair_interest_similarity(mario, luigi, 2). 

%match_n_facet_level_match(6,modesty,9).
min_n_facet_level_match(3,modesty,3).

%problem instance

%human(mom).
human(amelia).
human(lauren).
human(charolette).
human(mollie).
human(katrina).
%human(george).
%human(carl).
%human(joel).
%human(stevie).
%human(jason).
%human(curtis).

%pair_affinity(amelia, mom, 5).
%pair_affinity(mom, amelia, 5).

%pair_similarity(amelia, mom, 5).
%pair_similarity(mom, amelia, 5).
 
level(shy, amelia, 8).
level(calm, amelia, 6).
level(sports, amelia, 3).
level(crafts, amelia, 8).
level(videogames, amelia, 7).

%char_x_min_n_min_sim(amelia, 1, 4).
%char_x_min_n_max_sim(amelia, 1, -3).

char_x_min_n_min_aff(amelia, 2, 4).
char_x_min_n_max_aff(amelia, 2, -3).





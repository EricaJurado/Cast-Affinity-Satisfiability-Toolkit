# Character Personality Generation

## generating code
To create facet files, delete everything in the generated folder. Then,
type: `python3 facet_file_generator.py`
and follow the prompts to specify the facets you want. 

## running the constraint solver
To run the constraint solver, in the generated directory,
run the following command: `clingo 1 *`

## adding constraints to the problem instance
Adding the following code snippets to similarity_instance.lp will have these
corresponding effects:

`match_n_match_sim(N,S).` Will ensure exactly N pairs of carachters have a pair 
similarity value of exactly S.

`min_n_match_sim` Will ensure at least N pairs of carachters have a pair 
similarity value of exactly S.

`max_n_match_sim` Will ensure at most N pairs of carachters have a pair 
similarity value of exactly S.

`match_n_min_sim(N,S).` Will ensure exactly N pairs of carachters have a pair
similarity value of at least S.

`match_n_max_sim(N,S).` Will ensure exactly N pairs of carachters have a pair
similarity value of at most S.

`min_n_min_sim(N,S).` Will ensure at least N pairs of carachters have a pair
similarity value of at least S.

`max_n_min_sim(N,S).` Will ensure at most N pairs of carachters have a pair
similarity value of at least S.

`min_n_max_sim(N,S).` Will ensure at least N pairs of carachters have a pair
similarity value of at most S.

`max_n_max_sim(N,S).` Will ensure at most N pairs of carachters have a pair
similarity value of at most S.



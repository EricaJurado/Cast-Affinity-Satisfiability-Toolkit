#const high=1.
#const neutral=0.
#const low=-1.

1{pair_similarity(A,B,X) : similarity(X)}1:- character(A), character(B), A!=B.
1{pair_facet_similarity(A,B,X) : facet_similarity(X)}1:- character(A), character(B), A!=B.
1{pair_interest_similarity(A,B,X) : interest_similarity(X)}1:- character(A), character(B), A!=B.

:-character(A), character(B), similarity(T1), similarity(T2),
	pair_similarity(A, B, T1), 
	pair_similarity(B, A, T2),
	T1!=T2. 

:-character(A), character(B), facet_similarity(T1), facet_similarity(T2),
	pair_facet_similarity(A, B, T1), 
	pair_facet_similarity(B, A, T2),
	T1!=T2. 

:-character(A), character(B), interest_similarity(T1), interest_similarity(T2),
	pair_interest_similarity(A, B, T1), 
	pair_interest_similarity(B, A, T2),
	T1!=T2. 

%rule for specific char matching
:-char_x_min_n_min_sim(X,N,S), not N{pair_similarity(X,Y,Z) : character(X), character(Y), X!=Y, Z >= S}chars. 

:-char_x_min_n_max_sim(X,N,S), not N{pair_similarity(X,Y,Z) : character(X), character(Y), X!=Y, Z <= S}chars. 

:-char_x_min_n_min_aff(X,N,S), not N{pair_affinity(X,Y,Z) : character(X), character(Y), X!=Y, Z >= S}chars. 

:-char_x_min_n_max_aff(X,N,S), not N{pair_affinity(X,Y,Z) : character(X), character(Y), X!=Y, Z <= S}chars. 

% TODO add the others

%facet matching
:-match_n_attribute_level_match(N,F,L), not N{level(F,H,L) : character(H), facet(F), level_range(L)}N.

:-match_n_attribute_level_min(N,F,L), not N{level(F,H,X) : character(H), facet(F), level_range(X), X>=L}N.

:-match_n_attribute_level_max(N,F,L), not N{level(F,H,X) : character(H), facet(F), level_range(X), X<=L}N.

:-min_n_attribute_level_match(N,F,L), not N{level(F,H,L) : character(H), facet(F), level_range(L)}chars.

:-min_n_attribute_level_min(N,F,L), not N{level(F,H,X) : character(H), facet(F), level_range(X), X>=L}chars.

:-min_n_attribute_level_max(N,F,L), not N{level(F,H,X) : character(H), facet(F), level_range(X), X<=L}chars.

:-max_n_attribute_level_match(N,F,L), not -chars{level(F,H,L) : character(H), facet(F), level_range(L)}N.

:-max_n_attribute_level_min(N,F,L), not -chars{level(F,H,X) : character(H), facet(F), level_range(X), X>=L}N.

:-max_n_attribute_level_max(N,F,L), not -chars{level(F,H,X) : character(H), facet(F), level_range(X), X<=L}N.


%there are exactly N pairs of carachters who have a pair similarity value of exactly S.
:-match_n_match_sim(N, S), not 2*N{pair_similarity(X,Y,S) : character(X), character(Y), X!=Y}2*N. 

%there are at least N pairs of carachters who have a pair similarity value of exactly S.
:-min_n_match_sim(N, S), not 2*N{pair_similarity(X,Y,S) : character(X), character(Y), X!=Y}2*chars. 

%there are at most N pairs of carachters who have a pair similarity value of exactly S.
:-max_n_match_sim(N, S), not -2*chars{pair_similarity(X,Y,S) : character(X), character(Y), X!=Y}2*N. 

%there are exactly N pairs of carachters who have a pair similarity value of at least S.
:-match_n_min_sim(N, S), not 2*N{pair_similarity(X,Y,Z) : character(X), character(Y), X!=Y, Z >= S}2*N. 

%there are exactly N pairs of carachters who have a pair similarity value of at most S.
:-match_n_max_sim(N, S), not 2*N{pair_similarity(X,Y,Z) : character(X), character(Y), X!=Y, Z <= S}2*N. 

%there are at least N pairs of carachters who have a pair similarity value of at least S.
:-min_n_min_sim(N, S), not 2*N{pair_similarity(X,Y,Z) : character(X), character(Y), X!=Y, Z >= S}2*chars. 

%there are at most N pairs of carachters who have a pair similarity value of at least S.
:-max_n_min_sim(N, S), not -2*chars{pair_similarity(X,Y,Z) : character(X), character(Y), X!=Y, Z >= S}2*N. 

%there are at least N pairs of carachters who have a pair similarity value of at most S.
:-min_n_max_sim(N, S), not 2*N{pair_similarity(X,Y,Z) : character(X), character(Y), X!=Y, Z <= S}2*chars. 

%there are at most N pairs of carachters who have a pair similarity value of at most S.
:-max_n_max_sim(N, S), not -2*chars{pair_similarity(X,Y,Z) : character(X), character(Y), X!=Y, Z <= S}2*N. 


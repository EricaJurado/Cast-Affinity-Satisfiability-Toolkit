#const high=1.
#const neutral=0.
#const low=-1.

1{pair_similarity(A,B,X) : similarity(X)}1:- human(A), human(B), A!=B.

:-human(A), human(B), similarity(T1), similarity(T2),
	pair_similarity(A, B, T1), 
	pair_similarity(B, A, T2),
	T1!=T2. 

%there are exactly N pairs of carachters who have a pair similarity value of exactly S.
:-match_n_match_sim(N, S), not 2*N{pair_similarity(X,Y,S) : human(X), human(Y), X!=Y}2*N. 

%there are at least N pairs of carachters who have a pair similarity value of exactly S.
:-min_n_match_sim(N, S), not 2*N{pair_similarity(X,Y,S) : human(X), human(Y), X!=Y}2*chars. 

%there are at most N pairs of carachters who have a pair similarity value of exactly S.
:-max_n_match_sim(N, S), not -2*chars{pair_similarity(X,Y,S) : human(X), human(Y), X!=Y}2*N. 

%there are exactly N pairs of carachters who have a pair similarity value of at least S.
:-match_n_min_sim(N, S), not 2*N{pair_similarity(X,Y,Z) : human(X), human(Y), X!=Y, Z >= S}2*N. 

%there are exactly N pairs of carachters who have a pair similarity value of at most S.
:-match_n_max_sim(N, S), not 2*N{pair_similarity(X,Y,Z) : human(X), human(Y), X!=Y, Z <= S}2*N. 

%there are at least N pairs of carachters who have a pair similarity value of at least S.
:-min_n_min_sim(N, S), not 2*N{pair_similarity(X,Y,Z) : human(X), human(Y), X!=Y, Z >= S}2*chars. 

%there are at most N pairs of carachters who have a pair similarity value of at least S.
:-max_n_min_sim(N, S), not -2*chars{pair_similarity(X,Y,Z) : human(X), human(Y), X!=Y, Z >= S}2*N. 

%there are at least N pairs of carachters who have a pair similarity value of at most S.
:-min_n_max_sim(N, S), not 2*N{pair_similarity(X,Y,Z) : human(X), human(Y), X!=Y, Z <= S}2*chars. 

%there are at most N pairs of carachters who have a pair similarity value of at most S.
:-max_n_max_sim(N, S), not -2*chars{pair_similarity(X,Y,Z) : human(X), human(Y), X!=Y, Z <= S}2*N. 


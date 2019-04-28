#const max = 2.
#const chars = 5.
similarity(-2..2).

:-pair_similarity(A, B, T), human(A), human(B), similarity(T),
	sim(,A,B,E1),
	sim(,A,B,E2),
	E1+E2!=T.
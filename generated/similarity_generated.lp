#const max = 5.
#const chars = 5.
similarity(-5..5).

:-pair_similarity(A, B, T), human(A), human(B), similarity(T),
	sim(shy,A,B,E1),
	sim(calm,A,B,E2),
	sim(videogames,A,B,E3),
	sim(sports,A,B,E4),
	sim(crafts,A,B,E5),
	E1+E2+E3+E4+E5!=T.
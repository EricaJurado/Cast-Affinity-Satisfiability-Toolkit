#const max = 6.
#const chars = 12.
similarity(-6..6).

:-pair_similarity(A, B, T), human(A), human(B), similarity(T),
	assertiveness_sim(A,B,E1),
	gregariousness_sim(A,B,E2),
	warmth_sim(A,B,E3),
	straightforwardness_sim(A,B,E4),
	compliance_sim(A,B,E5),
	tendermindedness_sim(A,B,E6),
	E1+E2+E3+E4+E5+E6!=T.
#const max = 5.#const chars = 3.similarity(-5..5).

:-pair_similarity(A, B, T), human(A), human(B), similarity(T),
	warmth_sim(A,B,E1),
	gregariousness_sim(A,B,E2),
	feelings_sim(A,B,E3),
	compliance_sim(A,B,E4),
	tenderness_sim(A,B,E5),
	E1+E2+E3+E4+E5!=T.
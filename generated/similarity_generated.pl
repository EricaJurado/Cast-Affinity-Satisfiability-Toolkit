#const high=1.
#const neutral=0.
#const low=-1.

similarity(-5..5).

1{pair_similarity(A,B,X) : similarity(X)}1:- human(A), human(B), A!=B.

:-pair_similarity(A, B, T), human(A), human(B), similarity(T),
	feelings_sim(A,B,E1),
	gregariousness_sim(A,B,E2),
	warmth_sim(A,B,E3),
	tenderness_sim(A,B,E4),
	compliance_sim(A,B,E5),
	E1+E2+E3+E4+E5!=T.
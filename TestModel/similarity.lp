#const high=1.
#const neutral=0.
#const low=-1.

similarity(-2..2).

1{pair_similarity(A,B,X) : similarity(X)}1:- human(A), human(B), A!=B.

:-pair_similarity(A,B,T), human(A), human(B), similarity(T),
			extra_sim(A,B,E), neuro_sim(A,B,N),
			E+N==-2.




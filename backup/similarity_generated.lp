#const max = 15.
#const chars = 12.
similarity(-15..15).

:-pair_similarity(A, B, T), human(A), human(B), similarity(T),
	assertiveness_sim(A,B,E1),
	gregariousness_sim(A,B,E2),
	warmth_sim(A,B,E3),
	straightforwardness_sim(A,B,E4),
	compliance_sim(A,B,E5),
	tendermindedness_sim(A,B,E6),
	compliance_sim(A,B,E7),
	achievementstriving_sim(A,B,E8),
	deliberation_sim(A,B,E9),
	feelings_sim(A,B,E10),
	actions_sim(A,B,E11),
	values_sim(A,B,E12),
	impulsiveness_sim(A,B,E13),
	selfconsiousness_sim(A,B,E14),
	vulnerability_sim(A,B,E15),
	E1+E2+E3+E4+E5+E6+E7+E8+E9+E10+E11+E12+E13+E14+E15!=T.

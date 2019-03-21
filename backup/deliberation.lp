#const deliberation_high_level=2.
#const deliberation_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(deliberation).

deliberation(1..10).

status(deliberation, high).
status(deliberation, neutral).
status(deliberation, low).

%% Generate/Assign

%every human get an deliberation value
1{level(deliberation,H,X) : deliberation(X)}1:- human(H).

%every pair of humans gets a deliberation similarity level
1{deliberation_sim(A,B,X) : status(deliberation, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high deliberation_sim if deliberation difference is within some bound
:-deliberation_sim(A,B,high), human(A), human(B), A != B, 
		level(deliberation,A,X), level(deliberation,B,Y),
		deliberation(X), deliberation(Y), |X-Y| > deliberation_high_level.

% low deliberation_sim if deliberation difference is beyond some bound
:-deliberation_sim(A,B,low), human(A), human(B), A != B, 
		level(deliberation,A,X), level(deliberation,B,Y),
		deliberation(X), deliberation(Y), |X-Y| < deliberation_low_level.

% neutral deliberation_sim if not similar or opposite 
:-deliberation_sim(A,B,neutral), human(A), human(B), A != B, 
		level(deliberation,A,X), level(deliberation,B,Y),
		deliberation(X), deliberation(Y), |X-Y| <= deliberation_high_level.

:-deliberation_sim(A,B,neutral), human(A), human(B), A != B, 
		level(deliberation,A,X), level(deliberation,B,Y),
		deliberation(X), deliberation(Y), |X-Y| >= deliberation_low_level.



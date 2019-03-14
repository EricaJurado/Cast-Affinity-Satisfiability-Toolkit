#const warmth_high_level=2.
#const warmth_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(warmth).

warmth(1..10).

status(warmth, high).
status(warmth, neutral).
status(warmth, low).

%% Generate/Assign

%every human get an warmth value
1{level(warmth,H,X) : warmth(X)}1:- human(H).

%every pair of humans gets a warmth similarity level
1{warmth_sim(A,B,X) : status(warmth, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high warmth_sim if warmth difference is within some bound
:-warmth_sim(A,B,high), human(A), human(B), A != B, 
		level(warmth,A,X), level(warmth,B,Y),
		warmth(X), warmth(Y), |X-Y| > warmth_high_level.

% low warmth_sim if warmth difference is beyond some bound
:-warmth_sim(A,B,low), human(A), human(B), A != B, 
		warmth_level(A,X), level(warmth,B,Y),
		warmth(X), warmth(Y), |X-Y| < warmth_low_level.

% neutral warmth_sim if not similar or opposite 
:-warmth_sim(A,B,neutral), human(A), human(B), A != B, 
		level(warmth,A,X), level(warmth,B,Y),
		warmth(X), warmth(Y), |X-Y| <= warmth_high_level.

:-warmth_sim(A,B,neutral), human(A), human(B), A != B, 
		warmth_level(A,X), level(warmth,B,Y),
		warmth(X), warmth(Y), |X-Y| >= warmth_low_level.



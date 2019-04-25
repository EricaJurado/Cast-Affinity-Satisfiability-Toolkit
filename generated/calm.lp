#const calm_high_level=2.
#const calm_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(calm).

calm(1..10).

status(calm, high).
status(calm, neutral).
status(calm, low).

%% Generate/Assign

%every human get an calm value
1{level(calm,H,X) : calm(X)}1:- human(H).

%every pair of humans gets a calm similarity level
1{sim(calm,A,B,X) : status(calm, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high calm_sim if calm difference is within some bound
:-sim(calm,A,B,high), human(A), human(B), A != B, 
		level(calm,A,X), level(calm,B,Y),
		calm(X), calm(Y), |X-Y| > calm_high_level.

% low calm_sim if calm difference is beyond some bound
:-sim(calm,A,B,low), human(A), human(B), A != B, 
		level(calm,A,X), level(calm,B,Y),
		calm(X), calm(Y), |X-Y| < calm_low_level.

% neutral calm_sim if not similar or opposite 
:-sim(calm,A,B,neutral), human(A), human(B), A != B, 
		level(calm,A,X), level(calm,B,Y),
		calm(X), calm(Y), |X-Y| <= calm_high_level.

:-sim(calm,A,B,neutral), human(A), human(B), A != B, 
		level(calm,A,X), level(calm,B,Y),
		calm(X), calm(Y), |X-Y| >= calm_low_level.



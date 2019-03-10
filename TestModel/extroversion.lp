#const extra_high_level=2.
#const extra_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.

%% Generation, non-instance domains

extra(1..10).

extra_status(high).
extra_status(neutral).
extra_status(low).

%% Generate/Assign

%every human get an extraversion value
1{extra_level(H,X) : extra(X)}1:- human(H).

%every pair of humans gets a extroversion similarity level
1{extra_sim(A,B,X) : extra_status(X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high extra_sim if extraversion difference is within some bound
:-extra_sim(A,B,high), human(A), human(B), A != B, 
		extra_level(A,X), extra_level(B,Y),
		extra(X), extra(Y), |X-Y| > extra_high_level.

% low extra_sim if extraversion difference is beyond some bound
:-extra_sim(A,B,low), human(A), human(B), A != B, 
		extra_level(A,X), extra_level(B,Y),
		extra(X), extra(Y), |X-Y| < extra_low_level.

% neutral extra_sim if not similar or opposite 
:-extra_sim(A,B,neutral), human(A), human(B), A != B, 
		extra_level(A,X), extra_level(B,Y),
		extra(X), extra(Y), |X-Y| <= extra_high_level.

:-extra_sim(A,B,neutral), human(A), human(B), A != B, 
		extra_level(A,X), extra_level(B,Y),
		extra(X), extra(Y), |X-Y| >= extra_low_level.



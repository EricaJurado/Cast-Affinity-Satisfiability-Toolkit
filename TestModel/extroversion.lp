#show extra_level/2.
#show extra_compat/3.
#const extra_high_level=2.
#const extra_low_level=5.

%% Generation, non-instance domains

extra(1..10).

extra_status(high).
extra_status(neutral).
extra_status(low).

%% Generate/Assign

%every human get an extraversion value
1{extra_level(H,X) : extra(X)}1:- human(H).

%every pair of humans gets a friendship status
1{extra_compat(A,B,X) : extra_status(X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high extra_compat if extraversion difference is within some bound
:-extra_compat(A,B,high), human(A), human(B), A != B, 
		extra_level(A,X), extra_level(B,Y),
		extra(X), extra(Y), |X-Y| > extra_high_level.

% low extra_compat if extraversion difference is beyond some bound
:-extra_compat(A,B,low), human(A), human(B), A != B, 
		extra_level(A,X), extra_level(B,Y),
		extra(X), extra(Y), |X-Y| < extra_low_level.

% neutral extra_compat if not friends and not enemies
:-extra_compat(A,B,neutral), human(A), human(B), A != B, 
		extra_level(A,X), extra_level(B,Y),
		extra(X), extra(Y), |X-Y| <= extra_high_level.

:-extra_compat(A,B,neutral), human(A), human(B), A != B, 
		extra_level(A,X), extra_level(B,Y),
		extra(X), extra(Y), |X-Y| >= extra_low_level.



#const sports_high_level=2.
#const sports_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(sports).

sports(1..10).

status(sports, high).
status(sports, neutral).
status(sports, low).

%% Generate/Assign

%every human get an sports value
1{level(sports,H,X) : sports(X)}1:- human(H).

%every pair of humans gets a sports similarity level
1{sim(sports,A,B,X) : status(sports, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high sports_sim if sports difference is within some bound
:-sim(sports,A,B,high), human(A), human(B), A != B, 
		level(sports,A,X), level(sports,B,Y),
		sports(X), sports(Y), |X-Y| > sports_high_level.

% low sports_sim if sports difference is beyond some bound
:-sim(sports,A,B,low), human(A), human(B), A != B, 
		level(sports,A,X), level(sports,B,Y),
		sports(X), sports(Y), |X-Y| < sports_low_level.

% neutral sports_sim if not similar or opposite 
:-sim(sports,A,B,neutral), human(A), human(B), A != B, 
		level(sports,A,X), level(sports,B,Y),
		sports(X), sports(Y), |X-Y| <= sports_high_level.

:-sim(sports,A,B,neutral), human(A), human(B), A != B, 
		level(sports,A,X), level(sports,B,Y),
		sports(X), sports(Y), |X-Y| >= sports_low_level.



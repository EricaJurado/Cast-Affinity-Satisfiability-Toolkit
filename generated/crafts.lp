#const crafts_high_level=2.
#const crafts_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(crafts).

crafts(1..10).

status(crafts, high).
status(crafts, neutral).
status(crafts, low).

%% Generate/Assign

%every human get an crafts value
1{level(crafts,H,X) : crafts(X)}1:- human(H).

%every pair of humans gets a crafts similarity level
1{sim(crafts,A,B,X) : status(crafts, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high crafts_sim if crafts difference is within some bound
:-sim(crafts,A,B,high), human(A), human(B), A != B, 
		level(crafts,A,X), level(crafts,B,Y),
		crafts(X), crafts(Y), |X-Y| > crafts_high_level.

% low crafts_sim if crafts difference is beyond some bound
:-sim(crafts,A,B,low), human(A), human(B), A != B, 
		level(crafts,A,X), level(crafts,B,Y),
		crafts(X), crafts(Y), |X-Y| < crafts_low_level.

% neutral crafts_sim if not similar or opposite 
:-sim(crafts,A,B,neutral), human(A), human(B), A != B, 
		level(crafts,A,X), level(crafts,B,Y),
		crafts(X), crafts(Y), |X-Y| <= crafts_high_level.

:-sim(crafts,A,B,neutral), human(A), human(B), A != B, 
		level(crafts,A,X), level(crafts,B,Y),
		crafts(X), crafts(Y), |X-Y| >= crafts_low_level.



#const feelings_high_level=2.
#const feelings_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(feelings).

feelings(1..10).

status(feelings, high).
status(feelings, neutral).
status(feelings, low).

%% Generate/Assign

%every human get an feelings value
1{level(feelings,H,X) : feelings(X)}1:- human(H).

%every pair of humans gets a feelings similarity level
1{feelings_sim(A,B,X) : status(feelings, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high feelings_sim if feelings difference is within some bound
:-feelings_sim(A,B,high), human(A), human(B), A != B, 
		level(feelings,A,X), level(feelings,B,Y),
		feelings(X), feelings(Y), |X-Y| > feelings_high_level.

% low feelings_sim if feelings difference is beyond some bound
:-feelings_sim(A,B,low), human(A), human(B), A != B, 
		feelings_level(A,X), level(feelings,B,Y),
		feelings(X), feelings(Y), |X-Y| < feelings_low_level.

% neutral feelings_sim if not similar or opposite 
:-feelings_sim(A,B,neutral), human(A), human(B), A != B, 
		level(feelings,A,X), level(feelings,B,Y),
		feelings(X), feelings(Y), |X-Y| <= feelings_high_level.

:-feelings_sim(A,B,neutral), human(A), human(B), A != B, 
		feelings_level(A,X), level(feelings,B,Y),
		feelings(X), feelings(Y), |X-Y| >= feelings_low_level.



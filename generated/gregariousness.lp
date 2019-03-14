#const gregariousness_high_level=2.
#const gregariousness_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(gregariousness).

gregariousness(1..10).

status(gregariousness, high).
status(gregariousness, neutral).
status(gregariousness, low).

%% Generate/Assign

%every human get an gregariousness value
1{level(gregariousness,H,X) : gregariousness(X)}1:- human(H).

%every pair of humans gets a gregariousness similarity level
1{gregariousness_sim(A,B,X) : status(gregariousness, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high gregariousness_sim if gregariousness difference is within some bound
:-gregariousness_sim(A,B,high), human(A), human(B), A != B, 
		level(gregariousness,A,X), level(gregariousness,B,Y),
		gregariousness(X), gregariousness(Y), |X-Y| > gregariousness_high_level.

% low gregariousness_sim if gregariousness difference is beyond some bound
:-gregariousness_sim(A,B,low), human(A), human(B), A != B, 
		gregariousness_level(A,X), level(gregariousness,B,Y),
		gregariousness(X), gregariousness(Y), |X-Y| < gregariousness_low_level.

% neutral gregariousness_sim if not similar or opposite 
:-gregariousness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(gregariousness,A,X), level(gregariousness,B,Y),
		gregariousness(X), gregariousness(Y), |X-Y| <= gregariousness_high_level.

:-gregariousness_sim(A,B,neutral), human(A), human(B), A != B, 
		gregariousness_level(A,X), level(gregariousness,B,Y),
		gregariousness(X), gregariousness(Y), |X-Y| >= gregariousness_low_level.



#const shy_high_level=2.
#const shy_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(shy).

shy(1..10).

status(shy, high).
status(shy, neutral).
status(shy, low).

%% Generate/Assign

%every human get an shy value
1{level(shy,H,X) : shy(X)}1:- human(H).

%every pair of humans gets a shy similarity level
1{sim(shy,A,B,X) : status(shy, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high shy_sim if shy difference is within some bound
:-sim(shy,A,B,high), human(A), human(B), A != B, 
		level(shy,A,X), level(shy,B,Y),
		shy(X), shy(Y), |X-Y| > shy_high_level.

% low shy_sim if shy difference is beyond some bound
:-sim(shy,A,B,low), human(A), human(B), A != B, 
		level(shy,A,X), level(shy,B,Y),
		shy(X), shy(Y), |X-Y| < shy_low_level.

% neutral shy_sim if not similar or opposite 
:-sim(shy,A,B,neutral), human(A), human(B), A != B, 
		level(shy,A,X), level(shy,B,Y),
		shy(X), shy(Y), |X-Y| <= shy_high_level.

:-sim(shy,A,B,neutral), human(A), human(B), A != B, 
		level(shy,A,X), level(shy,B,Y),
		shy(X), shy(Y), |X-Y| >= shy_low_level.



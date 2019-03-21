#const selfconsiousness_high_level=2.
#const selfconsiousness_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(selfconsiousness).

selfconsiousness(1..10).

status(selfconsiousness, high).
status(selfconsiousness, neutral).
status(selfconsiousness, low).

%% Generate/Assign

%every human get an selfconsiousness value
1{level(selfconsiousness,H,X) : selfconsiousness(X)}1:- human(H).

%every pair of humans gets a selfconsiousness similarity level
1{selfconsiousness_sim(A,B,X) : status(selfconsiousness, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high selfconsiousness_sim if selfconsiousness difference is within some bound
:-selfconsiousness_sim(A,B,high), human(A), human(B), A != B, 
		level(selfconsiousness,A,X), level(selfconsiousness,B,Y),
		selfconsiousness(X), selfconsiousness(Y), |X-Y| > selfconsiousness_high_level.

% low selfconsiousness_sim if selfconsiousness difference is beyond some bound
:-selfconsiousness_sim(A,B,low), human(A), human(B), A != B, 
		level(selfconsiousness,A,X), level(selfconsiousness,B,Y),
		selfconsiousness(X), selfconsiousness(Y), |X-Y| < selfconsiousness_low_level.

% neutral selfconsiousness_sim if not similar or opposite 
:-selfconsiousness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(selfconsiousness,A,X), level(selfconsiousness,B,Y),
		selfconsiousness(X), selfconsiousness(Y), |X-Y| <= selfconsiousness_high_level.

:-selfconsiousness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(selfconsiousness,A,X), level(selfconsiousness,B,Y),
		selfconsiousness(X), selfconsiousness(Y), |X-Y| >= selfconsiousness_low_level.



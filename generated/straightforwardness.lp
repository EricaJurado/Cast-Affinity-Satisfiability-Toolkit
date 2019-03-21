#const straightforwardness_high_level=2.
#const straightforwardness_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(straightforwardness).

straightforwardness(1..10).

status(straightforwardness, high).
status(straightforwardness, neutral).
status(straightforwardness, low).

%% Generate/Assign

%every human get an straightforwardness value
1{level(straightforwardness,H,X) : straightforwardness(X)}1:- human(H).

%every pair of humans gets a straightforwardness similarity level
1{straightforwardness_sim(A,B,X) : status(straightforwardness, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high straightforwardness_sim if straightforwardness difference is within some bound
:-straightforwardness_sim(A,B,high), human(A), human(B), A != B, 
		level(straightforwardness,A,X), level(straightforwardness,B,Y),
		straightforwardness(X), straightforwardness(Y), |X-Y| > straightforwardness_high_level.

% low straightforwardness_sim if straightforwardness difference is beyond some bound
:-straightforwardness_sim(A,B,low), human(A), human(B), A != B, 
		level(straightforwardness,A,X), level(straightforwardness,B,Y),
		straightforwardness(X), straightforwardness(Y), |X-Y| < straightforwardness_low_level.

% neutral straightforwardness_sim if not similar or opposite 
:-straightforwardness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(straightforwardness,A,X), level(straightforwardness,B,Y),
		straightforwardness(X), straightforwardness(Y), |X-Y| <= straightforwardness_high_level.

:-straightforwardness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(straightforwardness,A,X), level(straightforwardness,B,Y),
		straightforwardness(X), straightforwardness(Y), |X-Y| >= straightforwardness_low_level.



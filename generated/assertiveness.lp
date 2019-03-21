#const assertiveness_high_level=2.
#const assertiveness_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(assertiveness).

assertiveness(1..10).

status(assertiveness, high).
status(assertiveness, neutral).
status(assertiveness, low).

%% Generate/Assign

%every human get an assertiveness value
1{level(assertiveness,H,X) : assertiveness(X)}1:- human(H).

%every pair of humans gets a assertiveness similarity level
1{assertiveness_sim(A,B,X) : status(assertiveness, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high assertiveness_sim if assertiveness difference is within some bound
:-assertiveness_sim(A,B,high), human(A), human(B), A != B, 
		level(assertiveness,A,X), level(assertiveness,B,Y),
		assertiveness(X), assertiveness(Y), |X-Y| > assertiveness_high_level.

% low assertiveness_sim if assertiveness difference is beyond some bound
:-assertiveness_sim(A,B,low), human(A), human(B), A != B, 
		level(assertiveness,A,X), level(assertiveness,B,Y),
		assertiveness(X), assertiveness(Y), |X-Y| < assertiveness_low_level.

% neutral assertiveness_sim if not similar or opposite 
:-assertiveness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(assertiveness,A,X), level(assertiveness,B,Y),
		assertiveness(X), assertiveness(Y), |X-Y| <= assertiveness_high_level.

:-assertiveness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(assertiveness,A,X), level(assertiveness,B,Y),
		assertiveness(X), assertiveness(Y), |X-Y| >= assertiveness_low_level.



#const values_high_level=2.
#const values_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(values).

values(1..10).

status(values, high).
status(values, neutral).
status(values, low).

%% Generate/Assign

%every human get an values value
1{level(values,H,X) : values(X)}1:- human(H).

%every pair of humans gets a values similarity level
1{values_sim(A,B,X) : status(values, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high values_sim if values difference is within some bound
:-values_sim(A,B,high), human(A), human(B), A != B, 
		level(values,A,X), level(values,B,Y),
		values(X), values(Y), |X-Y| > values_high_level.

% low values_sim if values difference is beyond some bound
:-values_sim(A,B,low), human(A), human(B), A != B, 
		level(values,A,X), level(values,B,Y),
		values(X), values(Y), |X-Y| < values_low_level.

% neutral values_sim if not similar or opposite 
:-values_sim(A,B,neutral), human(A), human(B), A != B, 
		level(values,A,X), level(values,B,Y),
		values(X), values(Y), |X-Y| <= values_high_level.

:-values_sim(A,B,neutral), human(A), human(B), A != B, 
		level(values,A,X), level(values,B,Y),
		values(X), values(Y), |X-Y| >= values_low_level.



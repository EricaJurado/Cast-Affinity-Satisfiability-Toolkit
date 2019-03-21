#const tendermindedness_high_level=2.
#const tendermindedness_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(tendermindedness).

tendermindedness(1..10).

status(tendermindedness, high).
status(tendermindedness, neutral).
status(tendermindedness, low).

%% Generate/Assign

%every human get an tendermindedness value
1{level(tendermindedness,H,X) : tendermindedness(X)}1:- human(H).

%every pair of humans gets a tendermindedness similarity level
1{tendermindedness_sim(A,B,X) : status(tendermindedness, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high tendermindedness_sim if tendermindedness difference is within some bound
:-tendermindedness_sim(A,B,high), human(A), human(B), A != B, 
		level(tendermindedness,A,X), level(tendermindedness,B,Y),
		tendermindedness(X), tendermindedness(Y), |X-Y| > tendermindedness_high_level.

% low tendermindedness_sim if tendermindedness difference is beyond some bound
:-tendermindedness_sim(A,B,low), human(A), human(B), A != B, 
		level(tendermindedness,A,X), level(tendermindedness,B,Y),
		tendermindedness(X), tendermindedness(Y), |X-Y| < tendermindedness_low_level.

% neutral tendermindedness_sim if not similar or opposite 
:-tendermindedness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(tendermindedness,A,X), level(tendermindedness,B,Y),
		tendermindedness(X), tendermindedness(Y), |X-Y| <= tendermindedness_high_level.

:-tendermindedness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(tendermindedness,A,X), level(tendermindedness,B,Y),
		tendermindedness(X), tendermindedness(Y), |X-Y| >= tendermindedness_low_level.



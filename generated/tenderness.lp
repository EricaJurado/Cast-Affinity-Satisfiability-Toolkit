#const tenderness_high_level=2.
#const tenderness_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

tenderness(1..10).

tenderness_status(high).
tenderness_status(neutral).
tenderness_status(low).

%% Generate/Assign

%every human get an tenderness value
1{tenderness_level(H,X) : tenderness(X)}1:- human(H).

%every pair of humans gets a extroversion similarity level
1{tenderness_sim(A,B,X) : tenderness_status(X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high tenderness_sim if tenderness difference is within some bound
:-tenderness_sim(A,B,high), human(A), human(B), A != B, 
		tenderness_level(A,X), tenderness_level(B,Y),
		tenderness(X), tenderness(Y), |X-Y| > tenderness_high_level.

% low tenderness_sim if tenderness difference is beyond some bound
:-tenderness_sim(A,B,low), human(A), human(B), A != B, 
		tenderness_level(A,X), tenderness_level(B,Y),
		tenderness(X), tenderness(Y), |X-Y| < tenderness_low_level.

% neutral tenderness_sim if not similar or opposite 
:-tenderness_sim(A,B,neutral), human(A), human(B), A != B, 
		tenderness_level(A,X), tenderness_level(B,Y),
		tenderness(X), tenderness(Y), |X-Y| <= tenderness_high_level.

:-tenderness_sim(A,B,neutral), human(A), human(B), A != B, 
		tenderness_level(A,X), tenderness_level(B,Y),
		tenderness(X), tenderness(Y), |X-Y| >= tenderness_low_level.



#const impulsiveness_high_level=2.
#const impulsiveness_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(impulsiveness).

impulsiveness(1..10).

status(impulsiveness, high).
status(impulsiveness, neutral).
status(impulsiveness, low).

%% Generate/Assign

%every human get an impulsiveness value
1{level(impulsiveness,H,X) : impulsiveness(X)}1:- human(H).

%every pair of humans gets a impulsiveness similarity level
1{impulsiveness_sim(A,B,X) : status(impulsiveness, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high impulsiveness_sim if impulsiveness difference is within some bound
:-impulsiveness_sim(A,B,high), human(A), human(B), A != B, 
		level(impulsiveness,A,X), level(impulsiveness,B,Y),
		impulsiveness(X), impulsiveness(Y), |X-Y| > impulsiveness_high_level.

% low impulsiveness_sim if impulsiveness difference is beyond some bound
:-impulsiveness_sim(A,B,low), human(A), human(B), A != B, 
		level(impulsiveness,A,X), level(impulsiveness,B,Y),
		impulsiveness(X), impulsiveness(Y), |X-Y| < impulsiveness_low_level.

% neutral impulsiveness_sim if not similar or opposite 
:-impulsiveness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(impulsiveness,A,X), level(impulsiveness,B,Y),
		impulsiveness(X), impulsiveness(Y), |X-Y| <= impulsiveness_high_level.

:-impulsiveness_sim(A,B,neutral), human(A), human(B), A != B, 
		level(impulsiveness,A,X), level(impulsiveness,B,Y),
		impulsiveness(X), impulsiveness(Y), |X-Y| >= impulsiveness_low_level.



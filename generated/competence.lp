#const competence_high_level=2.
#const competence_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(competence).

competence(1..10).

status(competence, high).
status(competence, neutral).
status(competence, low).

%% Generate/Assign

%every human get an competence value
1{level(competence,H,X) : competence(X)}1:- human(H).

%every pair of humans gets a competence similarity level
1{competence_sim(A,B,X) : status(competence, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high competence_sim if competence difference is within some bound
:-competence_sim(A,B,high), human(A), human(B), A != B, 
		level(competence,A,X), level(competence,B,Y),
		competence(X), competence(Y), |X-Y| > competence_high_level.

% low competence_sim if competence difference is beyond some bound
:-competence_sim(A,B,low), human(A), human(B), A != B, 
		level(competence,A,X), level(competence,B,Y),
		competence(X), competence(Y), |X-Y| < competence_low_level.

% neutral competence_sim if not similar or opposite 
:-competence_sim(A,B,neutral), human(A), human(B), A != B, 
		level(competence,A,X), level(competence,B,Y),
		competence(X), competence(Y), |X-Y| <= competence_high_level.

:-competence_sim(A,B,neutral), human(A), human(B), A != B, 
		level(competence,A,X), level(competence,B,Y),
		competence(X), competence(Y), |X-Y| >= competence_low_level.



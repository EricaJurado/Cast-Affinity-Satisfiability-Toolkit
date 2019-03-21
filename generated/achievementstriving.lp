#const achievementstriving_high_level=2.
#const achievementstriving_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(achievementstriving).

achievementstriving(1..10).

status(achievementstriving, high).
status(achievementstriving, neutral).
status(achievementstriving, low).

%% Generate/Assign

%every human get an achievementstriving value
1{level(achievementstriving,H,X) : achievementstriving(X)}1:- human(H).

%every pair of humans gets a achievementstriving similarity level
1{achievementstriving_sim(A,B,X) : status(achievementstriving, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high achievementstriving_sim if achievementstriving difference is within some bound
:-achievementstriving_sim(A,B,high), human(A), human(B), A != B, 
		level(achievementstriving,A,X), level(achievementstriving,B,Y),
		achievementstriving(X), achievementstriving(Y), |X-Y| > achievementstriving_high_level.

% low achievementstriving_sim if achievementstriving difference is beyond some bound
:-achievementstriving_sim(A,B,low), human(A), human(B), A != B, 
		level(achievementstriving,A,X), level(achievementstriving,B,Y),
		achievementstriving(X), achievementstriving(Y), |X-Y| < achievementstriving_low_level.

% neutral achievementstriving_sim if not similar or opposite 
:-achievementstriving_sim(A,B,neutral), human(A), human(B), A != B, 
		level(achievementstriving,A,X), level(achievementstriving,B,Y),
		achievementstriving(X), achievementstriving(Y), |X-Y| <= achievementstriving_high_level.

:-achievementstriving_sim(A,B,neutral), human(A), human(B), A != B, 
		level(achievementstriving,A,X), level(achievementstriving,B,Y),
		achievementstriving(X), achievementstriving(Y), |X-Y| >= achievementstriving_low_level.



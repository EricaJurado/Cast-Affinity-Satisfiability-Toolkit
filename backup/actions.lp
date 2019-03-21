#const actions_high_level=2.
#const actions_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(actions).

actions(1..10).

status(actions, high).
status(actions, neutral).
status(actions, low).

%% Generate/Assign

%every human get an actions value
1{level(actions,H,X) : actions(X)}1:- human(H).

%every pair of humans gets a actions similarity level
1{actions_sim(A,B,X) : status(actions, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high actions_sim if actions difference is within some bound
:-actions_sim(A,B,high), human(A), human(B), A != B, 
		level(actions,A,X), level(actions,B,Y),
		actions(X), actions(Y), |X-Y| > actions_high_level.

% low actions_sim if actions difference is beyond some bound
:-actions_sim(A,B,low), human(A), human(B), A != B, 
		level(actions,A,X), level(actions,B,Y),
		actions(X), actions(Y), |X-Y| < actions_low_level.

% neutral actions_sim if not similar or opposite 
:-actions_sim(A,B,neutral), human(A), human(B), A != B, 
		level(actions,A,X), level(actions,B,Y),
		actions(X), actions(Y), |X-Y| <= actions_high_level.

:-actions_sim(A,B,neutral), human(A), human(B), A != B, 
		level(actions,A,X), level(actions,B,Y),
		actions(X), actions(Y), |X-Y| >= actions_low_level.



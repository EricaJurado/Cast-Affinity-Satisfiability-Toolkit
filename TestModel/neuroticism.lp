#const neuro_high_level=2.
#const neuro_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

neuro(1..10).

neuro_status(high).
neuro_status(neutral).
neuro_status(low).

%% Generate/Assign

%every human get an neuroticism value
1{neuro_level(H,X) : neuro(X)}1:- human(H).

%every pair of humans gets a extroversion similarity level
1{neuro_sim(A,B,X) : neuro_status(X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high neuro_sim if neuroticism difference is within some bound
:-neuro_sim(A,B,high), human(A), human(B), A != B, 
		neuro_level(A,X), neuro_level(B,Y),
		neuro(X), neuro(Y), |X-Y| > neuro_high_level.

% low neuro_sim if neuroticism difference is beyond some bound
:-neuro_sim(A,B,low), human(A), human(B), A != B, 
		neuro_level(A,X), neuro_level(B,Y),
		neuro(X), neuro(Y), |X-Y| < neuro_low_level.

% neutral neuro_sim if not similar or opposite 
:-neuro_sim(A,B,neutral), human(A), human(B), A != B, 
		neuro_level(A,X), neuro_level(B,Y),
		neuro(X), neuro(Y), |X-Y| <= neuro_high_level.

:-neuro_sim(A,B,neutral), human(A), human(B), A != B, 
		neuro_level(A,X), neuro_level(B,Y),
		neuro(X), neuro(Y), |X-Y| >= neuro_low_level.



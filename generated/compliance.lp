#const compliance_high_level=2.
#const compliance_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

compliance(1..10).

compliance_status(high).
compliance_status(neutral).
compliance_status(low).

%% Generate/Assign

%every human get an compliance value
1{compliance_level(H,X) : compliance(X)}1:- human(H).

%every pair of humans gets a extroversion similarity level
1{compliance_sim(A,B,X) : compliance_status(X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high compliance_sim if compliance difference is within some bound
:-compliance_sim(A,B,high), human(A), human(B), A != B, 
		compliance_level(A,X), compliance_level(B,Y),
		compliance(X), compliance(Y), |X-Y| > compliance_high_level.

% low compliance_sim if compliance difference is beyond some bound
:-compliance_sim(A,B,low), human(A), human(B), A != B, 
		compliance_level(A,X), compliance_level(B,Y),
		compliance(X), compliance(Y), |X-Y| < compliance_low_level.

% neutral compliance_sim if not similar or opposite 
:-compliance_sim(A,B,neutral), human(A), human(B), A != B, 
		compliance_level(A,X), compliance_level(B,Y),
		compliance(X), compliance(Y), |X-Y| <= compliance_high_level.

:-compliance_sim(A,B,neutral), human(A), human(B), A != B, 
		compliance_level(A,X), compliance_level(B,Y),
		compliance(X), compliance(Y), |X-Y| >= compliance_low_level.



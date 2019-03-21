#const compliance_high_level=2.
#const compliance_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(compliance).

compliance(1..10).

status(compliance, high).
status(compliance, neutral).
status(compliance, low).

%% Generate/Assign

%every human get an compliance value
1{level(compliance,H,X) : compliance(X)}1:- human(H).

%every pair of humans gets a compliance similarity level
1{compliance_sim(A,B,X) : status(compliance, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high compliance_sim if compliance difference is within some bound
:-compliance_sim(A,B,high), human(A), human(B), A != B, 
		level(compliance,A,X), level(compliance,B,Y),
		compliance(X), compliance(Y), |X-Y| > compliance_high_level.

% low compliance_sim if compliance difference is beyond some bound
:-compliance_sim(A,B,low), human(A), human(B), A != B, 
		level(compliance,A,X), level(compliance,B,Y),
		compliance(X), compliance(Y), |X-Y| < compliance_low_level.

% neutral compliance_sim if not similar or opposite 
:-compliance_sim(A,B,neutral), human(A), human(B), A != B, 
		level(compliance,A,X), level(compliance,B,Y),
		compliance(X), compliance(Y), |X-Y| <= compliance_high_level.

:-compliance_sim(A,B,neutral), human(A), human(B), A != B, 
		level(compliance,A,X), level(compliance,B,Y),
		compliance(X), compliance(Y), |X-Y| >= compliance_low_level.



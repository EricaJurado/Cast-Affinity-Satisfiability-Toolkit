#const template_high_level=2.
#const template_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(template).

template(1..10).

status(template, high).
status(template, neutral).
status(template, low).

%% Generate/Assign

%every human get an template value
1{level(template,H,X) : template(X)}1:- human(H).

%every pair of humans gets a template similarity level
1{sim(template,A,B,X) : status(template, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high template_sim if template difference is within some bound
:-sim(template,A,B,high), human(A), human(B), A != B, 
		level(template,A,X), level(template,B,Y),
		template(X), template(Y), |X-Y| > template_high_level.

% low template_sim if template difference is beyond some bound
:-sim(template,A,B,low), human(A), human(B), A != B, 
		level(template,A,X), level(template,B,Y),
		template(X), template(Y), |X-Y| < template_low_level.

% neutral template_sim if not similar or opposite 
:-sim(template,A,B,neutral), human(A), human(B), A != B, 
		level(template,A,X), level(template,B,Y),
		template(X), template(Y), |X-Y| <= template_high_level.

:-sim(template,A,B,neutral), human(A), human(B), A != B, 
		level(template,A,X), level(template,B,Y),
		template(X), template(Y), |X-Y| >= template_low_level.



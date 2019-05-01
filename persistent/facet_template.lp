%% Generation, non-instance domains

facet(template).

level_range(1..10).

status(template, high).
status(template, neutral).
status(template, low).

#const template_high_level=1.
#const template_low_level=4.

%% Generate/Assign

%every character get an template value
1{level(template,H,X) : level_range(X)}1:- character(H).

%every pair of characters gets a template similarity level
1{sim(template,A,B,X) : status(template, X)}1:- character(A), character(B), A!=B.

%% Integrity constraints

% high template_sim if template difference is within some bound
:-sim(template,A,B,high), character(A), character(B), A != B, 
		level(template,A,X), level(template,B,Y),
		level_range(X), level_range(Y), |X-Y| > template_high_level.

% low template_sim if template difference is beyond some bound
:-sim(template,A,B,low), character(A), character(B), A != B, 
		level(template,A,X), level(template,B,Y),
		level_range(X), level_range(Y), |X-Y| < template_low_level.

% neutral template_sim if not similar or opposite 
:-sim(template,A,B,neutral), character(A), character(B), A != B, 
		level(template,A,X), level(template,B,Y),
		level_range(X), level_range(Y), |X-Y| <= template_high_level.

:-sim(template,A,B,neutral), character(A), character(B), A != B, 
		level(template,A,X), level(template,B,Y),
		level_range(X), level_range(Y), |X-Y| >= template_low_level.



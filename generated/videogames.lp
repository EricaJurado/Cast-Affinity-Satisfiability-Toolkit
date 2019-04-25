#const videogames_high_level=2.
#const videogames_low_level=5.
%#const high=1.
%#const neutral=0.
%#const low=-1.
%% Generation, non-instance domains

facet(videogames).

videogames(1..10).

status(videogames, high).
status(videogames, neutral).
status(videogames, low).

%% Generate/Assign

%every human get an videogames value
1{level(videogames,H,X) : videogames(X)}1:- human(H).

%every pair of humans gets a videogames similarity level
1{sim(videogames,A,B,X) : status(videogames, X)}1:- human(A), human(B), A!=B.

%% Integrity constraints

% high videogames_sim if videogames difference is within some bound
:-sim(videogames,A,B,high), human(A), human(B), A != B, 
		level(videogames,A,X), level(videogames,B,Y),
		videogames(X), videogames(Y), |X-Y| > videogames_high_level.

% low videogames_sim if videogames difference is beyond some bound
:-sim(videogames,A,B,low), human(A), human(B), A != B, 
		level(videogames,A,X), level(videogames,B,Y),
		videogames(X), videogames(Y), |X-Y| < videogames_low_level.

% neutral videogames_sim if not similar or opposite 
:-sim(videogames,A,B,neutral), human(A), human(B), A != B, 
		level(videogames,A,X), level(videogames,B,Y),
		videogames(X), videogames(Y), |X-Y| <= videogames_high_level.

:-sim(videogames,A,B,neutral), human(A), human(B), A != B, 
		level(videogames,A,X), level(videogames,B,Y),
		videogames(X), videogames(Y), |X-Y| >= videogames_low_level.



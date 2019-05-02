% affinity: a spontaneous or natural liking or sympathy for someone or something.
%
% based partly on similarity. but we can add in other rules for affinity too.
%
% ex: someone who is more assertive might have an affinity for someone who is more compliant? 
%

def(low, 1..3).
def(neutral, 4..6).
def(high, 7..10).

affinity(-10..10).

% person with X level of facet A, has affinity affect F for 
% person with Y level of facet B
% attribute_affinity(A,X,B,Y,F).

1{pair_affinity(A,B,X) : affinity(X)}1:- character(A), character(B), A!=B. 

:-pair_affinity(H1,H2,X), character(H1), character(H2), H1!=H2,
			X1 = #sum{A :  attribute_affinity(F1,L1,F2,L2,A), 
				level(F1,H1,S1), level(F2,H2,S2),
				def(L1,S1), def(L2,S2)},
			pair_similarity(H1,H2,X2),
			X!=X1+X2.




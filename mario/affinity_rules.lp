%attribute_affinity(A,X,B,Y,F).


%two people who both have a high level of interest (7-10) in kiddnapping
%princessess, will be drawn to each other, increasing their affinity by 6 
attribute_affinity(kidnapping_princesses, high, kidnapping_princesses, high, 6).

attribute_affinity(kidnapping_princesses, low, kidnapping_princesses, low, 4).

attribute_affinity(kidnapping_princesses, high, kidnapping_princesses, low, -2).

attribute_affinity(kidnapping_princesses, low, kidnapping_princesses, high, -6).


#show pair_similarity/3.

%problem instance
human(1..3).

pair_similarity(1,2,2).
pair_similarity(2,1,2).
pair_similarity(1,3,2).
pair_similarity(3,1,2).
pair_similarity(2,3,2).
pair_similarity(3,2,2).

%TODO: add num-similar parameter (so k out of n
%	traits can have x similarity)

facet_affinity(feelings, high, tenderness, high, 1).
facet_affinity(assertiveness, high, assertiveness, high, -2).
facet_affinity(assertiveness, high, compliance, high, 1).
facet_affinity(assertiveness, high, compliance, low, -1).
facet_affinity(vulnerability, high, tenderness, high, 1).
facet_affinity(vulnerability, high, tenderness, low, -1).
facet_affinity(achievement-striving, high, competence, high, 1).
facet_affinity(deliberation, neutral, impulsiveness, neutral, 1). 
facet_affinity(deliberation, high, impulsiveness, high, -1).
facet_affinity(compliance, low, compliance, low, -1).
facet_affinity(self-consciousness, high, self-consciousness, low, 1).
facet_affinity(self-consciousness, low, self-consciousness, high, 1).
facet_affinity(vulnerability, low, vulnerability, high, 2).




#show extra_level/2.
#show neuro_level/2.
%#show pair_similarity/3.

%problem instance
human(erica).
human(arunpreet).
human(kirsten).

pair_similarity(kirsten,erica,2).
pair_similarity(erica,kirsten,2).
pair_similarity(kirsten,arunpreet,1).
pair_similarity(arunpreet,kirsten,1).
pair_similarity(erica,arunpreet,0).
pair_similarity(arunpreet,erica,0).

neuro_level(erica, 5).
neuro_level(kirsten, 5).
neuro_level(arunpreet, 5).


%TODO: add edges for who knows each other?





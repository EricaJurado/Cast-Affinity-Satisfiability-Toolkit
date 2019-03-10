%problem instance
human(erica).
human(arunpreet).
human(kirsten).

extra_level(kirsten,3).
extra_level(erica,5).
extra_sim(erica,kirsten,high).
extra_sim(kirsten,erica,high).
extra_sim(erica,arunpreet,neutral).
extra_sim(arunpreet,erica,neutral).


%TODO: add edges for who knows each other?



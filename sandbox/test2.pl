polacz([], L, L).
polacz([H|T], L, [H|W]) :- polacz(T, L, W).

add(X, L, L) :- member(X, L), !.
add(X, L, [X|L]).
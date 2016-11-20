% Predicado que sucede se X aparecer primeiro que Y na lista L
before(X, Y, L) :-
	append(_, [X|L1], L),
	append(_, [Y|_], L1).
impoe(X, L) :-
	length(Mid, X),
	append(L1, [X|_], L),
	append(_, [X|Mid], L1).


/*
	Este predicado faz com que na lista L existam dois número N, separados
	por N algarismos.
	Através de backtracking, gera todas as hipóteses possíveis para esta
	condição.
*/
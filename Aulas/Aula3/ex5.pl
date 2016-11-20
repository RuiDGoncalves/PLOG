% Predicado que sucede se X for membro da lista L
membro(X, L) :-
	append(_,[X|_],L).

% Predicado que devolve o primeiro elemento da lista L
first(L, X) :-
	append([X], _, L).

% Predicado que devolve o último elemento da lista L
last(L, X) :-
	append(_, [X], L).

% Predicado que devolve o elemento Elem de uma lista que esteja na posição Index dessa lista
n_esimo([H|_], 1, H).
n_esimo([_|T], Index, Elem) :-
	Index > 1,
	IndexNew is Index-1,
	n_esimo(T, IndexNew, Elem).

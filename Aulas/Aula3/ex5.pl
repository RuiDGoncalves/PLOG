membro(X, L) :-
	append(_,[X|_],L).


first(L, X) :-
	append([X], _, L).


last(L, X) :-
	append(_, [X], L).


n_esimo([H|_], 1, H).
n_esimo([_|T], Num, Elem) :-
	Num > 1,
	Num1 is Num-1,
	n_esimo(T, Num1, Elem).

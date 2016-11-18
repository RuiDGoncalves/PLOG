conta(Lista, N) :-
	n_elementos(Lista, Num),
	N =:= Num.


conta_elem(X, Lista, N) :-
	n_elementos_x(Lista, X, Num),
	N =:= Num.



% Predicado que conta o número de elementos de uma lista
n_elementos([], 0).
n_elementos([_|T], Num) :-
	n_elementos(T, NumNew),
	Num is NumNew+1.

% Predicado que conta o número de ocorrências de um dado elemento numa lista
n_elementos_x([], _, 0).
n_elementos_x([H|T], X, Num) :-
	X == H,
	n_elementos_x(T, X, NumNew),
	Num is NumNew+1.
n_elementos_x([H|T], X, Num) :-
	X \== H,
	n_elementos_x(T, X, Num).
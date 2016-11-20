% Predicado que devolve a lista L com todos os números entre 1 e N
lista_ate(1, [1]).
lista_ate(N, L) :-
	N > 1,
	NewN is N-1,
	lista_ate(NewN, L2),
	append(L2, [N], L).


% Predicado que devolve a lista L com todos os números entre N1 e N2
lista_entre(N1, N2, L) :-
	lista_ate(N2, L2),
	append(_, [N1|L3], L2),
	append([N1], L3, L).


% Predicado que devolve a Soma de todos os elementos da lista L
soma_lista(L, Soma) :-
	soma_lista_aux(L, Soma).

soma_lista_aux([H], H).
soma_lista_aux([H|T], Soma) :-
	soma_lista_aux(T, SomaTemp),
	Soma is SomaTemp+H.


% Predicado que sucede se N for um número par
par(N) :-
	(N mod 2) =:= 0.


% Predicado que devolve a Lista com todos os números pares iguais ou inferiores a N
lista_pares(1, []).
lista_pares(2, [2]).
lista_pares(N, Lista) :-
	\+par(N),
	NewN is N-1,
	lista_pares(NewN, Lista).
lista_pares(N, Lista) :-
	N > 2,
	NewN is N-2,
	lista_pares(NewN, L2),
	append(L2, [N], Lista).


% Predicado que devolve a Lista com todos os números ímpares iguais ou inferiores a N
lista_impares(1, [1]).
lista_impares(N, Lista) :-
	par(N),
	NewN is N-1,
	lista_impares(NewN, Lista).
lista_impares(N, Lista) :-
	N > 1,
	NewN is N-2,
	lista_impares(NewN, L2),
	append(L2, [N], Lista).

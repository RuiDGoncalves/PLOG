:- include('ex9.pl').
:- include('ex8.pl').


% Predicado que devolve uma lista Listaf que é a cauda da lista passada no primeiro argumento 
delete_first([_|T], Listaf) :-
	append([], T, Listaf).


% Predicado que sucede se Lista estiver ordenada
ordenada([_]).
ordenada(Lista) :-
	first(Lista, First),
	n_esimo(Lista, 2, Second),
	First =< Second,
	delete_first(Lista, Listaf),
	ordenada(Listaf).


% Predicado que devolve uma lista L2 com os elemntos ordenados da lista L1
/* Não pode ter valores iguais, de resto funciona para todos os casos */
ordena(L1, L2) :-
	ordena_aux(L1, 1, Lf),
	append([], Lf, L2).


ordena_aux(Lista, N, ListaF) :-
	n_elementos(Lista, NumElem),
	N = NumElem,
	append([], Lista, ListaF).

ordena_aux(Lista, N, ListaF) :-
	n_elementos(Lista, NumElem),
	N < NumElem,
	n_esimo(Lista, N, FirstComp),
	N1 is N+1,
	n_esimo(Lista, N1, SecondComp),
	(
	  (FirstComp >= SecondComp) -> 
		(troca_elem(SecondComp, FirstComp, Lista, L2), troca_elem(FirstComp, SecondComp, L2, L3), ordena_aux(L3, 1, ListaF));
		(ordena_aux(Lista, N1, ListaF))
	).


% Predicado que troca o elemento X pelo elemento Y em Lista1 e devolve Lista2 com o elementos trocados
troca_elem(X, Y, Lista1, Lista2) :-
	append(L1, [X|L2], Lista1),
	append(L1, [Y|L2], Lista2).

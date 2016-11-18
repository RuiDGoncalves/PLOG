:- include('ex9.pl').
:- include('ex8.pl').


delete_first([_|T], Listaf) :-
	append([], T, Listaf).


ordenada([_]).
ordenada(Lista) :-
	first(Lista, First),
	n_esimo(Lista, 2, Second),
	First =< Second,
	delete_first(Lista, Listaf),
	ordenada(Listaf).


/* Não pode ter valores iguais, de resto funciona para todos os casos */
ordena(L1, L2) :-
	ordena_aux(L1, 1, Lf),
	append([], Lf, L2).


ordena_aux(Lista, N, ListaF) :-
	n_elementos(Lista, NumElem),
	N = NumElem,
	append([], Lista, ListaF),write(Lista),
	write('nada de jeito').

ordena_aux(Lista, N, ListaF) :-
	n_elementos(Lista, NumElem),write(Lista),write(' -> '),
	N < NumElem,
	n_esimo(Lista, N, FirstComp),write(FirstComp),
	N1 is N+1,
	n_esimo(Lista, N1, SecondComp),write(SecondComp),nl,nl,
	(
	  (FirstComp >= SecondComp) -> 
		 (troca_elem(SecondComp, FirstComp, Lista, L2), write(L2), troca_elem(FirstComp, SecondComp, L2, L3), ordena_aux(L3, 1, ListaF));
		 (ordena_aux(Lista, N1, ListaF))
	).


troca_elem(X, Y, Lista1, Lista2) :-
	append(L1, [X|L2], Lista1),
	append(L1, [Y|L2], Lista2).

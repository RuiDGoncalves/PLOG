% Predicado que devolve a lista ElemsLista com todos os átomos existentes em Lista
achata_lista(Lista, ElemsLista) :-
	achata_lista_aux(Lista, ElemsLista).

achata_lista_aux([], []).
achata_lista_aux(X, [X]) :- atomic(X).
achata_lista_aux([H|T], L) :-
	achata_lista_aux(H, L1),
	achata_lista_aux(T, L2),
	append(L1, L2, L).
	
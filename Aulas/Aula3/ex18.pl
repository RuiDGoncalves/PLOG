:- include('ex8.pl').

% Predicado que duplica os elementos de Lista e devolve ListaDupl
duplicar(Lista, ListaDupl) :-
	duplicar_aux(Lista, ListaDupl).

duplicar_aux([X], [X,X]).
duplicar_aux([H|T], ListaDupl) :-
	duplicar_aux(T, LD2),
	append([H,H], LD2, ListaDupl).


% Predicado que copia os elementos de Lista N vezes e devolve ListaN
duplicarN(Lista, N, ListaN) :-
	duplicarN_aux(Lista, N, ListaN).


duplicarN_aux(OneElemList, N, ListaN) :-
	duplicarN_once(OneElemList, N, ListaN).
duplicarN_aux([H|T], N, ListaN) :-
	duplicarN_once([H], N, L2),
	duplicarN_aux(T, N, ListaN2),
	append(L2, ListaN2, ListaN).


% Predicado que copia os elementos de Lista com um único elemento N vezes e devolve ListaN
duplicarN_once([X], 1, [X]).
duplicarN_once([X], N, ListN) :-
	N > 1,
	NewN is N-1,
	duplicarN_once([X], NewN, L2),
	append([X], L2, ListN).

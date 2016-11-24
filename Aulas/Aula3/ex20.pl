:- use_module(library(lists)).


% Predicado que elimina os elementos de Lista presentes no índice Num*N (N pertence a [1,∞]), e devolve ListaFinal
dropN(Lista, Num, ListaFinal) :-
	dropN_aux(Lista, Num, ListaFinal, Num).


dropN_aux(Lista, Num, Lista, _) :-
	length(Lista, NElem),
	Num > NElem.
dropN_aux(Lista, Num, ListaFinal, NumConst) :-
	NewNum is Num-1,
	sublist(Lista, L2, 0, NewNum, _),
	append(L2, [_|L3], Lista),
	append(L2, L3, L4),
	NewNum2 is Num+(NumConst-1),write(L4),nl,write(NewNum2),nl,
	dropN(L4, NewNum2, ListaFinal, NumConst).

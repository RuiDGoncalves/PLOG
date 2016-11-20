:- include('ex8.pl').

% Predicado que devolve uma lista RunLength com a compressão run-length encoding de Lista
runlength([], []).
runlength(Lista, RunLength) :-
	runlength_divideFirst(Lista, [H|T], RestoLista),
	n_elementos([H|T], NumElem),
	runlength(RestoLista, RL2),
	append([[NumElem,H]], RL2, RunLength).


% Predicado que sucede se todos os elementos da lista passada como argumento forem iguais
lista_elemsIguais([_]).
lista_elemsIguais([H,Y|T]) :-
	H = Y,
	lista_elemsIguais([Y|T]).


% Predicado que devolve uma lista List que contém os elementos consecutivos e iguais a H e devolve em ListaNova o resto da lista original
/* Ex: | ?- runlength_divideFirst([a,a,a,b,b,c,c,c,c], FirstElems, RestoLista).
			FirstElems = [a,a,a],
			RestoLista = [b,b,c,c,c,c]												*/
runlength_divideFirst([H], [H], []).
runlength_divideFirst([H,Y|T], List, [Y|T]) :-
	Y \= H,
	append([], [H], List).
runlength_divideFirst([H,Y|T], List, ListaNova) :-
	Y = H,
	runlength_divideFirst([Y|T], L2, ListaNova),
	append([H], L2, List).


% Predicado que devolve uma lista RunLength com a compressão run-length encoding de Lista, mas em que os elementos que não têm elementos iguais consecutivos são adicionados diretamente para RunLength
run_length_modificado([], []).
run_length_modificado(Lista, RunLength) :-
	runlength_divideFirst(Lista, [H|T], RestoLista),
	n_elementos([H|T], NumElem),
	((NumElem > 1) -> 
		(run_length_modificado(RestoLista, RL2),
		 append([[NumElem,H]], RL2, RunLength));
		(run_length_modificado(RestoLista, RL2),
		 append([H], RL2, RunLength))
	).


% Predicado que descodifica uma lista do tipo compressão run-length encoding
decode_runlength([], []).
decode_runlength([H|T], DecodedFinal) :-
	decode_simpleList(H, DecodedList),
	decode_runlength(T, DecodedF),
	append(DecodedList, DecodedF, DecodedFinal).


% Predicado que descodifica uma lista, por exemplo [5,a], e a transforma em [a,a,a,a,a] e a coloca em DecodedList
decode_simpleList([H,Y], DecodedList) :-
	fill_listH(Y, H, DecodedList).


% Predicado que devolve a lista List que contém N elementos com o valor H
fill_listH(X, 1, [X]).
fill_listH(H, N, List) :-
	N > 1,
	NewN is N-1,
	fill_listH(H, NewN, L2),
	append([H], L2, List).





% OBSOLETO (Durante a implementação pensei que fosse precisa... pestanas queimadas para nada -.-)
% Predicado que devolve uma lista em que os elementos são listas de elementos consecutivos iguais de Lista
/* Ex: | ?- runlength_divide([a,a,a,b,b,c,c,c,c], Lf).
			Lf = [[a,a,a],[b,b],[c,c,c,c]]				*/
runlength_divide(Lista, ListaFinal) :-
	lista_elemsIguais(Lista),
	append([], [Lista], ListaFinal).
runlength_divide(Lista, ListaFinal) :-
	runlength_divideFirst(Lista, FirstList, TList),
	runlength_divide(TList, ListaF),
	append([FirstList], ListaF, ListaFinal).

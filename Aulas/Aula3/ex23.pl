:- use_module(library(random)).


% Predicado que, dada uma Lista, gera uma ListaFinal com N elementos de Lista aleatórios
rnd_selectN(Lista, 1, ListaFinal) :-
	length(Lista, Tam),
	TamRand is Tam+1,
	random(1, TamRand, RandNum),
	nth1(RandNum, Lista, Valor),
	append([Valor], [], ListaFinal).
rnd_selectN(Lista, Num, ListaFinal) :-
	NewNum is Num-1,
	length(Lista, Tam),
	TamRand is Tam+1,
	random(1, TamRand, RandNum),
	nth1(RandNum, Lista, Valor),
	rnd_selectN(Lista, NewNum, ListaFinalTemp),
	append([Valor], ListaFinalTemp, ListaFinal).


% Predicado que escolhe N elementos entre 1 e M e os coloca em Lista
rnd_select(0, _, []).
rnd_select(1, M, List) :-
	random(1, M, RandNum),
	append([], [RandNum], List).
rnd_select(N, M, List) :-
	NewN is N-1,
	random(1, M, RandNum),
	rnd_select(NewN, M, ListTemp),
	append([RandNum], ListTemp, List).


% Predicado que apaga o elementos no indíce Index de Lista, e coloca o resultado em ListaIndexApagado
delete_index(Lista, Index, ListaIndexApagado) :-
	sublist(Lista, Result, 0, Index, _),
	append(Result, Resto, Lista),
	append(L1, [_], Result),
	append(L1, Resto, ListaIndexApagado).


% Predicado que faz uma permutação aleatória de todos os elementos de Lista e coloca o resultado em RandPerm
rnd_permutation([X], [X]).
rnd_permutation(Lista, RandPerm) :-
	length(Lista, Tam),
	TamRand is Tam+1,
	random(1, TamRand, RandNum),
	nth1(RandNum, Lista, Valor),
	delete_index(Lista, RandNum, ListaApagada),
	rnd_permutation(ListaApagada, RandPermTemp),
	append([Valor], RandPermTemp, RandPerm).

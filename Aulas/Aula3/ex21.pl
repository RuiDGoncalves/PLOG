:- use_module(library(lists)).


% Predicado que devlove em Result a sublista de Lista entre os índices Ind1 e Ind2
slice(Lista, Ind1, Ind2, Result) :-
	NewInd1 is Ind1-1,
	NewInd2 is Ind2-NewInd1,
	sublist(Lista, Result, NewInd1, NewInd2, _).

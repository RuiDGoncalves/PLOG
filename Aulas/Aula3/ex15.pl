:- include('ex8.pl').

% Predicado que devolve o valor do produto interno das listas L1 e L2
produto_interno(L1, L2, N) :-
	n_elementos(L1, ElemsL1),
	n_elementos(L2, ElemsL2),
	ElemsL1 =:= ElemsL2,
	produto_interno_aux(L1, L2, N).

produto_interno_aux([X], [Y], N) :-
	N is X*Y.
produto_interno_aux([FirstL1|L1T], [FirstL2|L2T], N) :-
	Mult is FirstL1*FirstL2,
	produto_interno_aux(L1T, L2T, NewN),
	N is NewN+Mult.
	
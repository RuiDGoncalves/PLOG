:- include('ex6.pl').
:- include('ex8.pl').

permutacao(L1, L2) :-
	permutacao_aux(L1, L2).

permutacao_aux([], []).
permutacao_aux([H|T], L2) :-
	membro(H, L2),
	n_elementos([H|T], L1Elem),
	n_elementos(L2, L2Elem),
	L1Elem = L2Elem,
	delete_one(H, L2, L3),
	permutacao_aux(T, L3).
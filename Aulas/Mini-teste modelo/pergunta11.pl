:- include('pergunta10.pl').


impoe_n(X, _, N) :-
	X > N.
impoe_n(X, L, N) :-
	X =< N,
	impoe(X, L),
	X1 is X + 1,
	impoe_n(X1, L, N).


langford(N, L) :-
	NewN is N*2,
	length(L, NewN),
	impoe_n(1, L, N).

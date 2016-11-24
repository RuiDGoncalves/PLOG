:- use_module(library(clpfd)).

/*
	  SEND
	+ MORE
	------
	 MONEY
*/

smm :-
	L = [S, E, N, D, M, O, R, Y],
	domain(L, 0, 9),
	S in 8..9,
	M #= 1,
	(S*1000+E*100+N*10+D)+(M*1000+O*100+R*10+E) #= M*10000+O*1000+N*100+E*10+Y,
	all_distinct(L),
	labeling([], L),
	write(L), nl,
	fail.
smm.
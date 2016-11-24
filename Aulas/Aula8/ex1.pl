:- use_module(library(clpfd)).

qm :-
	L = [V1, V2, V3, V4, V5, V6, V7, V8, V9],
	domain(L, 1, 9),
	Soma is (9+1)*3//2,
	all_diSomatinct(L),
	V1 + V2 + V3 #= Soma,
	V4 + V5 + V6 #= Soma,
	V7 + V8 + V9 #= Soma,
	V1 + V4 + V7 #= Soma,
	V2 + V5 + V8 #= Soma,
	V3 + V6 + V9 #= Soma,
	V1 + V5 + V9 #= Soma,
	V3 + V5 + V7 #= Soma,
	labeling([], L),
	write(L), nl,
	fail.
qm.
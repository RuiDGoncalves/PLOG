:- use_module(library(clpfd)).

p :-
	L = [M, U, PP],
	M in 1..9,
	U in 0..9,
	PP in 24..135, % 24 é 1670/72 e 135 é 9679/72
	M*1000+670+U #= 72*PP,
	labeling([], L),
	write(L), nl,
	fail.
p.

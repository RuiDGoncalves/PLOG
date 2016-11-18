e_primo(2).
e_primo(3).
e_primo(N) :-
	integer(N),
	N > 3,
	N mod 2 =\= 0,
	\+tem_fator(N, 3).

tem_fator(N, L) :-
	N mod L =:= 0.

tem_fator(N, L) :-
	L*L < N,
	L2 is L+2,
	tem_fator(N, L2).
% Predicado que sucede se N for um número primo
primo(2).
primo(3).
primo(N) :-
	integer(N),
	N > 3,
	(N mod 2) =\= 0,
	\+tem_fator(N, 3).

% Predicado que sucede se Mult for múltiplo de Div+N*2 (N pertence a [0,∞]) ou Div² é menor que Mult
tem_fator(Mult, Div) :-
	(Mult mod Div) =:= 0.
tem_fator(Mult, Div) :-
	Div*Div < Mult,
	Div2 is Div+2,
	tem_fator(Mult, Div2).


% Predicado que devolve uma Lista com todos os números primos iguais ou inferiores a N
lista_primos(3, [1,2,3]).
lista_primos(N, Lista) :-
	\+primo(N),
	NewN is N-1,
	lista_primos(NewN, Lista).
lista_primos(N, Lista) :-
	N > 1,
	primo(N),
	NewN is N-1,
	lista_primos(NewN, L2),
	append(L2, [N], Lista).

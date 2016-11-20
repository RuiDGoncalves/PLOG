:- include('ex5.pl').

% Predicado que substitui todas as ocorrências de X por Y em Lista1, devolvendo Lista2
substitui(X, _, Lista1, Lista2) :-
	\+membro(X, Lista1),
	append([], Lista1, Lista2).
substitui(X, Y, Lista1, Lista2) :-
	membro(X, Lista1),
	append(L1, [X|L2], Lista1),
	append(L1, [Y|L2], Lista3),
	substitui(X, Y, Lista3, Lista2).
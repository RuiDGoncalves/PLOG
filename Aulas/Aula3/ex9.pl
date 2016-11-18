:- include('ex5.pl').


substitui(X, _, Lista1, Lista2) :-
	\+membro(X, Lista1),
	append([], Lista1, Lista2).

substitui(X, Y, Lista1, Lista2) :-
	membro(X, Lista1),
	append(L1, [X|L2], Lista1),write(L1),nl,write(L2),
	append(L1, [Y|L2], Lista3),
	substitui(X, Y, Lista3, Lista2).
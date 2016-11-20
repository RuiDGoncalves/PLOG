:- include('ex5.pl').

% Predicado que remove a primeira ocorrência de X na lista L1 e devolve a lista L2
delete_one(X, L1, L2) :-
	append(L3, [X|L4], L1),
	append(L3, L4, L2).


% Predicado que remove todas as ocorrências de X na lista L1 e devolve a lista L2
delete_all(X, L1, L2) :-
	\+membro(X, L1),
	append([], L1, L2).

delete_all(X, L1, L2) :-
	membro(X, L1),
	delete_one(X, L1, L3),
	delete_all(X, L3, L2).

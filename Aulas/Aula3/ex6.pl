:- include('ex5.pl').


delete_one(X, L1, L2) :-
	append(L3, [X|L4], L1),
	append(L3, L4, L2).


delete_all(X, L1, L3) :-
	\+membro(X, L1),
	append([], L1, L3).

delete_all(X, L1, L3) :-
	membro(X, L1),
	delete_one(X, L1, L2),
	delete_all(X, L2, L3).

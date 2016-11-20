:- include('ex4.pl').
:- include('ex6.pl').

% Predicado que sucede se L for um palíndromo
palindroma(L) :- inverter(L, L).

palindroma_b([]).
palindroma_b([_]).
palindroma_b(L) :-
	first(L, FirstElem),
	last(L, LastElem),
	FirstElem = LastElem,
	delete_one(FirstElem, L, L2),
	inverter(L2, L3),
	delete_one(LastElem, L3, L4),
	palindroma_b(L4).

letters(L) :- L=[a,b,c,d,e].

check_letter(Letter) :-
	member(Letter, [a,b,c,d,e]).
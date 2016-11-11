letters(L) :- L=[a,b,c,d,e].

check_letter(Letter) :-
	letters(L),
	member(Letter, L).


repeat_teste(Xi, Xf) :-
	repeat,
	write('Write Xi: '),
	get_code(Xi), skip_line,
	write('Write Xf: '),
	get_code(Xf),
	Xi > Xf.


teste_decrement(A,B,C, A1,B1,C1) :-
	A1 is A-3,
	B1 is B-5,
	C1 is C-1.
	
main_teste(A,B,C) :- 
	teste_decrement(A,B,C, A1,B1,C1),
	write(A1), nl, write(B1), nl, write(C1).
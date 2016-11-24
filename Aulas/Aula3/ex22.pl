:- use_module(library(lists)).


rodar(Lista, Amount, Result) :-
	rotate_list(Amount, Lista, Result).
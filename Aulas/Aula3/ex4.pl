% Predicado que inverte Lista e devolve a lista invertida em InvLista
inverter(Lista, InvLista) :- 
	rev(Lista, [], InvLista). 


rev([H|T], S, R) :- 
	rev(T, [H|S], R).

rev([], R, R).
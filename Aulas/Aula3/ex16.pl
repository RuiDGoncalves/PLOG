% Predicado que substitui os elementos de índice par por 'censurado'
misterio([], []).
misterio([X], [X]).
misterio([X,Y|L], [X,censurado|M]) :-
	misterio(L, M).

% b) Porque a cada passo recursivo são removidos 2 elementos da lista. É necessário ter dois casos base para que seja garantido que a lista possa ter um número de elementos par ou ímpar.
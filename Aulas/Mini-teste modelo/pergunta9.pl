%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).



predX(Q, [R|Rs], [P|Ps]) :-
    participant(R, I, P),
    I =< Q, !,
    predX(Q, Rs, Ps).
predX(Q, [R|Rs], Ps) :-
    participant(R, I, _),
    I > Q,
    predX(Q, Rs, Ps).
predX(_,[],[]).


/* 	
	Para uma dada lista de participantes, dá a lista de performances dos
	participantes com idade menor ou igual à idade escolhida.
	O cut é verde visto que não altera a lógica do programa, apenas reduz
	backtracking desnecessário.
	Isto deve-se ao facto de no segundo predicado existir a verificação "I>Q",
	a inversa da do predicado acima, "I=<Q".
	O cut não seria verde se não existisse a verificação "I>Q", pois nesse caso
	o backtracking geraria respostas erradas.
*/
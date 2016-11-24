%course(Code,Name,Acronym,SchoolYear,Semester,Credits).
course(eic0026, 'Planilhas Orientadas a Gamers', 'PLOG', 3, 1, 5).
course(eic0084, 'Luau de Animação e Interação Gestual', 'LAIG', 3, 1, 7).
course(eic0024, 'Estimativas de Sofrimento', 'ESOF', 3, 1, 6).
course(eic0032, 'Realidade Comatosa', 'RCOM', 3, 1, 6).
course(eic0112, 'Lágrimas e Temores para a Web', 'LTW', 3, 1, 6).

%student(Code,Name,FirstYear).
student(2012012270, 'Artemisa Antonieta', 2012).
student(2012490160, 'Bernardete Bernardes', 2012).
student(2012687310, 'Cristalina Coronaldo', 2012).
student(2012380501, 'Demétrio Dourolindo', 2012).
student(2012380401, 'Eleutério Elisandro', 2012).
student(2012746621, 'Felismina Felizardo', 2012).

%score(StudentCode,CourseCode,Year,Result).
score(2012012270, eic0026, 2014, 20).
score(2012012270, eic0084, 2014, 16).
score(2012012270, eic0024, 2014, 17).
score(2012012270, eic0032, 2014, 12).
score(2012012270, eic0112, 2014, 18).
score(2012687310, eic0032, 2014, missed). % -------------------------
score(2012490160, eic0026, 2014, missed).
score(2012490160, eic0084, 2014, 7).
score(2012490160, eic0024, 2014, 10).
score(2012490160, eic0032, 2014, 4).
score(2012490160, eic0112, 2014, missed).
score(2012380501, eic0032, 2014, 11).



delete_garbage([], []).
delete_garbage([H|T], ListaLimpa) :-
	\+integer(H),
	delete_garbage(T, ListaLimpa).
delete_garbage([H|T], ListaLimpa) :-
	H < 10,
	delete_garbage(T, ListaLimpa).
delete_garbage([H|T], ListaLimpa) :-
	H >= 10,
	delete_garbage(T, ListaLimpaTemp),
	append([H], ListaLimpaTemp, ListaLimpa).


studentAverage(Student, Average) :-
	findall(Result, score(Student, _, _, Result), Results),
	length(Results, Tam1),
	delete_garbage(Results, ResultsClean),
	length(ResultsClean, Tam2),
	sumlist(ResultsClean, Sum),
	((Tam1 = 0) -> (append([nd], [], [Average])); (Average is (Sum/Tam2))).


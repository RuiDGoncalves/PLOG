:- use_module(library(lists)).
:- use_module(library(clpfd)).


test :-
	length(List, 10),
	nth0(3, List, 0),
	domain(List, 0, 4),
	labeling([], List),
	write(List).

	
dominoes(N) :-
	data(N, Board),
	getBoardDimensions(Board, NColumns, NLines),
	getMax(Board, Max),
	createEmptyBoard(Empty, NColumns, NLines),
	addHoles(Empty, Board, Result), !,
	constraintHoles(Result), !,
	transpose(Result, Transpose),
	orientationConstraint(Result, Transpose),
	positionConstraint(Board, Result, 0, 0, Max),
	append(Result, FlatResult),
	domain(FlatResult, 0, 4),
	labeling([], FlatResult),
	print2d(Result).
	%printResult(Result).

%=================================================================
% Get value in 2d list
index(Matrix, Row, Column, Value) :-
	nth0(Row, Matrix, MatrixRow),
	nth0(Column, MatrixRow, Value).
	
indexConstraint(Matrix, Row, Column, Value) :-
	nth0(Row, Matrix, MatrixRow),
	Column1 is Column+1,
	element(Column1, MatrixRow, Value).
	
getMax(Matrix, Max) :-
	append(Matrix, Flat),
	max_member(Max, Flat).
	
	
%=================================================================
% Print 2d list
print2d([]).
print2d([Row|List]) :-
	write(Row), nl,
	print2d(List).
	
% Print result list
printResult([]).
printResult([Row|Tail]) :-
	printResultRow(Row),
	printResult(Tail).
	
printResultRow([]) :- nl.
printResultRow([1|Tail]) :-
	write('w '),
	printResultRow(Tail).
printResultRow([2|Tail]) :-
	write('e '),
	printResultRow(Tail).
printResultRow([3|Tail]) :-
	write('n '),
	printResultRow(Tail).
printResultRow([4|Tail]) :-
	write('s '),
	printResultRow(Tail).


%=================================================================
% Get original board dimensions
getBoardDimensions(Board, NColumns, NLines) :-
	length(Board, NLines),
	nth0(0, Board, Row),
	length(Row, NColumns).

%=================================================================
% Create empty 2d list with given dimensions
createEmptyBoard(Result, NColumns, NLines) :-
	length(Result, NLines),
	createRows(Result, NColumns, NLines).
	
createRows(_,_,0).
createRows(Result, NColumns, NLines) :-
	length(Row, NColumns),
	nth1(NLines, Result, Row),
	NextLine is NLines-1,
	createRows(Result, NColumns, NextLine).
	
%==================================================================
% Add holes to board

addHoles([],[],[]).
addHoles([RE|Empty], [RB|Board], [RR|Result]) :-
	addHolesRow(RE, RB, RR),
	addHoles(Empty, Board, Result).
	
addHolesRow([],[],[]).
addHolesRow([_|RE], [-1|RB], [0|RR]) :-
	addHolesRow(RE, RB, RR).
addHolesRow([X|RE], [_|RB], [X|RR]) :-
	addHolesRow(RE, RB, RR).

%=================================================================
% Constraints

% Make sure every element > 0 except for holes
constraintHoles([]).
constraintHoles([Row|Tail]) :-
	constraintHolesRow(Row),
	constraintHoles(Tail).
	
constraintHolesRow([]).
constraintHolesRow([Element|Row]) :-
	var(Element), !,
	Element #> 0,
	constraintHolesRow(Row).
constraintHolesRow([_|Row]) :-
	constraintHolesRow(Row).

% Make sure West-East North-South
orientationConstraint(Result, Transpose) :-
	matchWestEast(Result),
	matchNorthSouth(Transpose).
	
% Check West-East
matchWestEast([]).
matchWestEast([Row|Tail]) :-
	matchFirstWestEast(Row),
	matchRowWestEast(Row),
	matchWestEast(Tail).

matchFirstWestEast([Head|_]) :- #\ Head #= 2.

matchRowWestEast([]).
matchRowWestEast([First]) :- #\ First #= 1.
matchRowWestEast([First,Second | Tail]) :-
	First #= 1 #<=> Second #= 2,
	matchRowWestEast([Second|Tail]).
% Check North-South
matchNorthSouth([]).
matchNorthSouth([Row|Tail]) :-
	matchFirstNorthSouth(Row),
	matchRowNorthSouth(Row),
	matchNorthSouth(Tail).

matchFirstNorthSouth([Head|_]) :- #\ Head #= 4.
	
matchRowNorthSouth([]).
matchRowNorthSouth([First]) :- #\ First #= 3.
matchRowNorthSouth([First,Second | Tail]) :-
	First #= 3 #<=> Second #= 4,
	matchRowNorthSouth([Second|Tail]).

% Make sure each piece is in the right position and is placed only once
positionConstraint(Board, Result, Max, Max, Max) :-
	findPiece(Board, Result, Max, Max).

positionConstraint(Board, Result, Curr1, Max, Max) :-
	findPiece(Board, Result, Curr1, Max),
	NextCurr1 is Curr1+1,
	positionConstraint(Board, Result, NextCurr1, NextCurr1, Max).
	
positionConstraint(Board, Result, Curr1, Curr2, Max) :-
	findPiece(Board, Result, Curr1, Curr2),
	NextCurr2 is Curr2+1,
	positionConstraint(Board, Result, Curr1, NextCurr2, Max).
	
% find Num1-Num2 horizontal
findPiece(Board, Result, Num1, Num2) :-
	index(Board, Row, Column, Num1),
	NextColumn is Column+1,
	index(Board, Row, NextColumn, Num2),
	indexConstraint(Result, Row, Column, 1).
	
% find Num2-Num1 horizontal
findPiece(Board, Result, Num1, Num2) :-
	index(Board, Row, Column, Num2),
	NextColumn is Column+1,
	index(Board, Row, NextColumn, Num1),
	indexConstraint(Result, Row, Column, 1).

% find Num1-Num2 vertical
findPiece(Board, Result, Num1, Num2) :-
	index(Board, Row, Column, Num1),
	NextRow is Row+1,
	index(Board, NextRow, Column, Num2),
	indexConstraint(Result, Row, Column, 3).

% find Num2-Num1 vertical
findPiece(Board, Result, Num1, Num2) :-
	index(Board, Row, Column, Num2),
	NextRow is Row+1,
	index(Board, NextRow, Column, Num1),
	indexConstraint(Result, Row, Column, 3).



data(0,[[1, 0],
		[0, 1],
		[0, 1]]).
		
data(1,[[0, 0, 1],
		[0, 1, 2],
		[1, 1, 2]]).
		
data(2,[[0, 1, 2],
		[0,-1, 1],
		[0, 1, 1]]).
		
data(3,[[2, 0, 0, 2, 2, 3],
		[2, 0, 1, 1, 0, 0],
		[1, 1, 4, 4, 4, 3],
		[2, 1, 3, 2, 3, 3],
		[1, 0, 3, 4, 4, 4]]).
	  
data(4,[[1, 4, 3, 6, 6, 1, 0, 2, 2],
		[2, 0, 0, 0, 1, 1, 3, 1, 3],
		[2, 2,-1,-1,-1,-1,-1, 0, 3],
		[3, 5,-1,-1,-1,-1,-1, 6, 6],
		[3, 4,-1,-1,-1,-1,-1, 6, 3],
		[5, 2,-1,-1,-1,-1,-1, 2, 3],
		[5, 1,-1,-1,-1,-1,-1, 6, 6],
		[1, 2, 0, 1, 0, 4, 4, 4, 5],
		[6, 4, 4, 4, 0, 5, 5, 5, 5]]).
		
data(5, [[-1, 2, 0, 4, 0, 1,-1,-1],
		 [-1, 5, 6, 3, 6, 6, 2, 1],
		 [ 6, 5, 3, 4, 6, 5, 0, 1],
		 [ 6, 5, 1, 0, 0, 5, 2, 1],
		 [ 5, 4, 3, 2, 0, 1, 2, 4],
		 [ 2, 3, 3, 4, 4, 1, 4, 4],
		 [ 2, 6, 6, 2, 0, 0, 1,-1],
		 [-1,-1, 5, 5, 3, 3, 3,-1]]).
		
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		
		
		
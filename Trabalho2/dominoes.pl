:- use_module(library(lists)).
:- use_module(library(clpfd)).
	
dominoes(N) :-
	statistics(walltime, _),
	data(N, Board),
	getBoardDimensions(Board, NColumns, NLines),
	getMax(Board, Max),
	createEmptyBoard(Empty, NColumns, NLines),
	addHoles(Empty, Board, Result), !,
	constraintHoles(Result), !,
	transpose(Result, Transpose),
	orientationConstraint(Result, Transpose),
	findPiecesPosition(Board, 0, 0, Max, Positions),
	length(Positions, NPieces),
	length(PiecePositions, NPieces),
	setPiecePositionsDomain(Positions, PiecePositions),
	positionConstraint(Positions, PiecePositions, Result),
	append(Result, FlatResult),
	domain(FlatResult, 0, 4),
	%labeling([], FlatResult),
	statistics(walltime, [_|[ExecutionTime]]),
	printLines(Board, Result),
	write('Execution time: '), write(ExecutionTime), write(' ms').
	%print2d(Result).
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
	
% Print result orientations list
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

% Print result lines
printLines([], []).
printLines([BRow|Board], [ORow|Orientations]) :-
	printTop(BRow, ORow),
	printRow(BRow, ORow),
	printBottom(BRow, ORow),
	printLines(Board, Orientations).

printTop([], []) :- nl.
printTop([_|BRow], [1|ORow]) :- lt_corner, horiz, horiz, horiz, printTop(BRow, ORow).
printTop([_|BRow], [2|ORow]) :- horiz, rt_corner, printTop(BRow, ORow).
printTop([_|BRow], [3|ORow]) :- lt_corner, horiz, rt_corner, printTop(BRow, ORow).
printTop([_|BRow], [4|ORow]) :- vert, write(' '), vert, printTop(BRow, ORow).
printTop([_|BRow], [0|ORow]) :- write('   '), printTop(BRow, ORow).

printRow([], []) :- nl.
printRow([Number|BRow], [1|ORow]) :- vert, writeResult(Number), write(' '), write(' '), printRow(BRow, ORow).
printRow([Number|BRow], [2|ORow]) :- writeResult(Number), vert, printRow(BRow, ORow).
printRow([Number|BRow], [3|ORow]) :- vert, writeResult(Number), vert, printRow(BRow, ORow).
printRow([Number|BRow], [4|ORow]) :- vert, writeResult(Number), vert, printRow(BRow, ORow).
printRow([_|BRow], [0|ORow]) :- write('   '), printRow(BRow, ORow).


printBottom([], []) :- nl.
printBottom([_|BRow], [1|ORow]) :- lb_corner, horiz, horiz, horiz, printBottom(BRow, ORow).
printBottom([_|BRow], [2|ORow]) :- horiz, rb_corner, printBottom(BRow, ORow).
printBottom([_|BRow], [3|ORow]) :- vert, write(' '), vert, printBottom(BRow, ORow).
printBottom([_|BRow], [4|ORow]) :- lb_corner, horiz, rb_corner, printBottom(BRow, ORow).
printBottom([_|BRow], [0|ORow]) :- write('   '), printBottom(BRow, ORow).

writeResult(Number) :-
	Number < 10,
	write(Number).
writeResult(Number) :-
	Number < 36,
	N is Number+55,
	put_code(N).


lt_corner :- put_code(9484).
rt_corner :- put_code(9488).
lb_corner :- put_code(9492).
rb_corner :- put_code(9496).
horiz :- put_code(9472).
vert :- put_code(9474).


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

% Find possible positions of all pieces
findPiecesPosition(Board, Max, Max, Max, [Pos|Positions]) :-
	setof(Column-Row-Orientation, findPosition(Board, Max, Max, Column, Row, Orientation), Pos),
	Positions=[].

findPiecesPosition(Board, Curr1, Max, Max, [Pos|Positions]) :-
	setof(Column-Row-Orientation, findPosition(Board, Curr1, Max, Column, Row, Orientation), Pos),
	NextCurr1 is Curr1+1,
	findPiecesPosition(Board, NextCurr1, NextCurr1, Max, Positions).


findPiecesPosition(Board, Curr1, Curr2, Max, [Pos|Positions]) :-
	setof(Column-Row-Orientation, findPosition(Board, Curr1, Curr2, Column, Row, Orientation), Pos),
	NextCurr2 is Curr2+1,
	findPiecesPosition(Board, Curr1, NextCurr2, Max, Positions).


% find Num1-Num2 horizontal
findPosition(Board, Num1, Num2, Column, Row, Orientation) :-
	index(Board, Row, Column, Num1),
	NextColumn is Column+1,
	index(Board, Row, NextColumn, Num2),
	Orientation is 1.
	
% find Num2-Num1 horizontal
findPosition(Board, Num1, Num2, Column, Row, Orientation) :-
	index(Board, Row, Column, Num2),
	NextColumn is Column+1,
	index(Board, Row, NextColumn, Num1),
	Orientation is 1.

% find Num1-Num2 vertical
findPosition(Board, Num1, Num2, Column, Row, Orientation) :-
	index(Board, Row, Column, Num1),
	NextRow is Row+1,
	index(Board, NextRow, Column, Num2),
	Orientation is 3.

% find Num2-Num1 vertical
findPosition(Board, Num1, Num2, Column, Row, Orientation) :-
	index(Board, Row, Column, Num2),
	NextRow is Row+1,
	index(Board, NextRow, Column, Num1),
	Orientation is 3.


% Set domain for each PiecePositions
setPiecePositionsDomain([], []).
setPiecePositionsDomain([Pos|Positions], [PP|PiecePositions]) :-
	length(Pos, Length),
	PP in 1..Length,
	setPiecePositionsDomain(Positions, PiecePositions).

% Position Constraint
positionConstraint([], [], _).
positionConstraint([Pos|Positions], [PP|PiecePositions], Result) :-
	nth1(PP, Pos, Column-Row-Orientation),
	indexConstraint(Result, Row, Column, Orientation),
	positionConstraint(Positions, PiecePositions, Result).



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

data(6, [
	  [0,3,1,4,3,6,1,5,3],
	  [7,4,6,5,4,7,0,0,7],
	  [2,3,2,4,1,0,5,5,7],
	  [1,3,3,4,3,2,4,4,0],
	  [0,4,6,2,6,6,5,3,5],
	  [5,6,6,1,1,2,2,0,2],
	  [1,7,7,6,1,7,2,6,2],
	  [7,1,0,4,5,7,3,5,0]
	  ]).

data(7, [
	  [5,1,3,1,5,1,6,8,8,5],
	  [3,8,3,0,5,6,0,2,8,3],
	  [0,0,8,6,4,4,4,6,6,8],
	  [0,7,4,3,5,6,4,3,0,0],
	  [8,5,6,7,2,4,7,4,2,5],
	  [7,8,1,2,5,3,1,5,2,8],
	  [7,5,4,3,2,7,7,1,7,1],
	  [8,0,4,1,0,1,2,1,0,7],
	  [7,4,3,2,3,6,6,6,2,2]
	  ]).

data(8, [
	  [6,4,4,1,2,2,8,7,1,1],
	  [6,7,2,3,8,1,2,1,5,1],
	  [6,8,3,1,2,5,5,1,6,4],
	  [6,8,0,0,0,0,0,7,2,5],
	  [7,7,8,0,0,0,4,3,3,5],
	  [8,8,8,0,0,1,2,8,4,4],
	  [4,6,5,6,3,5,3,7,4,7],
	  [3,8,7,2,3,5,5,6,1,2],
	  [6,3,5,3,4,4,7,7,2,6]
	  ]).

data(9, [
	  [7,8,9,9,7,4,4,6,3,1,8],
	  [8,3,0,4,4,9,9,9,3,9,7],
	  [8,6,5,3,0,4,8,0,2,5,4],
	  [2,0,4,6,8,7,5,0,8,1,2],
	  [3,6,5,1,6,3,4,3,3,7,2],
	  [2,0,2,1,7,8,5,9,1,9,2],
	  [7,3,3,9,3,5,2,6,6,5,1],
	  [6,8,4,7,1,5,0,7,0,8,1],
	  [2,9,6,7,5,0,1,1,2,9,2],
	  [6,5,8,6,0,4,1,7,5,0,4]
	  ]).

data(10, [
	   [8,5,10,1,3,4,2,3,6,4,4,3 ],
	   [5,6,9,2,7,3,1,8,1,3,4,3 ],
	   [4,8,0,2,0,5,7,1,9,2,8,8 ],
	   [3,0,9,8,3,2,9,6,10,9,4,7 ],
	   [4,1,10,5,2,5,7,9,1,5,1,3 ],
	   [1,0,1,0,4,7,3,9,7,6,10,6 ],
	   [4,0,8,1,9,3,10,8,8,0,2,6 ],
	   [0,7,6,2,1,10,5,6,9,10,7,0 ],
	   [2,7,7,2,1,2,6,3,9,5,6,9 ],
	   [8,10,4,5,0,7,2,10,10,5,8,6 ],
	   [0,10,5,4,4,8,5,9,10,0,7,6 ]
	  ]).
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		
		
		

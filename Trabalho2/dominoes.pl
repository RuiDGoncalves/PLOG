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
	createEmptyBoard(Empty, NColumns, NLines),
	addHoles(Empty, Board, Result), !,
	transpose(Result, Transpose),
	orientationConstrain(Result, Transpose),
	append(Result, FlatResult),
	domain(FlatResult, 0, 4),
	labeling([], FlatResult),
	print2d(Result).
	
% Get value in 2d list
index(Matrix, Row, Column, Value) :-
	nth0(Row, Matrix, MatrixRow),
	nth0(Column, MatrixRow, Value).
	
% Print 2d list
print2d([]).
print2d([Row|Tail]) :-
	write(Row), nl,
	print2d(Tail).


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

% Make sure West-East North-South
orientationConstrain(Result, Transpose) :-
	matchWestEast(Result),
	matchNorthSouth(Transpose).
	
% Check West-East
matchWestEast([]).
matchWestEast([Row|Tail]) :-
	matchFirstWestEast(Row),
	matchRowWestEast(Row),
	matchWestEast(Tail).

matchFirstWestEast([Head|_]) :-
	Head #> 0, #\ Head #= 2.
matchFirstWestEast([0|_]).

matchRowWestEast([]).
matchRowWestEast([First]) :- First #> 0, #\ First #= 1.
matchRowWestEast([First,Second | Tail]) :-
	First #> 0, Second #> 0,
	First #= 1 #<=> Second #= 2,
	matchRowWestEast([Second|Tail]).
matchRowWestEast([0]).
matchRowWestEast([0,Second | Tail]) :- matchRowWestEast([Second|Tail]).
matchRowWestEast([_,0 | Tail]) :- matchRowWestEast(Tail).

% Check North-South
matchNorthSouth([]).
matchNorthSouth([Row|Tail]) :-
	matchFirstNorthSouth(Row),
	matchRowNorthSouth(Row),
	matchNorthSouth(Tail).

matchFirstNorthSouth([Head|_]) :-
	Head #> 0, #\ Head #= 4.
matchFirstNorthSouth([0|_]).
	
matchRowNorthSouth([]).
matchRowNorthSouth([First]) :- First #> 0, #\ First #= 3.
matchRowNorthSouth([First,Second | Tail]) :-
	First #> 0, Second #> 0,
	First #= 3 #<=> Second #= 4,
	matchRowNorthSouth([Second|Tail]).
matchRowNorthSouth([0]).
matchRowNorthSouth([0,Second | Tail]) :- matchRowNorthSouth([Second|Tail]).
matchRowNorthSouth([_,0 | Tail]) :- matchRowNorthSouth(Tail).


data(0,[[0, 0],
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
		
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		
		
		
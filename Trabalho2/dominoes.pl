:- use_module(library(lists)).
:- use_module(library(clpfd)).

/*
test :-
	length(List, 10),
	domain(List, 1, 4),
	constraint(List),
	labeling([], List),
	write(List).
	
constraint([]).
constraint([First]) :- #\ First #= 1.
constraint([First, Second|Tail]) :-
	First #= 1 #<=> Second #= 2,
	constraint([Second|Tail]).
*/	
	
dominoes(N) :-
	data(N, Board),
	getBoardDimensions(Board, NColumns, NLines),
	createEmptyBoard(Result, NColumns, NLines),
	transpose(Result, Transpose),
	orientationConstrain(Result, Transpose),
	append(Result, FlatResult),
	domain(FlatResult, 1, 4),
	labeling([], FlatResult),
	write(Result).
	
	
index(Matrix, Row, Column, Value) :-
	nth0(Row, Matrix, MatrixRow),
	nth0(Column, MatrixRow, Value).

getBoardDimensions(Board, NColumns, NLines) :-
	length(Board, NLines),
	nth0(0, Board, Row),
	length(Row, NColumns).

createEmptyBoard(Result, NColumns, NLines) :-
	length(Result, NLines),
	createRows(Result, NColumns, NLines).
	
createRows(_,_,0).
createRows(Result, NColumns, NLines) :-
	length(Row, NColumns),
	nth1(NLines, Result, Row),
	NextLine is NLines-1,
	createRows(Result, NColumns, NextLine).

	
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
	#\ Head #= 2.

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

matchFirstNorthSouth([Head|_]) :-
	#\ Head #= 4.
	
matchRowNorthSouth([]).
matchRowNorthSouth([First]) :- #\ First #= 3.
matchRowNorthSouth([First,Second | Tail]) :-
	First #= 3 #<=> Second #= 4,
	matchRowNorthSouth([Second|Tail]).


data(0, [[0,0],[0,1]]).
data(2, [[0,0,1],[0,1,2],[2,1,2]]).
	
data(1,
     [[1,6,3,6,0,6,0,2],
      [6,2,2,6,6,5,3,1],
      [2,4,1,2,4,4,5,0],
      [0,5,5,3,0,4,0,3],
      [4,1,3,1,4,5,3,3],
      [1,5,0,0,1,6,4,2],
      [6,2,3,2,1,4,5,5]]).
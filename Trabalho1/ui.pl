/*==============================================================================================================================*/


/* PLAY */
cage :-
	load_libraries,
	nl,
	write('*****************************************'), nl,
	write('**                                     **'), nl,
	write('**           WELCOME TO CAGE           **'), nl,
	write('**                                     **'), nl,
	write('*****************************************'), nl,
	main_menu.


/* MAIN MENU */
main_menu :-
	write('*                                       *'), nl,
	write('*   What do you want to do?             *'), nl,
	write('*      1. Play Human Vs. Human          *'), nl,
	write('*      2. Play Human Vs. Computer       *'), nl,
	write('*      3. Play Computer Vs. Computer    *'), nl,
	write('*      4. Exit                          *'), nl,
	write('*                                       *'), nl,
	write('*****************************************'), nl, nl,
	get_code(Option), skip_line,
	HvH_Option is Option-48,
	play_mode(HvH_Option).


/* Declaration of the initial board */
board(B) :- B=[[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2],
		[2,1,2,1,2,1,2,1,2,1],
		[0,2,1,2,0,0,1,2,1,2],
		[1,0,2,1,0,1,0,1,2,1],
		[0,2,1,2,0,0,0,2,1,2],
		[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2],
		[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2]].

	/*B=[[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2],
		[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2],
		[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2],
		[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2],
		[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2]].*/


/* PLAY MODE Human vs Human*/
play_mode(1) :-
	board(B),
	play(1, B).

/* Play prints the initial board (Player represents the player that begins the game) */
play(Player, Board) :-
	nl,
	write(' -> Player 1 will start the game!'), nl,
	print_board(10, Board), nl,
	play_hvh(Player, Board).


/* Play the game in Human vs Human mode */
play_hvh(Player, Board) :-
	write('Player'), write(Player), nl,
	read_position_from(Player, Board, InitialColumn, InitialLine),
	%adjoin, centering, jumping functions -> (Board, PiecePosition, AvailableMoves) put in AvailableMoves the list of positions of the moves
	get_jump_positions(Player, Board, InitialColumn, InitialLine, JumpMoves),
	get_adjoin_positions(Player, Board, InitialColumn, InitialLine, AdjoinMoves),
	%write(JumpMoves), nl,
	%write(AdjoinMoves), nl,

	read_position_to(Player, Board, FinalColumn, FinalLine),
	%check if position is member of any of the lists
	%if its jumping move to the position of the piece to be jumped over and then to the next position
	%if its from centering or jumping give turn to other player
	%if its from adjoin call adjoin, centering and jumpimp for every position until at least one of the lists isn't empty
	move(Board, NewBoard, InitialColumn, InitialLine, FinalColumn, FinalLine),
	print_board(10, NewBoard), nl,
	((Player == 1) -> play_hvh(2, NewBoard); play_hvh(1, NewBoard)).


/*========================================================================================================================================*/

/* READ POSITION */

read_position_from(Player, Board, Column, Line) :-
	write('From '),
	get_code(C),
	get_code(L), skip_line,
	C > 64, C < 75,
	L > 47, L < 58,
	CNumber is C - 65,
	LNumber is L - 48,
	get_piece(Board, LNumber, CNumber, Piece),
	Piece =:= Player,
	Column is CNumber,
	Line is LNumber.
	
read_position_from(Player, Board, Column, Line) :- read_position_from(Player, Board, Column, Line).
	

read_position_to(Player, Board, Column, Line) :-
	write('To   '),
	get_code(C),
	get_code(L), skip_line,
	C > 64, C < 75,
	L > 47, L < 58,
	CNumber is C - 65,
	LNumber is L - 48,
	Column is CNumber,
	Line is LNumber.
	
read_position_to(Player, Board, Column, Line) :- read_position_to(Player, Board, Column, Line).


/*==============================================================================================================================*/

/* MOVE PIECE */

/* Move piece */
move(Board, NewBoard, InitialColumn, InitialLine, FinalColumn, FinalLine) :-
	get_piece(Board, InitialLine, InitialColumn, Piece),
	change_board_position(Board, NewBoardTemp, 0, InitialColumn, InitialLine, 0),
	change_board_position(NewBoardTemp, NewBoard, 0, FinalColumn, FinalLine, Piece).


/* Get the Piece (0, 1 or 2) that is in a certain Line and Column of the Board */
get_piece(Board, Line, Column, Piece) :-
	nth0(Line, Board, PieceLine), /* get the line of the piece */
	nth0(Column, PieceLine, Piece). /* get the piece ID to be moved */

get_piece(Board, Line, Column, Piece) :- Piece is 3.


/* 
restriction1(Piece, Board, InitialColumn, InitialLine, FinalColumn, FinalLine) :-
	((InitialLine < FinalLine, InitialColumn == FinalColumn) -> 
		(get_piece(Board, FinalLine, FinalColumn-1, Piece1), (Piece1 == Piece)->fail).*/



/* Changes the position ColumnNr, LineNr of a 2d list to Piece */
change_board_position([], [], Count, ColumnNr, LineNr, Piece).

change_board_position([Line|Board], [Line|NewBoard], Count, ColumnNr, LineNr, Piece) :-
	Count \= LineNr,
	NextCount is Count+1,
	change_board_position(Board, NewBoard, NextCount, ColumnNr, LineNr, Piece).

change_board_position([Line|Board], NewBoard, Count, ColumnNr, LineNr, Piece) :- 
	change_line_position(Line, NewLine, 0, ColumnNr, Piece),
	NextCount is Count+1,
	change_board_position([NewLine|Board], NewBoard, NextCount, ColumnNr, LineNr, Piece).


/* Changes the position ColumnNr of a list to Piece */
change_line_position([], [], Count, ColumnNr, Piece).

change_line_position([Position|Line], [Position|NewLine], Count, ColumnNr, Piece) :-
	Count \= ColumnNr,
	NextCount is Count+1,
	change_line_position(Line, NewLine, NextCount, ColumnNr, Piece).

change_line_position([Position|Line], [Piece|NewLine], Count, ColumnNr, Piece) :-
	NextCount is Count+1,
	change_line_position(Line, NewLine, NextCount, ColumnNr, Piece).


/*========================================================================================================================================*/

/* JUMP */

get_jump_positions(Player, Board, Column, Line, AvailableMoves) :-
	Other is ((Player mod 2) + 1),
	Empty is 0,
	check_jump_top(Player, Board, Column, Line, Other, Empty, Top),
	append(Top,[], Temp1),
	check_jump_left(Player, Board, Column, Line, Other, Empty, Left),
	append(Left, Temp1, Temp2),
	check_jump_right(Player, Board, Column, Line, Other, Empty, Right),
	append(Right, Temp2, Temp3),
	check_jump_bottom(Player, Board, Column, Line, Other, Empty, Bottom),
	append(Bottom, Temp3, AvailableMoves).

% Top
% Jump out
check_jump_top(Player, Board, Column, 1, Other, Empty, Top) :-
	get_piece(Board, 0, Column, Jumped),
	Jumped =:= Other,
	Top=[Column].

check_jump_top(Player, Board, Column, Line, Other, Empty, Top) :-
	L1 is Line-1, L2 is Line-2,
	get_piece(Board, L1, Column, Jumped),
	Jumped =:= Other,
	get_piece(Board, L2, Column, Dest),
	Dest =:= Empty,
	T is (10*(Line-1)+Column),
	Top=[T].

check_jump_top(Player, Board, Column, Line, Other, Empty, Top) :- Top=[].

% Bottom
% Jump out
check_jump_bottom(Player, Board, Column, 8, Other, Empty, Bottom) :-
	get_piece(Board, 9, Column, Jumped),
	Jumped =:= Other,
	B is (90+Column),
	Bottom=[B].

check_jump_bottom(Player, Board, Column, Line, Other, Empty, Bottom) :-
	L1 is Line+1, L2 is Line+2,
	get_piece(Board, L1, Column, Jumped),
	Jumped =:= Other,
	get_piece(Board, L2, Column, Dest),
	Dest =:= Empty,
	B is (10*(Line+1)+Column),
	Bottom=[B].

check_jump_bottom(Player, Board, Column, Line, Other, Empty, Bottom) :- Bottom=[].

% Left
% Jump out
check_jump_left(Player, Board, 1, Line, Other, Empty, Left) :-
	get_piece(Board, Line, 0, Jumped),
	Jumped =:= Other,
	L is (Line*10),
	Left=[L].

check_jump_left(Player, Board, Column, Line, Other, Empty, Left) :-
	C1 is Column-1, C2 is Column-2,
	get_piece(Board, Line, C1, Jumped),
	Jumped =:= Other,
	get_piece(Board, Line, C2, Dest),
	Dest =:= Empty,
	L is (10*Line+Column-1),
	Left=[L].

check_jump_left(Player, Board, Column, Line, Other, Empty, Left) :- Left=[].

% Right
% Jump out
check_jump_right(Player, Board, 8, Line, Other, Empty, Right) :-
	get_piece(Board, Line, 9, Jumped),
	Jumped =:= Other,
	R is (Line*10+9),
	Right=[R].

check_jump_right(Player, Board, Column, Line, Other, Empty, Right) :-
	C1 is Column+1, C2 is Column+2,
	get_piece(Board, Line, C1, Jumped),
	Jumped =:= Other,
	get_piece(Board, Line, C2, Dest),
	Dest =:= Empty,
	R is (10*Line+Column+1),
	Right=[R].

check_jump_right(Player, Board, Column, Line, Other, Empty, Right) :- Right=[].


/*========================================================================================================================================*/

/* ADJOIN */

get_adjoin_positions(Player, Board, Column, Line, AvailableMoves) :-
	PL is Line-1, NL is Line+1, PC is Column-1, NC is Column+1,
	check_no_ortogonal(Board, Column, Line),
	get_adjacency(Player, Board, NC, NL, BR),
	get_adjacency(Player, Board, NC, Line, R),
	get_adjacency(Player, Board, NC, PL, TR),
	get_adjacency(Player, Board, Column, NL, B),
	get_adjacency(Player, Board, Column, PL, T),
	get_adjacency(Player, Board, PC, NL, BL),
	get_adjacency(Player, Board, PC, Line, L),
	get_adjacency(Player, Board, PC, PL, TL),
	Lists=[BR,R,TR,B,T,BL,L,TL],
	append(Lists, AvailableMoves).

get_adjoin_positions(Player, Board, Column, Line, AvailableMoves) :- AvailableMoves=[].


check_no_ortogonal(Board, Column, Line) :-
	PL is Line-1, NL is Line+1, PC is Column-1, NC is Column+1,
	get_piece(Board, PL, Column, Piece1), !,
	(Piece1 =:= 0; Piece1 =:= 3),
	get_piece(Board, NL, Column, Piece2), !,
	(Piece2 =:= 0; Piece2 =:= 3),
	get_piece(Board, Line, NC, Piece3), !,
	(Piece3 =:= 0; Piece3 =:= 3),
	get_piece(Board, Line, PC, Piece4), !,
	(Piece4 =:= 0; Piece4 =:= 3).


get_adjacency(Player, Board, Column, Line, Position) :-
	get_piece(Board, Line, Column, Piece0),
	Piece0 =:= 0,
	Other is ((Player mod 2) + 1),
	PL is Line-1, NL is Line+1, PC is Column-1, NC is Column+1,
	get_piece(Board, PL, Column, Piece1),
	get_piece(Board, NL, Column, Piece2),
	get_piece(Board, Line, NC, Piece3),
	get_piece(Board, Line, PC, Piece4),
	(Piece1 =:= Other; Piece2 =:= Other; Piece3 =:= Other; Piece4 =:= Other),
	P is Line*10+Column,
	Position=[P].

get_adjacency(Player, Board, Column, Line, Position) :- Position=[].

/*========================================================================================================================================*/

/* PRINT BOARD */
/* Print board */
/* parameters: Size - of list; Board - list that represents the board */
print_board(Size, Board) :-
	nl, 
	print_letters(Size, Size),
	print_top_lines(Size),
	print_squares(0, Size, Board),
	print_bottom_lines(Size).


/* Print letters on top of the board */
print_letters(Size, Size) :- 
	Size > 0,
	write('    '),
	print_letter(Size, Size).

print_letter(1, Size) :-
	write(' '),
	C is 65+Size-1,
	put_code(C),
	write(' '), nl.

print_letter(Line, Size) :-
	write(' '),
	C is 65+Size-Line,
	put_code(C),
	write(' '),
	Nextline is Line-1,
	print_letter(Nextline,Size).


/* Print the top line of the board */
print_top_lines(Column) :-
	Column > 0,
	write('    '),
	lt_corner,
	print_top_line(Column).

print_top_line(1) :-
	horiz,
	horiz,
	rt_corner, nl.

print_top_line(Column) :-
	horiz,
	horiz,
	top_con,
	Nextcolumn is Column-1,
	print_top_line(Nextcolumn).


/* Print the bottom line line of the board */
print_bottom_lines(Column) :-
	Column > 0,
	write('    '),
	lb_corner,
	print_bottom_line(Column).

print_bottom_line(1) :-
	horiz,
	horiz,
	rb_corner, nl.

print_bottom_line(Column) :-
	horiz,
	horiz,
	bottom_con,
	Nextcolumn is Column-1,
	print_bottom_line(Nextcolumn).


/* Print the middle of the board */
print_squares(Currentline, Size, []).

print_squares(0, Size, [Line|Board]) :-
	print_pieces(0, Size, Line),
	print_squares(1, Size, Board).

print_squares(Currentline, Size, [Line|Board]) :-
	print_middle_lines(Size),
	print_pieces(Currentline, Size, Line),
	Nextline is Currentline+1,
	print_squares(Nextline, Size, Board).


/* Print the horizontal lines and connectors of the board */
print_middle_lines(Size) :- 
	Size > 0,
	write('    '),
	left_con,
	print_middle_line(Size).

print_middle_line(1) :- 
	horiz,
	horiz,
	right_con, nl.

print_middle_line(Size) :- 
	horiz,
	horiz,
	middle,
	Nextsize is Size-1,
	print_middle_line(Nextsize).


/* Print the pieces and the vertical lines */
print_pieces(Currline, Nrline, Line) :-
	write('  '),
	write(Currline),
	write(' '),
	print_piece(Line),
	vert, nl.

print_piece([]).

print_piece([0|Line]) :-
	vert,
	write('  '),
	print_piece(Line).

print_piece([1|Line]) :-
	vert,
	black_circle,
	write(' '),
	print_piece(Line).

print_piece([2|Line]) :-
	vert,
	white_circle,
	write(' '),
	print_piece(Line).


/* Characteres */

lt_corner :- put_code(9484).
rt_corner :- put_code(9488).
lb_corner :- put_code(9492).
rb_corner :- put_code(9496).
horiz :- put_code(9472).
vert :- put_code(9474).
top_con :- put_code(9516).
bottom_con :- put_code(9524).
left_con :- put_code(9500).
right_con :- put_code(9508).
middle :- put_code(9532).

black_circle :- put_code(11044).
white_circle :- put_code(11093).%put_code(9711).


/*========================================================================================================================================*/

/* LIBRARIES */

load_libraries :- use_module(library(lists)).

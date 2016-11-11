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
		[1,2,1,2,1,2,1,2,1,2],
		[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2],
		[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2],
		[2,1,2,1,2,1,2,1,2,1],
		[1,2,1,2,1,2,1,2,1,2]].


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
play_hvh(1, Board) :-
	write('Player'), write(1), nl,
	read_position_from(1, Board, InitialColumn, InitialLine),
	%adjoin, centering, jumping functions -> (Board, PiecePosition, AvailableMoves) put in AvailableMoves the list of positions of the moves
	read_position_to(1, Board, FinalColumn, FinalLine),
	%check if position is member of any of the lists
	%if its jumping move to the position of the piece to be jumped over and then to the next position
	%if its from centering or jumping give turn to other player
	%if its from adjoin call adjoin, centering and jumpimp for every position until at least one of the lists isn't empty
	move(Board, NewBoard, InitialColumn, InitialLine, FinalColumn, FinalLine),
	print_board(10, NewBoard), nl,
	play_hvh(2, NewBoard).

play_hvh(2, Board) :-
	write('Player'), write(2), nl,
	read_position_from(2, Board, InitialColumn, InitialLine),
	read_position_to(2, Board, FinalColumn, FinalLine),
	move(Board, NewBoard, InitialColumn, InitialLine, FinalColumn, FinalLine),
	print_board(10, NewBoard), nl,
	play_hvh(1, NewBoard).

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
	nth0(LNumber, Board, NewLine),
	nth0(CNumber, NewLine, Piece),
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


/*  */
restriction1(Piece, Board, InitialColumn, InitialLine, FinalColumn, FinalLine) :-
	((InitialLine < FinalLine, InitialColumn == FinalColumn) -> 
		(get_piece(Board, FinalLine, FinalColumn-1, Piece1), (Piece1 == Piece)->fail).



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

/* CAGE */

/* includes */
:- use_module(library(lists)).
:- ensure_loaded('board_states.pl').
:- ensure_loaded('graphics.pl').
:- ensure_loaded('utilities.pl').
:- ensure_loaded('rules.pl').
:- ensure_loaded('input.pl').
:- ensure_loaded('play_pvp.pl').

cage :-
	nl,
	double_lt_corner, double_horiz(37), double_rt_corner, nl,
	double_vert, space(37), double_vert, nl,
	double_vert, space(11), write('WELCOME TO CAGE'), space(11), double_vert, nl,
	double_vert, space(37), double_vert, nl,
	double_left_con, double_horiz(37), double_right_con, nl,
	main_menu.


/* MAIN MENU */
main_menu :-
	double_vert, space(37), double_vert, nl,
	double_vert, space(13), write('Game Modes'), space(14), double_vert, nl,
	double_vert, space(37), double_vert, nl,
	double_vert, space(8), write('1. Player vs. Player'), space(9), double_vert, nl,
	double_vert, space(8), write('2. Player vs. CPU (Easy)'), space(5), double_vert, nl,
	double_vert, space(8), write('3. Player vs. CPU (Harder)'), space(3), double_vert, nl,
	double_vert, space(8), write('4. CPU vs. CPU'), space(15), double_vert, nl,
	double_vert, space(37), double_vert, nl,
	double_lb_corner, double_horiz(37), double_rb_corner, nl,
	get_menu_input(Option, 1, 4),
	NOption is Option-48,
	play_mode(NOption).

play_mode(1) :-
	board(B),
	nl, nl,
	write('Player1 -> '), black_circle, write('   '),
	write('Player2 -> '), white_circle, nl,
	print_board(10, B), nl,
	play_pvp(1, B).

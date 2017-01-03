:- use_module(library(clpfd)).
:- use_module(library(lists)).

%===========================================================================================================================
% 1

train :-
	% Ferreira=1 Rocha=2 Silva=3
	Employees = [Revisor, Foguista, Maquinista],
	domain(Employees, 1, 3),
	all_distinct(Employees),
	Cities = [SrRochaCity, RevisorCity, SrSilvaCity],
	domain(Cities, 1, 3),
	% City 1-Detroit 2-Middle 3-Chicago
	SrRochaCity #= 1,
	RevisorCity #= 2,
	SrFerreiraCity #= 3,
	Foguista #\= 3,
	Revisor #= 1,
	labeling([], Employees),
	write(Employees).
	
%===========================================================================================================================
% 2

musicians :-
	% Joao=1 Antonio=2 Francisco=3
	Instruments = [Harp, Piano, Violin],
	domain(Instruments, 1, 3),
	all_distinct(Instruments),
	Piano #\= 2,
	Violin #\= 1,
	Piano #\= 1,
	labeling([], Instruments),
	write(Instruments).
	
%===========================================================================================================================
% 3

shopping :-
	%book=1, dress=2, purse=3, tie=4, hat=5, lamp=6
	People = [Adams, Baker, Catt, Dodge, Ennis, Fisk],
	domain(People, 1, 6),
	all_distinct(People),
	%TieFloor #= 2,
	%DressFloor #= 3,
	Fisk #\= 4,
	Fisk #\= 2,
	Ennis #= 6,
	Adams #= 1,
	Catt #= 3,
	Baker #\= 4,
	labeling([], People),
	write(People).
	
	
%===========================================================================================================================
% 4

% a) era 2ª feira e não era casado
% b) hoje é segunda ou quinta-feira
% c) quinta-feira, foi tak que disse
% d) segunda-feira, 1º-tak, 2º-jal
% e) falso. para um par A, A' existe um C que diz a verdade todos os dias

	
%===========================================================================================================================
% 5

cars :-
	Colors = [Yellow, Green, Blue, Black],
	Size = [First, Second, Third, Forth],
	domain(Colors, 1, 4),
	domain(Size, 1, 4),
	Before #= Blue - 1,
	After #= Blue + 1,
	element(Before, Size, ElemB),
	element(After, Size, ElemA),
	ElemA #> ElemB,	
	element(Green, Size, 1),
	Green #> Blue,
	Yellow #> Black,
	labeling([], Colors),
	write(Colors).
	
%===========================================================================================================================
% 7

vacation :-
	% 1-limonada, 2-guarana, 3-whisky, 4-vinho, 5-champanhe, 6-agua,
	% 7-laranjada, 8-cafe, 9-cha, 10-vermouth, 11-cerveja, 12-vodka
	People = [Joao, Miguel, Nadia, Silvia, Afonso, Cristina, Geraldo, Julio, Maria, Maximo, Manuel, Ivone],
	domain(People, 1, 12),
	all_distinct(People),
	Geraldo #\= 12, Geraldo #\= 11, Geraldo #\= 10, Geraldo #\= 9, Geraldo #\= 8, Geraldo #\= 7,
	Julio #\= 12, Julio #\= 11, Julio #\= 10, Julio #\= 9, Julio #\= 8, Julio #\= 7,
	Maria #\= 12, Maria #\= 11, Maria #\= 10, Maria #\= 9, Maria #\= 8, Maria #\= 7,
	Maximo #\= 12, Maximo #\= 11, Maximo #\= 10, Maximo #\= 9, Maximo #\= 8, Maximo #\= 7,
	Ivone #\= 12, Ivone #\= 11, Ivone #\= 10, Ivone #\= 9, Ivone #\= 8, Ivone #\= 7,
	Manuel #\= 12, Manuel #\= 11, Manuel #\= 10, Manuel #\= 9, Manuel #\= 8, Manuel #\= 7,
	
	Joao #\= 9, Joao #\= 8, Joao #\= 2, Joao #\= 3, Joao #\= 7, Joao #\= 1,
	Miguel #\= 9, Miguel #\= 8, Miguel #\= 2, Miguel #\= 3, Miguel #\= 7, Miguel #\= 1,
	Julio #\= 9, Julio #\= 8, Julio #\= 2, Julio #\= 3, Julio #\= 7, Julio #\= 1,
	Geraldo #\= 9, Geraldo #\= 8, Geraldo #\= 2, Geraldo #\= 3, Geraldo #\= 7, Geraldo #\= 1,
	Nadia #\= 9, Nadia #\= 8, Nadia #\= 2, Nadia #\= 3, Nadia #\= 7, Nadia #\= 1,
	Maria #\= 9, Maria #\= 8, Maria #\= 2, Maria #\= 3, Maria #\= 7, Maria #\= 1,
	
	Geraldo #\= 6, Geraldo #\= 3, Geraldo #\= 9, Geraldo #\= 12,
	Maximo #\= 6, Maximo #\= 3, Maximo #\= 9, Maximo #\= 12,
	Joao #\= 6, Joao #\= 3, Joao #\= 9, Joao #\= 12,
	Silvia #\= 6, Silvia #\= 3, Silvia #\= 9, Silvia #\= 12,
	
	Julio #\= 5, Julio #\= 6, Julio #\= 2, Julio #\= 12, Julio #\= 8, 
	Miguel #\= 5, Miguel #\= 6, Miguel #\= 2, Miguel #\= 12, Miguel #\= 8, 
	Maximo #\= 5, Maximo #\= 6, Maximo #\= 2, Maximo #\= 12, Maximo #\= 8, 
	Manuel #\= 5, Manuel #\= 6, Manuel #\= 2, Manuel #\= 12, Manuel #\= 8, 
	Silvia #\= 5, Silvia #\= 6, Silvia #\= 2, Silvia #\= 12, Silvia #\= 8, 
	Afonso #\= 5, Afonso #\= 6, Afonso #\= 2, Afonso #\= 12, Afonso #\= 8, 
	
	labeling([], People),
	write(People).
	
	
%===========================================================================================================================
% 8
	
restaurant :-
	Peixe is 1, Porco is 2, Pato is 3, Omeleta is 4, Bife is 5, Esparguete is 6,
	People = [Bernard, Daniel, Francisco, Henrique, Jaqueline, Luis],
	domain(People, 1, 6),
	all_distinct(People),
	Daniel #\= Peixe, Jaqueline #\= Peixe,
	Francisco #\= Porco, Francisco #\= Pato,
	Bernard #\= Pato, Bernard #\= Omeleta,
	Daniel #\= Pato, Daniel #\= Omeleta,
	(Bernard #= 2; Bernard #= 3; Bernard #= 5),
	(Francisco #= 2; Francisco #= 3; Francisco #= 5),
	(Henrique #= 2; Henrique #= 3; Henrique #= 5),
	labeling([], People),
	write(People).
	
	
%===========================================================================================================================
% 9

cycling :-
	People = [Carlos, Ricardo, Raul, Tomas, Roberto, Boris, Diego, Luis],
	domain(People, 1, 8),
	all_distinct(People),
	Boris #\= 7,
	Tomas #=< 4,
	Raul #\= 4,
	Tomas #\= 4,
	(Diego #\= 7; Diego #\= 8),
	(Boris #\= 7; Boris #\= 8),
	Roberto #\= 5,
	Raul #\= 5,
	(Carlos #= 1; Carlos #= 2),
	(Luis #= 1; Luis #= 2),
	(Luis #= 2; Luis #= 6; Luis #= 8),
	(Ricardo #= 2; Ricardo #= 6; Ricardo #= 8),
	(Boris #= 2; Boris #= 6; Boris #= 8),
	labeling([], People),
	write(People).
	
%===========================================================================================================================
% 10

election :-
	Armivisti is 130, Baratin is 135, Compromis is 65,
	ABC is 30,
	Attendance = [A, B, C],
	Common = [AB, AC, BC],
	domain(Attendance, 0, 135),
	domain(Common, 0, 135),
	A + B + C #= 200,
	A + AB + AC + ABC #= Armivisti,
	B + AB + BC + ABC #= Baratin,
	C + AC + BC + ABC #= Compromis,
	labeling([], Attendance),
	write(Attendance).
	
%===========================================================================================================================
% 11

sports :-
	PingPong is 1, Footbal is 2, Handball is 3, Rugby is 4, Tennis is 5, Volleyball is 6,	
	People = [Claudio, David, Domingos, Francisco, Marcelo, Paulo],
	domain(People, 1, 6),
	all_distinct(People),
	Marcelo #\= Tennis,
	Francisco #\= Volleyball,
	Paulo #\= Volleyball,
	Domingos #\= Rugby,
	Claudio #\= Handball, Claudio #\= Rugby,
	Francisco #\= Handball, Francisco #\= Rugby,
	David #\= Football,
	David #= Tennis,
	Marcelo #= Football,
	labeling([], People),
	write(People).

%===========================================================================================================================
% 13

race :-
	People = [German, English, Brazilian, Spanish, Italian, French],
	domain(People, 1, 6),
	all_distinct(People),
	
	German #\= 1,    German #\= 5,    German #\= 3,
	Brazilian #\= 1, Brazilian #\= 5, Brazilian #\= 3,
	Spanish #\= 1,   Spanish #\= 5,   Spanish #\= 3,
	
	Spanish #\= 2, Spanish #\= 6,
	
	Italian #\= 3, French #\= 3,
	
	German #\= 2,
	
	Italian #\= 1,
	
	labeling([], People),
	write(People).
	
%===========================================================================================================================
% 16

product :-
	People = [N, L, P, LP, Total],
	domain(People, 0, 10000),
	
	Total #= N + L + P + LP,
	Total #= (N + L)*3,
	Total * 2 #= (N + P)*7,
	LP #= 427,
	Total #= N * 5,
	
	labeling([], People),
	write(People).











	
	
	
	
	
	
	
	
	
	
	
	
	
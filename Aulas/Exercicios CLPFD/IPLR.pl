:- use_module(library(clpfd)).
:- use_module(library(lists)).

%===========================================================================================================================
% 2

zebra :-
	Color = [Red, Yellow, Blue, Green, White],
	Nationality = [English, Spanish, Norwegian, Ukrainian, Portuguese],
	Drink = [OJ, Tea, Coffee, Milk, Water],
	Cigarette = [Marlboro, Chesterfields, Winstons, LuckyStrike, SGLights],
	Animal = [Dog, Fox, Iguana, Horse, Zebra],
	
	domain(Color, 1, 5), all_distinct(Color),
	domain(Nationality, 1, 5), all_distinct(Nationality),
	domain(Drink, 1, 5), all_distinct(Drink),
	domain(Cigarette, 1, 5), all_distinct(Cigarette),
	domain(Animal, 1, 5), all_distinct(Animal),
	
	English #= Red,
	Dog #= Spanish,
	Norwegian #= 1,
	Yellow #= Marlboro,
	Chesterfields #= Fox + 1 #\/ Chesterfields #= Fox - 1,
	Blue #= 2,
	Winstons #= Iguana,
	LuckyStrike #= OJ,
	Ukrainian #= Tea,
	Portuguese #= SGLights,
	Marlboro #= Horse + 1 #\/ Marlboro #= Horse - 1,
	Green #= Coffee,
	White #= Green - 1,
	Milk #= 3,
	
	labeling([], Color),
	labeling([], Nationality),
	labeling([], Drink),
	labeling([], Cigarette),
	labeling([], Animal),
	
	write(Color), nl, write(Nationality), nl, write(Drink), nl,  write(Cigarette), nl,  write(Animal), nl.
	
%===========================================================================================================================






















%child(Name,Gender,WeightAtBirth).
child(john, m, 3.5).
child(mary, f, 4.1).

%weight(Baby,DaysSinceBirth,Weight).
weight(john, 5, 3.3).
weight(john, 10, 3.5).
weight(john, 15, 3.8).
weight(mary, 5, 4.1).
weight(mary, 10, 4.5).
weight(mary, 15, 4.9).

%diapers(Brand,Model,MinWeight,MaxWeight,PricePerDiaper).
diapers(dodot, small, 3, 5, 0.5).
diapers(dodot, medium, 4.5, 6, 0.4).
diapers(libero, small, 2, 4, 0.7).
diapers(libero, medium, 3.5, 5, 0.7).

%boughtFor(Name,Brand,Model,DaysSinceBirth).
boughtFor(john, dodot, small, 1).
boughtFor(mary, libero, small, 0).
boughtFor(john, dodot, small, 5).
boughtFor(mary, dodot, small, 8).



healthyBaby(Gender, Baby) :-
	child(Baby, Gender, WeightAtBirth),
	weight(Baby, _, Weight),!,
	WeightAtBirth =< Weight.

% Não está completamente certo...
diapersBoughtForHealthyBabies([], _, []).
diapersBoughtForHealthyBabies(Brands, Gender, Babies) :-
	tail(Brands, Tail),
	\+healthyBaby(Gender, _),write('asd'),
	diapersBoughtForHealthyBabies(Tail, Gender, Babies).
diapersBoughtForHealthyBabies(Brands, Gender, Babies) :-
	head(Brands, Brand),
	tail(Brands, Tail),
	healthyBaby(Gender, Baby),write(Brand),
	boughtFor(Baby, Brand, _, _),write(Brand),nl,
	diapersBoughtForHealthyBabies(Tail, Gender, BabiesTemp),
	append([Brand-Baby], BabiesTemp, Babies).

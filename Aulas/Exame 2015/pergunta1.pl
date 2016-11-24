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



priceDiapers(Baby, DaysSinceBirth, Brand, Model, Price) :-
	boughtFor(Baby, Brand, Model, DaysSinceBirth),
	diapers(Brand, Model, _, _, Price).


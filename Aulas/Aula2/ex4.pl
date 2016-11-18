% a)
factorial(0, 1).
factorial(N, Valor) :-
	N > 0,
	Ni is N-1,
	factorial(Ni, ValorNew),
	Valor is N*ValorNew.


% b)
fibonacci(0, 1).
fibonacci(1, 1).
fibonacci(N, Fib) :-
	N > 1,
	N1 is N-1,
	N2 is N-2,
	fibonacci(N1, Fib1),
	fibonacci(N2, Fib2),
	Fib is Fib1+Fib2.

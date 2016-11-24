1. Declaração de variáveis
	Ex:
		L=[A,B,C]
		length(L,8)

2. Declaração de Domínios
	Ex:
		X in 0..5 -> inclusive
		domain(L,0,10) -> todas as variáveis de L têm valor mínimo de 0 e máximo de 10

3. Declaração de Restrições (relacionar variáveis entre si)
	Ex:
		A #= B -> A tem de ser igual a B
		X #> Y
		Usamos os operadores todos normais, mas com # sempre atrás

4. Pesquisa de soluções
	Ex:
		labeling([], L)


all_distinct é mais eficiente do que all_different.
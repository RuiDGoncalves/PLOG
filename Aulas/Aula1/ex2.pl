piloto(lamb).
piloto(besenyei).
piloto(chambliss).
piloto(maclean).
piloto(mangold).
piloto(jones).
piloto(bonhomme).

equipa(breitling).
equipa(red_bull).
equipa(mediterranean_racing_team).
equipa(cobra).
equipa(matador).

piloto_equipa(lamb, breitling).
piloto_equipa(besenyei, red_bull).
piloto_equipa(chambliss, red_bull).
piloto_equipa(maclean, mediterranean_racing_team).
piloto_equipa(mangold, cobra).
piloto_equipa(jones, matador).
piloto_equipa(bonhomme, matador).

aviao(mx2).
aviao(edge540).

aviao_piloto(lamb, mx2).
aviao_piloto(besenyei, edge540).
aviao_piloto(chambliss, edge540).
aviao_piloto(maclean, edge540).
aviao_piloto(mangold, edge540).
aviao_piloto(jones, edge540).
aviao_piloto(bonhomme, edge540).

circuito(istambul).
circuito(budapeste).
circuito(porto).

piloto_vencedor(jones, porto).
piloto_vencedor(mangold, budapeste).
piloto_vencedor(mangold, istambul).

piloto_vitorias(jones, 1).
piloto_vitorias(mangold, 2).

gates(istambul, 9).
gates(budapeste, 6).
gates(porto, 5).

equipa_vencedora(Equipa, Corrida) :- piloto_equipa(Piloto, Equipa) , piloto_vencedor(Piloto, Corrida).


/*
	a. piloto_vencedor(Piloto, porto).
	b. equipa_vencedora(Equipa, porto).
	c. piloto_vitorias(Piloto, _N), _N>1.
	d. gates(Circuito, _N), _N>8.
	e. aviao_piloto(Piloto, _Aviao), _Aviao\=edge540.
*/

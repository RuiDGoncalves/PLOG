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

gates(9, istambul).
gates(6, budapeste).
gates(5, porto).

equipa_vencedora(Equipa, Corrida) :- piloto_equipa(Piloto, Equipa) , piloto_vencedor(Piloto, Corrida).

pilotos_um(Piloto, Circuito) :- Circuito>1.

/*
	piloto_vencedor(Piloto, porto).
	equipa_vencedora(Equipa, porto).
*/


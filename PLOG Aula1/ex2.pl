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

equipa_piloto(breitling, lamb).
equipa_piloto(red_bull, besenyei).
equipa_piloto(red_bull, chambliss).
equipa_piloto(mediterranean_racing_team, maclean).
equipa_piloto(cobra, mangold).
equipa_piloto(matador, jones).
equipa_piloto(matador, bonhomme).

aviao(mx2).
aviao(edge540).

aviao_piloto(mx2, lamb).
aviao_piloto(edge540, besenyei).
aviao_piloto(edge540, chambliss).
aviao_piloto(edge540, maclean).
aviao_piloto(edge540, mangold).
aviao_piloto(edge540, jones).
aviao_piloto(edge540, bonhomme).

circuito(istambul).
circuito(budapeste).
circuito(porto).

piloto_vencedor(porto, jones).
piloto_vencedor(budapeste, mangold).
piloto_vencedor(istambul, mangold).

gates(9, instambul).
gates(6, budapeste).
gates(5, porto).

equipa_vencedora(Equipa, Corrida) :- piloto_vencedor(Corrida, Piloto). , equipa_piloto(Equipa, Piloto).



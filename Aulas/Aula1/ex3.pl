livro(maias).
livro(caim).
livro(os_lusiadas).
livro(persuasao).
livro(frankenstein).
livro(objeto_quase).

escritor(eca_de_queiroz).
escritor(jose_saramago).
escritor(luis_de_camoes).
escritor(jane_austen).
escritor(mary_shelley).

nacionalidade(eca_de_queiroz, portuguesa).
nacionalidade(jose_saramago, portuguesa).
nacionalidade(luis_de_camoes, portuguesa).
nacionalidade(jane_austen, inglesa).
nacionalidade(mary_shelley, inglesa).

escreveu(eca_de_queiroz, maias).
escreveu(jose_saramago, caim).
escreveu(luis_de_camoes, os_lusiadas).
escreveu(jane_austen, persuasao).
escreveu(mary_shelley, frankenstein).
escreveu(jose_saramago, objeto_quase).

tipo(ficcao_cientifica).
tipo(romance).
tipo(epico).
tipo(conto).

lingua(portugues).
lingua(ingles).

livro_tipo(maias, romance).
livro_tipo(caim, romance).
livro_tipo(os_lusiadas, epico).
livro_tipo(persuasao, romance).
livro_tipo(frankenstein, ficcao_cientifica).
livro_tipo(objeto_quase, conto).


portugueses_tipoLivro(Escritor, TipoLivro) :-
	nacionalidade(Escritor, portuguesa),
	livro_tipo(Livro, TipoLivro),
	escreveu(Escritor, Livro).


/*
	a. escreveu(Escritor, maias).
	b. portugueses_tipoLivro(Escritor, romance).

*/
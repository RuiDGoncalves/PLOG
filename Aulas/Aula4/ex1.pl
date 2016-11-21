ligado(a,b).
ligado(f,i).
ligado(a,c).
ligado(f,j).
ligado(b,d).
ligado(f,k).
ligado(b,e).
ligado(g,l).
ligado(b,f).
ligado(g,m).
ligado(c,g).
ligado(k,n).
ligado(d,h).
ligado(l,o).
ligado(d,i).
ligado(i,f).


membro(X, [X|_]) :- !.
membro(X, [_|Y]) :-
	membro(X,Y).

inverte([X], [X]).
inverte([X|Y], Lista) :- 
	inverte(Y, Lista1),
	append(Lista1, [X], Lista).

 
/*-------------------------------------------------------------------------------------------------------------
 
	PESQUISA EM PROFUNDIDADE

 -------------------------------------------------------------------------------------------------------------*/

% Faz a pesquisa em profundidado do grafo
resolva_prof(No_inicial, No_meta, Solucao) :-
	profundidade([], No_inicial, No_meta, SolucaoInv),
	inverte(SolucaoInv, Solucao).

profundidade(Caminho, No_meta, No_meta, [No_meta|Caminho]).
profundidade(Caminho, No, No_meta, Sol) :-
	ligado(No, No2),
	\+membro(No2, Caminho),
	profundidade([No|Caminho], No2, No_meta, Sol).


/*-------------------------------------------------------------------------------------------------------------
 
	PESQUISA EM LARGURA

 -------------------------------------------------------------------------------------------------------------*/

ache_todos(X, Y, Z) :-
	bagof(X, Y, Z), !.
ache_todos(_, _, []).

% Estende a fila ate um filho N1 de N, verificando se N1 não pertence à fila, prevenindo, assim, ciclos
estende_ate_filho([N|Trajectoria], [N1, N|Trajectoria]) :-
	ligado(N, N1),
	\+membro(N1, Trajectoria).

% Encontra o caminho Solucao entre No_inicial e No_Meta
resolva_larg(No_inicial, No_meta, Solucao) :-
	largura([[No_inicial]], No_meta, Sol1),
	inverte(Sol1, Solucao).

% Realiza a pesquisa em largura
largura([[No_meta|T]|_], No_meta, [No_meta|T]).
largura([T|Fila], No_meta, Solucao) :-
	ache_todos(ExtensaoAteFilho, estende_ate_filho(T, ExtensaoAteFilho), Extensoes),
	append(Fila, Extensoes, FilaExtendida),
	largura(FilaExtendida, No_meta, Solucao).

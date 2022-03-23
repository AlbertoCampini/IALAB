% cerca_soluzione(-ListaAzioni)
cerca_soluzione(ListaAzioni):-
    iniziale(SIniziale),
    profondita(SIniziale,ListaAzioni,[]).

% profondita(S,ListaAzioni,Visitati)
profondita(S,[],_):-finale(S),!.
profondita(S,[Az|ListaAzioni],Visitati):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+member(SNuovo,Visitati),
    profondita(SNuovo,ListaAzioni,[S|Visitati]).

% cerca_soluzione_soglia(-ListaAzioni,+Soglia)
cerca_soluzione_soglia(ListaAzioni,Soglia):-
    iniziale(SIniziale),
    prof_limitata(SIniziale,ListaAzioni,[],Soglia).

% prof_limitata(S,ListaAzioni,Visitati,Soglia)
prof_limitata(S,[],_,_):-finale(S),!.
prof_limitata(S,[Az|ListaAzioni],Visitati,Soglia):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+member(SNuovo,Visitati),
    Soglia>0,
    NuovaSoglia is Soglia-1,
    prof_limitata(SNuovo,ListaAzioni,[S|Visitati],NuovaSoglia).
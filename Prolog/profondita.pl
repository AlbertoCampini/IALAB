% cerca_soluzione(-ListaAzioni)
cerca_soluzione(ListaAzioni):-
    iniziale(SIniziale),
    checkpoints(Checkpoints).
    profondita(SIniziale,ListaAzioni,[],Checkpoints).

% profondita(S,ListaAzioni,Visitati)
profondita(S,[],_,Checkpoints):-finale(Checkpoints),!.


profondita(S,[Az|ListaAzioni],Visitati,Checkpoints):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+member(SNuovo,Visitati),
    member(SNuovo,Checkpoints),
    delete(SNuovo,Checkpoints,NewCheckPoints),
    profondita(SNuovo,ListaAzioni,[S|Visitati],NewCheckPoints).

profondita(S,[Az|ListaAzioni],Visitati,Checkpoints):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+member(SNuovo,Visitati),
    \+member(SNuovo,Checkpoints),
    profondita(SNuovo,ListaAzioni,[S|Visitati],Checkpoints).
































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
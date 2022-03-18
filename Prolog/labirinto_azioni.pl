% applicabile(AZ,S)
applicabile(nord,pos(Riga,Colonna)):-
    Riga>1,
    RigaSopra is Riga-1,
    \+occupata(pos(RigaSopra,Colonna)).
applicabile(sud,pos(Riga,Colonna)):-
    num_righe(NR),
    Riga<NR,
    RigaSotto is Riga+1,
    \+occupata(pos(RigaSotto,Colonna)).
applicabile(ovest,pos(Riga,Colonna)):-
    Colonna>1,
    ColonnaASinistra is Colonna-1,
    \+occupata(pos(Riga,ColonnaASinistra)).
applicabile(est,pos(Riga,Colonna)):-
    num_col(NC),
    Colonna<NC,
    ColonnaADestra is Colonna+1,
    \+occupata(pos(Riga,ColonnaADestra)).

% trasforma(AZ,S,S_Nuovo)
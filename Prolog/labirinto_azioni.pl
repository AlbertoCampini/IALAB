% applicabile(AZ,S)
applicabile(nord,pos(Riga,Colonna)):-
    Riga > 1,
    RigaSopra is Riga - 1,
    \+occupata(pos(RigaSopra,Colonna)).
applicabile(sud,pos(Riga,Colonna)):-
    num_righe(NR),
    Riga < NR,
    RigaSotto is Riga + 1,
    \+occupata(pos(RigaSotto,Colonna)).
applicabile(ovest,pos(Riga,Colonna)):-
    Colonna > 1,
    ColonnaASinistra is Colonna - 1,
    \+occupata(pos(Riga,ColonnaASinistra)).
applicabile(est,pos(Riga,Colonna)):-
    num_col(NC),
    Colonna < NC,
    ColonnaADestra is Colonna + 1,
    \+occupata(pos(Riga,ColonnaADestra)).

% trasforma(AZ,S,S_Nuovo)
trasforma(nord,pos(Riga,Colonna),pos(RigaSopra,Colonna)):-
    RigaSopra is Riga - 1.

trasforma(sud,pos(Riga,Colonna),pos(RigaSotto,Colonna)):-
RigaSotto is Riga + 1.

trasforma(ovest,pos(Riga,Colonna),pos(Riga,ColonnaSinistra)):-
ColonnaSinistra is Riga - 1.

trasforma(nord,pos(Riga,Colonna),pos(Riga,ColonnaDestra)):-
ColonnaDestra is Colonna + 1.

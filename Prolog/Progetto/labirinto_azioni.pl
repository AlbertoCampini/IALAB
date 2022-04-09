% applicabile(AZ,S)
applicabile(nordEst,pos(Riga,Colonna)):-
    Riga > 1,
    RigaNord is Riga - 1,
    num_col(NC),
    Colonna < NC,
    ColonnaEst is Colonna + 1,
    \+occupata(pos(RigaNord,ColonnaEst)).

applicabile(nordOvest,pos(Riga,Colonna)):-
    Riga > 1,
    RigaNord is Riga - 1,
    Colonna > 1,
    ColonnaOvest is Colonna - 1,
    \+occupata(pos(RigaNord,ColonnaOvest)).

applicabile(sudEst,pos(Riga,Colonna)):-
    num_righe(NR),
    Riga < NR,
    RigaSud is Riga + 1,
    num_col(NC),
    Colonna < NC,
    ColonnaEst is Colonna + 1,
    \+occupata(pos(RigaSud,ColonnaEst)).

applicabile(sudOvest,pos(Riga,Colonna)):-
    num_righe(NR),
    Riga < NR,
    RigaSud is Riga + 1,
    Colonna > 1,
    ColonnaOvest is Colonna - 1,
    \+occupata(pos(RigaSud,ColonnaOvest)).

applicabile(nord,pos(Riga,Colonna)):-
    Riga > 1,
    RigaNord is Riga - 1,
    \+occupata(pos(RigaNord,Colonna)).

applicabile(sud,pos(Riga,Colonna)):-
    num_righe(NR),
    Riga < NR,
    RigaSud is Riga + 1,
    \+occupata(pos(RigaSud,Colonna)).

applicabile(ovest,pos(Riga,Colonna)):-
    Colonna > 1,
    ColonnaOvest is Colonna - 1,
    \+occupata(pos(Riga,ColonnaOvest)).

applicabile(est,pos(Riga,Colonna)):-
    num_col(NC),
    Colonna < NC,
    ColonnaEst is Colonna + 1,
    \+occupata(pos(Riga,ColonnaEst)).



% trasforma(AZ,S,S_Nuovo)
trasforma(nord,pos(Riga,Colonna),pos(RigaNord,Colonna)):-
    RigaNord is Riga - 1.

trasforma(sud,pos(Riga,Colonna),pos(RigaSud,Colonna)):-
    RigaSud is Riga + 1.

trasforma(ovest,pos(Riga,Colonna),pos(Riga,ColonnaOvest)):-
    ColonnaOvest is Colonna - 1.

trasforma(est,pos(Riga,Colonna),pos(Riga,ColonnaEst)):-
    ColonnaEst is Colonna + 1.

trasforma(nordEst,pos(Riga,Colonna),pos(RigaNord,ColonnaEst)):-
    ColonnaEst is Colonna + 1,
    RigaNord is Riga - 1.

trasforma(nordOvest,pos(Riga,Colonna),pos(RigaNord,ColonnaOvest)):-
    ColonnaOvest is Colonna - 1,
    RigaNord is Riga - 1.

trasforma(sudEst,pos(Riga,Colonna),pos(RigaSud,ColonnaEst)):-
    ColonnaEst is Colonna + 1,
    RigaSud is Riga + 1.

trasforma(sudOvest,pos(Riga,Colonna),pos(RigaSud,ColonnaOvest)):-
    ColonnaOvest is Colonna - 1,
    RigaSud is Riga + 1.

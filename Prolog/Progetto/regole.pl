%Cerca soluzione senza utilizzare euristiche

% cerca_soluzione_blind(-ListaAzioni)
cerca_soluzione_blind(ListaAzioni):-
    iniziale(SIniziale),
    checkpoints(Checkpoints),
    profondita_blind(SIniziale,ListaAzioni,[],Checkpoints).

% profondita_blind(S,ListaAzioni,Visitati)
profondita_blind(_,[],_,Checkpoints):-finale(Checkpoints),!.


profondita_blind(S,[Az|ListaAzioni],Visitati,Checkpoints):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+member(SNuovo,Visitati),
    update_checkpoints(S,Checkpoints,NewCheckPoints),
    profondita_blind(SNuovo,ListaAzioni,[S|Visitati],NewCheckPoints).


%Cerca soluzione con uso di euristiche

% cerca_soluzione_informed(-ListaAzioni)
cerca_soluzione_informed(ListaAzioni):-
    iniziale(SIniziale),
    checkpoints(Checkpoints),
    profondita_blind(SIniziale,ListaAzioni,[],Checkpoints).

% profondita_informed(S,ListaAzioni,Visitati)
profondita_informed(_,[],_,Checkpoints):-finale(Checkpoints),!.


profondita_informed(S,[Az|ListaAzioni],Visitati,Checkpoints):-

    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+member(SNuovo,Visitati),
    update_checkpoints(S,Checkpoints,NewCheckPoints),
    profondita_blind(SNuovo,ListaAzioni,[S|Visitati],NewCheckPoints).







%Utils
% closestCheckPoint(-S,-Checkpoints,+ChosenCheckpoint)
closestCheckPoint(S,[pos(Riga,Colonna)|Tail],RealMin,RealMinDistance):-
    distance(S,pos(Riga,Colonna),Distance),
    NewRiga is Riga,
    NewColonna is Colonna,
    findMin(S,Distance,pos(NewRiga,NewColonna),Tail,RealMin,RealMinDistance).

findMin(_,ActualMin,pos(MinRiga,MinColonna),[],pos(RealMinRiga,RealMinColonna),RealMinDistance):-RealMinRiga is MinRiga, RealMinColonna is MinColonna,RealMinDistance is ActualMin.

%findMin(Posizione attuale, Distanza minima della ricerca, Checkpoint con distanza minima della ricerca, Lista Checkpoints ancora da esplorare)
findMin(S,ActualMinDistance,ActualMinCheckPoint,[Head|Tail],RealMin,RealMinDistance):-
    distance(S,Head,Distance),
    updateMin(ActualMinDistance,ActualMinCheckPoint,Distance,Head,NewMin,NewCheckPoint),
    findMin(S,NewMin,NewCheckPoint,Tail,RealMin,RealMinDistance).


% distance(-Start,-Target,+Distance)
distance(pos(Riga,Colonna),pos(RigaTarget,ColonnaTarget),Distance):-
     DistanceRighe is Riga - RigaTarget,
     absolute(DistanceRighe,DistanceRigheAbs),
     DistanceColonne is Colonna - ColonnaTarget,
     absolute(DistanceColonne,DistanceColonneAbs),       %ManHattan
     DistanceRigheAbs>DistanceColonneAbs,
     Distance is DistanceRigheAbs.                             %Using diagonal movement

    distance(pos(Riga,Colonna),pos(RigaTarget,ColonnaTarget),Distance):-
        DistanceRighe is Riga - RigaTarget,
     absolute(DistanceRighe,DistanceRigheAbs),
     DistanceColonne is Colonna - ColonnaTarget,
     absolute(DistanceColonne,DistanceColonneAbs),       %ManHattan
     DistanceRigheAbs@=<DistanceColonneAbs,
     Distance is DistanceColonneAbs.                                 %Using diagonal movement


updateMin(ActualMinDistance,_,Distance,pos(ActualElementRiga,ActualElementColonna),NewMin,pos(NewCheckPointRiga,NewCheckpointColonna)):-
    Distance<ActualMinDistance,
    NewMin is Distance,
    NewCheckPointRiga is ActualElementRiga,
    NewCheckpointColonna is ActualElementColonna.
updateMin(ActualMinDistance,pos(ActualMinRiga,ActualMinColonna),Distance,_,NewMin,pos(NewCheckPointRiga,NewCheckpointColonna)):-
    ActualMinDistance @=< Distance,
    NewMin is ActualMinDistance,
    NewCheckPointRiga is ActualMinRiga,
    NewCheckpointColonna is ActualMinColonna.

absolute(X,X):-0@=<X,!.
absolute(X,Y):-X<0 ,Y is X * -1.


% update_checkpoints(-S,-CheckPoints,+NewCheckPoints)
update_checkpoints(S,Checkpoints,NewCheckPoints):-
    member(S,Checkpoints),
    delete(Checkpoints,S,NewCheckPoints).
update_checkpoints(S,Checkpoints,Checkpoints):-
    \+member(S,Checkpoints).































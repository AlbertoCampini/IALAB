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
    update_checkpoints(SNuovo,Checkpoints,NewCheckPoints),
    profondita_blind(SNuovo,ListaAzioni,[S|Visitati],NewCheckPoints).


%Cerca soluzione con uso di euristiche

% cerca_soluzione_informed(-ListaAzioni)
cerca_soluzione_informed(ListaAzioni):-
    iniziale(SIniziale),
    checkpoints(Checkpoints),
    profondita_informed(SIniziale,ListaAzioni,[],Checkpoints).

% profondita_informed(S,ListaAzioni,Visitati)
profondita_informed(_,[],_,Checkpoints):-finale(Checkpoints).


profondita_informed(S,[AzioneMigliore|ListaAzioni],Visitati,Checkpoints):-
    closestCheckPoint(S,Checkpoints,ChoosenCheckpoint,_),                                   %cerco il target più vicino
    findall(Az,applicabile(Az,S),ListaAzioniApplicabili),                                   %cerco tutte le azioni applicabili nello stato attuale
    merge_sort(ListaAzioniApplicabili,ListaAzioniOrdinate,S,ChoosenCheckpoint),             %valuto le azioni possibili scegliendo quella che minimizza la distanza verso il checkpoint piu vicino 
    write(ListaAzioniOrdinate),write('\n'),
    member(AzioneMigliore,ListaAzioniOrdinate),
    trasforma(AzioneMigliore,S,SNuovo),
    \+member(SNuovo,Visitati),
    update_checkpoints(SNuovo,Checkpoints,NewCheckPoints),
    profondita_informed(SNuovo,ListaAzioni,[S|Visitati],NewCheckPoints).




%Utils

merge_sort([],[],_,_):-!.     % empty list is already sorted
merge_sort([X],[X],_,_):-!.   % single element list is already sorted
merge_sort(List,Sorted,pos(ActualRow,ActualCol),pos(TargetRow,TargetCol)):-
    List=[_,_|_],divide(List,L1,L2),     % list with at least two elements is divided into two parts
	merge_sort(L1,Sorted1,pos(ActualRow,ActualCol),pos(TargetRow,TargetCol)),merge_sort(L2,Sorted2,pos(ActualRow,ActualCol),pos(TargetRow,TargetCol)),  % then each part is sorted
	merge(Sorted1,Sorted2,Sorted,pos(ActualRow,ActualCol),pos(TargetRow,TargetCol)).                  % and sorted parts are merged
merge([],L,L,_,_):-!.
merge(L,[],L,_,_):-L\=[],!.
merge([X|T1],[Y|T2],[X|T],pos(ActualRow,ActualCol),pos(TargetRow,TargetCol)):-
    trasforma(X,pos(ActualRow,ActualCol),pos(NewRowX,NewColX)),
    trasforma(Y,pos(ActualRow,ActualCol),pos(NewRowY,NewColY)),
    distance(pos(NewRowX,NewColX),pos(TargetRow,TargetCol),DistanceX),
    distance(pos(NewRowY,NewColY),pos(TargetRow,TargetCol),DistanceY),
    DistanceX=<DistanceY,!,
    merge(T1,[Y|T2],T).
merge([X|T1],[Y|T2],[Y|T],pos(ActualRow,ActualCol),pos(TargetRow,TargetCol)):-
    trasforma(X,pos(ActualRow,ActualCol),pos(NewRowX,NewColX)),
    trasforma(Y,pos(ActualRow,ActualCol),pos(NewRowY,NewColY)),
    distance(pos(NewRowX,NewColX),pos(TargetRow,TargetCol),DistanceX),
    distance(pos(NewRowY,NewColY),pos(TargetRow,TargetCol),DistanceY),
    DistanceX>DistanceY,!,
    merge([X|T1],T2,T).

divide(L,L1,L2):-split_in_half(L,L1,L2).

split_in_half(Xs, Ys, Zs) :-  
    length(Xs, Len),
    Half is Len // 2,    % // denotes integer division, rounding down
    split_at(Xs, Half, Ys, Zs).

split_at(Xs, N, Ys, Zs) :- length(Ys, N), append(Ys, Zs, Xs).



%valutaAzione(-posIniziale,-listaAzioniApplicabili,-CheckpointTarget,+AzioneMigliore)
valutaAzioni(pos(PosRiga,PosColonna),[FirstAzione | AltreAzioni],pos(CheckpointRiga,CheckpointColonna),FinalBestAction) :-
    trasforma(FirstAzione,pos(PosRiga,PosColonna),pos(NewRiga,NewColonna)),
    distance(pos(NewRiga,NewColonna),pos(CheckpointRiga,CheckpointColonna),DistanceBestAction),
    %AzioneMigliore is FirstAzione,
    findBestAction(pos(PosRiga,PosColonna),AltreAzioni,pos(CheckpointRiga,CheckpointColonna),FirstAzione,DistanceBestAction,FinalBestAction,_).


findBestAction(_,[],_,AzioneMigliore,DistanceBestAction,AzioneMigliore,DistanceBestAction).

findBestAction(pos(PosRiga,PosColonna),[FirstAzione|AltreAzioni],pos(CheckpointRiga,CheckpointColonna),AzioneMigliore,DistanceBestAction,FinalBestAction,_):-
    trasforma(FirstAzione,pos(PosRiga,PosColonna),pos(NewRiga,NewColonna)),
    distance(pos(NewRiga,NewColonna),pos(CheckpointRiga,CheckpointColonna),NewDistance),
    updateMinAction(AzioneMigliore,DistanceBestAction,FirstAzione,NewDistance,ResultAction,ResultDistance),
    findBestAction(pos(PosRiga,PosColonna),AltreAzioni,pos(CheckpointRiga,CheckpointColonna),ResultAction,ResultDistance,FinalBestAction,_).

% closestCheckPoint(-S,-Checkpoints,+ChosenCheckpoint)
closestCheckPoint(S,[pos(Riga,Colonna)|Tail],RealMin,RealMinDistance):-
    distance(S,pos(Riga,Colonna),Distance),
    NewRiga is Riga,
    NewColonna is Colonna,
    findMin(S,Distance,pos(NewRiga,NewColonna),Tail,RealMin,RealMinDistance).

findMin(_,ActualMin,pos(MinRiga,MinColonna),[],pos(RealMinRiga,RealMinColonna),RealMinDistance):-RealMinRiga is MinRiga, RealMinColonna is MinColonna,RealMinDistance is ActualMin.

%findMin(Posizione attuale, Distanza minima della ricerca, Checkpoint con distanza minima della ricerca, Lista Checkpoints ancora da esplorare, Variabile per salvare output, Variabile per dalvare output)
findMin(S,ActualMinDistance,ActualMinCheckPoint,[Head|Tail],RealMin,RealMinDistance):-
    distance(S,Head,Distance),
    updateMin(ActualMinDistance,ActualMinCheckPoint,Distance,Head,NewMin,NewCheckPoint),
    findMin(S,NewMin,NewCheckPoint,Tail,RealMin,RealMinDistance).


% distance(-Start,-Target,+Distance)
distance(pos(Riga,Colonna),pos(RigaTarget,ColonnaTarget),Distance):-
     DistanceRighe is Riga - RigaTarget,
     absolute(DistanceRighe,DistanceRigheAbs),
     DistanceColonne is Colonna - ColonnaTarget,
     absolute(DistanceColonne,DistanceColonneAbs),                      %ManHattan
     Distance is DistanceRigheAbs + DistanceColonneAbs.                                  



updateMin(ActualMinDistance,_,Distance,pos(ActualElementRiga,ActualElementColonna),NewMin,pos(NewCheckPointRiga,NewCheckpointColonna)):-
    Distance<ActualMinDistance,
    NewMin is Distance,
    NewCheckPointRiga is ActualElementRiga,
    NewCheckpointColonna is ActualElementColonna.
updateMin(ActualMinDistance,pos(ActualMinRiga,ActualMinColonna),Distance,_,NewMin,pos(NewCheckPointRiga,NewCheckpointColonna)):-
    ActualMinDistance =< Distance,
    NewMin is ActualMinDistance,
    NewCheckPointRiga is ActualMinRiga,
    NewCheckpointColonna is ActualMinColonna.

updateMinAction(ActualAction,ActualMin,_,NewMin,ActualAction,ActualMin):-
     ActualMin<NewMin.

updateMinAction(_,ActualMin,NewAction,NewMin,NewAction,NewMin):-
    NewMin @=< ActualMin.

absolute(X,X):- 0=<X,!.
absolute(X,Y):- X<0 ,Y is X * -1,!.


% update_checkpoints(-S,-CheckPoints,+NewCheckPoints)
update_checkpoints(S,Checkpoints,NewCheckPoints):-
    member(S,Checkpoints),
    delete(Checkpoints,S,NewCheckPoints).
update_checkpoints(S,Checkpoints,Checkpoints):-
    \+member(S,Checkpoints).































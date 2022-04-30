%Cerca soluzione senza utilizzare euristiche

% cerca_soluzione_blind(-ListaAzioni)
cerca_soluzione_blind(ListaAzioni):-
    iniziale(SIniziale),
    checkpoints(Checkpoints),
    profondita_blind(SIniziale,ListaAzioni,[],Checkpoints).

% profondita_blind(+Stato,-ListaAzioni,+Visitati,+CheckPoints)
profondita_blind(_,[],_,Checkpoints):-finale(Checkpoints),!.

% profondita_blind(+Stato,-ListaAzioni,+Visitati,+CheckPoints)
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

% profondita_informed(+Stato,-ListaAzioni,+Visitati,+Checkpoints)
profondita_informed(_,[],_,Checkpoints):-finale(Checkpoints).

% profondita_informed(+Stato,-ListaAzioni,+Visitati,+Checkpoints)
profondita_informed(S,[AzioneMigliore|ListaAzioni],Visitati,Checkpoints):-
    closestCheckPoint(S,Checkpoints,ChoosenCheckpoint,_),                                   %cerco il target più vicino
    findall(Az,applicabile(Az,S),ListaAzioniApplicabili),                                   %cerco tutte le azioni applicabili nello stato attuale
    merge_sort(ListaAzioniApplicabili,ListaAzioniOrdinate,S,ChoosenCheckpoint),             %valuto le azioni possibili scegliendo quella che minimizza la distanza verso il checkpoint piu vicino 
    member(AzioneMigliore,ListaAzioniOrdinate),
    trasforma(AzioneMigliore,S,SNuovo),
    \+member(SNuovo,Visitati),
    update_checkpoints(SNuovo,Checkpoints,NewCheckPoints),
    profondita_informed(SNuovo,ListaAzioni,[S|Visitati],NewCheckPoints).



%cerca_soluzione_informed2(-ListaAzioni)
cerca_soluzione_informed2(ListaAzioni):-
    iniziale(SIniziale),
    checkpoints(Checkpoints),
    profondita_informed2(SIniziale,ListaAzioni,[],Checkpoints).

%profondita_informed2(+Stato,-ListaAzioni,+Visitati,+Checkpoints)
profondita_informed2(_,[],_,Checkpoints):-finale(Checkpoints).
%profondita_informed2(+Stato,-ListaAzioni,+Visitati,+Checkpoints,-Direction)
profondita_informed2(_,[],_,Checkpoints,_):-finale(Checkpoints).


%profondita_informed2(+Stato,-ListaAzioni,+Visitati,+Checkpoints)   Versione che continua in modo informato normale verso il checkpoint
profondita_informed2(S,[AzioneScelta|ListaAzioni],Visitati,Checkpoints):-
    closestCheckPoint(S,Checkpoints,ChoosenCheckpoint,_),                                   %cerco il target più vicino
    findall(Az,trasforma(Az,pos(0,0),_),ListaAzioniApplicabili),                           %cerco tutte le azioni 
    merge_sort(ListaAzioniApplicabili,[AzioneMigliore|_],S,ChoosenCheckpoint),             %valuto le azioni scegliendo quella che minimizza la distanza verso il checkpoint piu vicino 
    generateOrderedActions(AzioneMigliore,OrderedActions),                                  %genero una lista di azioni applicabili in base alla azione migliore
    %print(OrderedActions),print('\n'),
    member(AzioneScelta,OrderedActions),
    applicabile(AzioneScelta,S),
    trasforma(AzioneScelta,S,SNuovo),
    \+member(SNuovo,Visitati),
    AzioneScelta==AzioneMigliore,
    update_checkpoints_and_visited(SNuovo,Checkpoints,NewCheckPoints,Visitati,NewVisitati),
    profondita_informed2(SNuovo,ListaAzioni,NewVisitati,NewCheckPoints).

%profondita_informed2(+Stato,-ListaAzioni,+Visitati,+Checkpoints)   Versione che continua con direzione
profondita_informed2(S,[AzioneScelta|ListaAzioni],Visitati,Checkpoints):-
    closestCheckPoint(S,Checkpoints,ChoosenCheckpoint,_),                                   %cerco il target più vicino
    findall(Az,trasforma(Az,pos(0,0),_),ListaAzioniApplicabili),                           %cerco tutte le azioni 
    merge_sort(ListaAzioniApplicabili,[AzioneMigliore|_],S,ChoosenCheckpoint),             %valuto le azioni scegliendo quella che minimizza la distanza verso il checkpoint piu vicino 
    generateOrderedActions(AzioneMigliore,OrderedActions),                                  %genero una lista di azioni applicabili in base alla azione migliore
    %print(OrderedActions),print('\n'),
    member(AzioneScelta,OrderedActions),
    applicabile(AzioneScelta,S),
    trasforma(AzioneScelta,S,SNuovo),
    \+member(SNuovo,Visitati),
    AzioneScelta\=AzioneMigliore,
    update_checkpoints_and_visited(SNuovo,Checkpoints,NewCheckPoints,Visitati,NewVisitati),
    profondita_informed2(SNuovo,ListaAzioni,NewVisitati,NewCheckPoints,AzioneMigliore).

%profondita_informed2(+Stato,-ListaAzioni,+Visitati,+Checkpoints,-Direction)    Versione della ricerca che sa già in che direzione andare e continua in modalità senza direzione
profondita_informed2(S,[AzioneScelta|ListaAzioni],Visitati,Checkpoints,Direction):-
    generateOrderedActions(Direction,OrderedActions),                                  %genero una lista di azioni applicabili in base alla azione migliore
    %print(OrderedActions),print('\n'),
    member(AzioneScelta,OrderedActions),
    applicabile(AzioneScelta,S),
    trasforma(AzioneScelta,S,SNuovo),
    \+member(SNuovo,Visitati),
    AzioneScelta==Direction,
    update_checkpoints_and_visited(SNuovo,Checkpoints,NewCheckPoints,Visitati,NewVisitati),
    profondita_informed2(SNuovo,ListaAzioni,NewVisitati,NewCheckPoints).

%profondita_informed2(+Stato,-ListaAzioni,+Visitati,+Checkpoints,-Direction)    Versione della ricerca che sa già in che direzione andare e continua in modalità con direzione
profondita_informed2(S,[AzioneScelta|ListaAzioni],Visitati,Checkpoints,Direction):-
    generateOrderedActions(Direction,OrderedActions),                                  %genero una lista di azioni applicabili in base alla azione migliore
    %print(OrderedActions),print('\n'),
    member(AzioneScelta,OrderedActions),
    applicabile(AzioneScelta,S),
    trasforma(AzioneScelta,S,SNuovo),
    \+member(SNuovo,Visitati),
    AzioneScelta\=Direction,
    update_checkpoints_and_visited(SNuovo,Checkpoints,NewCheckPoints,Visitati,NewVisitati),
    profondita_informed2(SNuovo,ListaAzioni,NewVisitati,NewCheckPoints,Direction).

%Utils
%merge_sort(+Array,-ArrayOrdinato,+Posizione attuale, +Target)  Dato un array di mosse calcolando la distanza rispetto alla posizione attuale verso il target ordino l'array dalla mossa migliore alla peggiore
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



%valutaAzione(+posIniziale,+listaAzioniApplicabili,+CheckpointTarget,-AzioneMigliore) Prima implementazione della versione informata utilizzava questa regola per trovare l'azione migliore, non permetteva uso di backtracking
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


% closestCheckPoint(+Stato,+Checkpoints,-ChosenCheckpoint) Restituisce checkpoint più vicino basandosi sulla distanza di Manhattan
closestCheckPoint(S,[pos(Riga,Colonna)|Tail],RealMin,RealMinDistance):-
    distance(S,pos(Riga,Colonna),Distance),
    NewRiga is Riga,
    NewColonna is Colonna,
    findMin(S,Distance,pos(NewRiga,NewColonna),Tail,RealMin,RealMinDistance).



%findMin(+Posizione attuale,+ Distanza minima della ricerca,+ Checkpoint con distanza minima della ricerca, +Lista Checkpoints ancora da esplorare,-CheckPoint più vicino, - Distanza Checkpoint più vicino)

findMin(_,ActualMin,pos(MinRiga,MinColonna),[],pos(RealMinRiga,RealMinColonna),RealMinDistance):-RealMinRiga is MinRiga, RealMinColonna is MinColonna,RealMinDistance is ActualMin.

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


%updateMin(+Distanza minima fin ora, +Posizione di distanza minima, +Distanza elemento attuale, +Posizione elemento attuale, -Distanza minima tra le due, -Posizione minima tra le due)
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

%updateMinAction(+Azione attuale, +Minimo di distanza,+Nuova Azione, -Nuovo minimo, -Minimo tra i due, -Azione minima)
updateMinAction(ActualAction,ActualMin,_,NewMin,ActualAction,ActualMin):-
     ActualMin<NewMin.

updateMinAction(_,ActualMin,NewAction,NewMin,NewAction,NewMin):-
    NewMin @=< ActualMin.

absolute(X,X):- 0=<X,!.
absolute(X,Y):- X<0 ,Y is X * -1,!.


% update_checkpoints(+S,+CheckPoints,-NewCheckPoints)
update_checkpoints(S,Checkpoints,NewCheckPoints):-
    member(S,Checkpoints),
    delete(Checkpoints,S,NewCheckPoints).
update_checkpoints(S,Checkpoints,Checkpoints):-
    \+member(S,Checkpoints).

% update_checkpoints_and_visited(+S,+CheckPoints,-NewCheckPoints) 
update_checkpoints_and_visited(S,Checkpoints,NewCheckPoints,_,[S]):-
    member(S,Checkpoints),
    delete(Checkpoints,S,NewCheckPoints).
update_checkpoints_and_visited(S,Checkpoints,Checkpoints,Visited,[S|Visited]):-
    \+member(S,Checkpoints).

%generateOrderedActions (+BestAction,-OrderedActions)
generateOrderedActions(sud,[sud,sudEst,sudOvest,est,ovest,nordEst,nordOvest,nord]).
generateOrderedActions(sudEst,[sudEst,sud,est,ovest,nord,nordEst,sudOvest,nordOvest]).
generateOrderedActions(sudOvest,[sudOvest,sud,ovest,est,nord,nordOvest,sudEst,nordEst]).
generateOrderedActions(est,[est,nordEst,sudEst,sud,nord,ovest,nordOvest,sudOvest]).
generateOrderedActions(ovest,[ovest,nordOvest,sudOvest,sud,nord,est,nordEst,sudEst]).
generateOrderedActions(nord,[nord,nordEst,nordOvest,est,ovest,sudEst,sudOvest,sud]).
generateOrderedActions(nordEst,[nordEst,nord,est,ovest,sud,sudEst,nordOvest,sudOvest]).
generateOrderedActions(nordOvest,[nordOvest,nord,ovest,est,sud,sudOvest,nordEst,sudEst]).






























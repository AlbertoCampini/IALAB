% Data un alista voglio contare i numeri positivi

conta_positivi([],0).
conta_positivi([Head|Tail],P):-
    Head >= 0,
    !,                                      % Faccio cut tanto ho trovato quello che dovevo trovare
    conta_positivi(Tail,PTail),
    P is PTail + 1.
conta_positivi([_|Tail],P):-                % Vorrei usare questo passo come un else se non è positivo non ricontrollo ma assumo che sia negativo per fare questo devo aggiungere un cut alla fine del predicato che controlla se è positivo
    conta_positivi(Tail,P).
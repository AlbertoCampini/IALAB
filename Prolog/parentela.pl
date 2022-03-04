%Rappresentazione delle parentele
%Fatti
parent(paolo,mario).                                % Rappresenta genitore figlio come coppia
parent(paolo,luisa).
parent(anna,luisa).
parent(anna,mario).
parent(mario,chiara).
parent(antonella,chiara).
parent(mario,alberto).
parent(francesca,alberto).

parent(marco,serena).
parent(serena,fabrizio).
parent(fabrizio,lorenzo).

%Regole

granparent(X,Y) :- parent(X,Z),parent(Z,Y).         % Per capire se X è nonno di Y bisogna individuare un Z che è parent di Y e figlio di X

antenato(X,Y) :- parent(X,Y).
antenato(X,Y) :- granparent(X,Y).                   % In realta' questa clausola e' ridondante pero' non da fastidio
antenato(X,Y) :- parent(X,Z),antenato(Z,Y).         

fratelloGermano(A,B) :-                             % Hanno sia madre che padre in comune
    parent(Padre, A),
    parent(Madre, A),
    parent(Padre, B),
    parent(Madre, B).
/*

Seconda Lezione 03-03-2022

[trace] 3 ?- granparent(paolo,Nipote).
   Call: (10) granparent(paolo, _8016) ? creep
   Call: (11) parent(paolo, _9204) ? creep
   Exit: (11) parent(paolo, mario) ? creep
   Call: (11) parent(mario, _8016) ? creep
   Exit: (11) parent(mario, chiara) ? creep
   Exit: (10) granparent(paolo, chiara) ? creep
Nipote = chiara ;                                   % Paolo è nonno di chiara
   Redo: (11) parent(mario, _8016) ? creep
   Exit: (11) parent(mario, alberto) ? creep
   Exit: (10) granparent(paolo, alberto) ? creep
Nipote = alberto ;                                  % Paolo è nonno di alberto
   Redo: (11) parent(paolo, _9204) ? creep
   Exit: (11) parent(paolo, luisa) ? creep
   Call: (11) parent(luisa, _8016) ? creep
   Fail: (11) parent(luisa, _8016) ? creep
   Fail: (10) granparent(paolo, _8016) ? creep
false.                                              % Quando becca false prova a fare backtrace ma non trova nulla quindi restituisce false


antenato(Antenato,Discendente).                     % Utilizzo due variabili per 
Antenato = paolo,
Discendente = mario .



*/

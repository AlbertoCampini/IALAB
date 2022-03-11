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

granparent(X,Y) :- parent(X,Z),parent(Z,Y).           % Per capire se X è nonno di Y bisogna individuare un Z che è parent di Y e figlio di X

antenato(X,Y) :- parent(X,Y).
%antenato(X,Y) :- granparent(X,Y).                    % In realta' questa clausola e' ridondante pero' non da fastidio
antenato(X,Y) :- parent(X,Z),antenato(Z,Y).         

fratelloGermano(A,B) :-                               % Hanno sia madre che padre in comune usare la stessa variabile implica che abbia un solo valore quindi padre e madre avranno due valori
    % A \== B,                                        % Per evitare che fratello(mario,mario) dia True quindi che A e B siano uguali ma questo non basta sempre (riga 104) -> non è una regola ma un predicato che prolog prova a dimostare
    parent(Padre, A),
    parent(Madre, A),
    Padre \== Madre,                                  % Hanno Tutti e due i genitori uguali
    parent(Padre, B),
    parent(Madre, B),
    A \== B.  


fratelloUnilaterale(A,B)                             % Vogliamo che sia solo un genitore comune e l'altro sia diverso per forza, qundi che l'insieme di fratelloUnilaterale e fratellogermano sia disgiunto
    parent(GenitoreComune,A),
    parent(GenitoreComune,B),
    A \== B,
    parent(GenitoreA, A),
    parent(GenitoreB, B),
    GenitoreA \== GenitoreB,
    GenitoreB \== GenitoreComune,
    GenitoreA \== GenitoreComune.

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



Terza Lezione 08-03-2022

Principio di ricorsione su prolog, analizzando il la regola antenato

Dimostrazione che marco sia antenato di lorenzo
  Call: (10) antenato(marco, lorenzo) ? creep
   Call: (11) parent(marco, lorenzo) ? creep
   Fail: (11) parent(marco, lorenzo) ? creep
   Redo: (10) antenato(marco, lorenzo) ? creep
   Call: (11) granparent(marco, lorenzo) ? creep
   Call: (12) parent(marco, _11068) ? creep
   Exit: (12) parent(marco, serena) ? creep
   Call: (12) parent(serena, lorenzo) ? creep
   Fail: (12) parent(serena, lorenzo) ? creep
   Fail: (11) granparent(marco, lorenzo) ? creep
   Redo: (10) antenato(marco, lorenzo) ? creep
   Call: (11) parent(marco, _15594) ? creep
   Exit: (11) parent(marco, serena) ? creep
   Call: (11) antenato(serena, lorenzo) ? creep
   Call: (12) parent(serena, lorenzo) ? creep
   Fail: (12) parent(serena, lorenzo) ? creep
   Redo: (11) antenato(serena, lorenzo) ? creep
   Call: (12) granparent(serena, lorenzo) ? creep
   Call: (13) parent(serena, _20874) ? creep
   Exit: (13) parent(serena, fabrizio) ? creep
   Call: (13) parent(fabrizio, lorenzo) ? creep    % Qui capisco che Lorenzo e' figlio di fabrizio che a sua volta e' figlio di serena, figlia di marco quindi dimostro il caso base
   Exit: (13) parent(fabrizio, lorenzo) ? creep
   Exit: (12) granparent(serena, lorenzo) ? creep
   Exit: (11) antenato(serena, lorenzo) ? creep
   Exit: (10) antenato(marco, lorenzo) ? creep


   Se scambiassimo l'ordine delle clausole come segue:

   antenato(X,Y) :- parent(X,Z),antenato(Z,Y). 
   antenato(X,Y) :- parent(X,Y).

   Dal punto di vista della conoscenza non fa una piega pero' nasce un problema andiamo in loop ottenendo una stack overflow 
   Da questo impariamo che è opportuno inserire come prima cosa il caso base

   Se io vado a fare il trace su fratelloGermano(mario,mario) la risposta è giustamente false
   Tutta via se gli chiedo chi sono i fratelli germani di marco con fratelloGermano(mario,X)
   fratelloGermano(mario,X).
   X = mario

   Mi propone mario ma questo perche?
   Call: (10) fratelloGermano(mario, _7016) ? creep
   Call: (11) mario\==_7016 ? creep          % Notiamo che la variabile non è istanzata quindi il confronto passa, 
   Exit: (11) mario\==_7016 ? creep
   Call: (11) parent(_9712, mario) ? creep
   Exit: (11) parent(paolo, mario) ? creep

   Abbiamo capito che il confronto tra A e B deve essere inserito qando tutte le variabili sono istanziate quindi al fondo o comunque dopo la terza definizione.

   I problemi non sono finiti qui: padre e madre sono due variabili non implica che siano diverse infatti se provo a dimostare che due persone con un solo genitore in comune prolog dice treu, per evitare questo devo aggiungere una clausola (riga 28)


*/

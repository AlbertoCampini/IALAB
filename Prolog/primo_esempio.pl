% Fatti -> e' tutto , il predicato e' la funzione senza l'argomento
gatto(tom).
gatto(fred).
tigre(mike).
vivo(tom).


% Regole, definisco X maiscola per idetificare una variabile
felino(X) :- gatto(X).
felino(X) :- tigre(X).
miagola(X) :- gatto(X),vivo(X).             % Tutti gli X che sono gatti e sono vivi allora miagolano, vengono considerati in AND logico

/* Prima Lezione 02-03-2022
Commenti per esecuzione:
Istruzioni Prolog per interrogare la risorsa creata

risorsa SWI-Prolog: https://www.swi-prolog.org/Download.html

CMD: swipl in ambiante WIN

['primo-esempio.pl']

gatto(tom).

felino(tom).

gatto(mike).

trace.                                      % -> per ottenere i passaggi che fa per dimostrare il fatto

gatto(Chi).                                 % NB: Chi ha la lettera maiuscola quindi e' una variabile, noi ci aspettiamo che ci risponda con tutti i gatti
Chi = tom ;                                 % Significa che se istanzio la varibile Chi con tom il risultato e' true, se seguo con un ';' prolog mi propone l'altrenativa a tom cioe fred
Chi = fred.
                                            % Stiamo effettuando Assunzioni di mondo chiuso, quello che non puo dimostrare e' falso. Spoiler la negazione classica non esiste perche' in prolog rappresentiamo una fetta della logica classica
                                            % Un esempio che non posso fare in prolog e' che i pinguini sono uccelli e non volano, potevo farlo in OWL

felino(Chi).
Chi = tom ;
Chi = fred ;
Chi = mike.

halt. per uscire da prolog


Seconda Lezione 03-03-2022

Analizziamo miagola(tom).

trace.  
miagola(tom).                               % Come prima cosa istanzia a X con tom, successivamente inizia ad analizzare la prima clausola, cioe' gatto(tom), lo trova nella prima clausola dei fatti, successivamente verifica vivo(tom)
   Call: (10) miagola(tom) ? creep
   Call: (11) gatto(tom) ? creep
   Exit: (11) gatto(tom) ? creep
   Call: (11) vivo(tom) ? creep
   Exit: (11) vivo(tom) ? creep
   Exit: (10) miagola(tom) ? creep
true.                                       % Dato che tom è sia un gatto che vivo ne ottengo true

miagola(fred).
   Call: (10) miagola(fred) ? creep
   Call: (11) gatto(fred) ? creep
   Exit: (11) gatto(fred) ? creep
   Call: (11) vivo(fred) ? creep
   Fail: (11) vivo(fred) ? creep
   Fail: (10) miagola(fred) ? creep
false.                                      % Non è dimostrabile che Fred sia vivo quindi fallisce la seconda 

*/
mangia(fred).
graffia(mike).                              % Andiamo a dire che mike e fred sono vivi grazie alle regole appena introdotte

vivo(X) :- graffia(X).                      % Aggiungiamo una regola per definire se è vivo o meno
vivo(X) :- mangia(X).                       % Quindi anche se non so esplicitamente che è vivo in questo modo posso capire se lo è

                                            % Non c'e' bisogno del costrutto per indetificare OR basta aggiungere due regole come abbiamo appena fatto

/*
['primo_esempio.pl']                        % Ricarico il file per ottenre i cambiamenti 
trace.
miagola(fred).                              % Provo a verificare se fred miagola
   Call: (10) miagola(fred) ? creep
   Call: (11) gatto(fred) ? creep           % Verifica con successo che fred e' un gatto
   Exit: (11) gatto(fred) ? creep
   Call: (11) vivo(fred) ? creep            % Prova a dimostrare se fred è vivo
   Call: (12) graffia(fred) ? creep         % Utilizza la prima regola che trova cioè graffia(fred), non trova nulla e fallisce
   Fail: (12) graffia(fred) ? creep
   Redo: (11) vivo(fred) ? creep            % Ci riprova perche' esiste un'altrenativa, cioe' mangia(fred), riesce a dimostrare questa regola, quindi dimostra che fred è vivo. In generale prolog le prova tutte
   Call: (12) mangia(fred) ? creep
   Exit: (12) mangia(fred) ? creep
   Exit: (11) vivo(fred) ? creep
   Exit: (10) miagola(fred) ? creep
true.

*/
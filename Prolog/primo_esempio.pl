% Fatti -> e' tutto , il predicato e' la funzione senza l'argomento
gatto(tom).
gatto(fred).
tigre(mike).
vivo(tom).

% Regole, definisco X maiscola per idetificare una variabile
felino(X) :- gatto(X).
felino(X) :- tigre(X).
miagola(X) :- gatto(X),vivo(X).

/* Commenti per esecuzione:
Istruzioni Prolog per interrogare la risorsa creata

risorsa SWI-Prolog: https://www.swi-prolog.org/Download.html

CMD: swipl in ambiante WIN

['primo-esempio.pl']

gatto(tom).

felino(tom).

gatto(mike).

trace.              % -> per ottenere i passaggi che fa per dimostrare il fatto

gatto(Chi).         % NB: Chi ha la lettera maiuscola quindi e' una variabile, noi ci aspettiamo che ci risponda con tutti i gatti
Chi = tom ;         % Significa che se istanzio la varibile Chi con tom il risultato e' true, se seguo con un ';' prolog mi propone l'altrenativa a tom cioe fred
Chi = fred
                    % Stiamo effettuando Assunzioni di mondo chiuso, quello che non puo dimostrare e' falso. Spoiler la negazione classica non esiste perche' in prolog rappresentiamo una fetta della logica classica
                    % Un esempio che non posso fare in prolog e' che i pinguini sono uccelli e non volano, potevo farlo in OWL

felino(Chi).
Chi = tom ;
Chi = fred ;
Chi = mike.

*/

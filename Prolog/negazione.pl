% Voglio rappresentare degli insiemi con le liste nello specifico differenza tra insieme A e insieme B

/*      Fatti     */
differenza([],_,[]).                    %Assumiamo che A e B siano due set quindi non abbiano duplicati
differenza([X|Set],B,Res):-
    member(X,B),
    differenza([Set],B,Res).
differenza([X|Set],B,[X|Res]):-         %Devo trovare un modo per dire se X non sta in B devo metterlo ar risultato
    \+member(X,B),                      % Uso \+ che si chiama negazione per fallimento, tuttavia non è la negazione classica ma un comando extra logico solo operazionale. Fa tutto l'interprete prolog: quando trova un goal con la negazione semplicemnte la risolve e ribalta il risultato
    differenza(Set,B,Res)      



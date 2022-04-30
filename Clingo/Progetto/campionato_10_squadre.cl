%10 Squadre 3 Derby
squadra(1..10).
ha_stadio(1,torino).
ha_stadio(2,torino).
ha_stadio(3,milano).
ha_stadio(4,milano).
ha_stadio(5,roma).
ha_stadio(6,roma).
ha_stadio(7,napoli).
ha_stadio(8,bergamo).
ha_stadio(9,venezia).
ha_stadio(10,sassuolo).

giornata(1..18).

%match(squadraCasa,squadraTrasferta)    Crea tutti i match
9 {match(Squadra1,Squadra2):squadra(Squadra2),Squadra1<>Squadra2,not -match(Squadra1,Squadra2)} 9:-squadra(Squadra1).
%assegnaMatch(match,giornata)           Assegna i match alle giornate
5 {assegnaMatch(match(Squadra1,Squadra2),giornata(Giornata)):match(Squadra1,Squadra2)} 5:-giornata(Giornata).

%conta il numero di partite in casa
contaInCasa(Squadra,PartiteInCasa):-squadra(Squadra),PartiteInCasa = #count{G:assegnaMatch(match(Squadra,Squadra2),giornata(G))}.
contaAssegnamenti(Squadra1,Squadra2,NumeroAssegnamenti):-match(Squadra1,Squadra2),NumeroAssegnamenti = #count{G:assegnaMatch(match(Squadra1,Squadra2),giornata(G))}.

%Vincoli
:- giornata(Giornata),      %Per ogni giornata la stessa squadra può giocare una sola volta
    assegnaMatch(match(Squadra11,Squadra12),giornata(Giornata)),
    assegnaMatch(match(Squadra21,Squadra22),giornata(Giornata)),
    match(Squadra11,Squadra12)<>match(Squadra21,Squadra22),
    Squadra11 == Squadra21.

:- giornata(Giornata),      %Per ogni giornata la stessa squadra può giocare una sola volta
    assegnaMatch(match(Squadra11,Squadra12),giornata(Giornata)),
    assegnaMatch(match(Squadra21,Squadra22),giornata(Giornata)),
    match(Squadra11,Squadra12)<>match(Squadra21,Squadra22),
    Squadra12 == Squadra22.

:- giornata(Giornata),      %Per ogni giornata la stessa squadra può giocare una sola volta
    assegnaMatch(match(Squadra11,Squadra12),giornata(Giornata)),
    assegnaMatch(match(Squadra21,Squadra22),giornata(Giornata)),
    match(Squadra11,Squadra12)<>match(Squadra21,Squadra22),
    Squadra11 == Squadra22.

:- giornata(Giornata),      %Per ogni giornata la stessa squadra può giocare una sola volta
    assegnaMatch(match(Squadra11,Squadra12),giornata(Giornata)),
    assegnaMatch(match(Squadra21,Squadra22),giornata(Giornata)),
    match(Squadra11,Squadra12)<>match(Squadra21,Squadra22),
    Squadra12 == Squadra21.

:- match(Squadra1,Squadra2),contaAssegnamenti(Squadra1,Squadra2,NumeroAssegnamenti),NumeroAssegnamenti<>1.  %Verifichiamo che ogni match sia assegnato una sola volta

:- giornata(Giornata),      %Per ogni giornata solo una squadra per città può giocare in casa
    assegnaMatch(match(Squadra11,Squadra12),giornata(Giornata)),
    assegnaMatch(match(Squadra21,Squadra22),giornata(Giornata)),
    match(Squadra11,Squadra12)<>match(Squadra21,Squadra22),
    ha_stadio(Squadra11,Stadio11),
    ha_stadio(Squadra21,Stadio21),
    Stadio11 == Stadio21.

:- giornata(Giornata1), %Nel girone di andata non può esserci anche la partita di ritorno
   giornata(Giornata2),
   Giornata1<>Giornata2,
   Giornata1<=9,
   Giornata2<=9,
   assegnaMatch(match(Squadra11,Squadra12),giornata(Giornata1)),
   assegnaMatch(match(Squadra21,Squadra22),giornata(Giornata2)),
   Squadra11==Squadra22,
   Squadra21==Squadra12.

:- giornata(Giornata1), %Nel girone di andata non può esserci anche la partita di ritorno
   giornata(Giornata2),
   Giornata1<>Giornata2,
   Giornata1<=9,
   Giornata2<=9,
   assegnaMatch(match(Squadra11,Squadra12),giornata(Giornata1)),
   assegnaMatch(match(Squadra21,Squadra22),giornata(Giornata2)),
   Squadra11==Squadra22,
   Squadra21==Squadra12.
   

%Questo vincolo può valere solo per le prime 5 giornate in quanto senza una squadra a riposo non si può garantire questo vincolo perchè finiscono le permutazioni valide
:- giornata(Giornata1),     %Date due giornate successive la stessa squadra non eve giocare sempre in casa
    Giornata1<4,
    assegnaMatch(match(Squadra11,Squadra12),giornata(Giornata1)),
    assegnaMatch(match(Squadra21,Squadra22),giornata(Giornata1 + 1)),
    Squadra11 == Squadra21.
:- giornata(Giornata1),     %Date due giornate successive la stessa squadra non eve giocare sempre in casa
    Giornata1<4,
    assegnaMatch(match(Squadra11,Squadra12),giornata(Giornata1)),
    assegnaMatch(match(Squadra21,Squadra22),giornata(Giornata1 + 1)),
    Squadra12 == Squadra22.
   
:- match(Squadra1,Squadra2),
   assegnaMatch(match(Squadra1,Squadra2),giornata(Giornata1)),
   assegnaMatch(match(Squadra2,Squadra1),giornata(Giornata2)), 
   absolute2(Giornata1-Giornata2)<5.

#show assegnaMatch/2.
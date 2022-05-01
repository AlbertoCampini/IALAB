# Progetto d’esame per la parte programmazione logica

>Si richiede di implementare un sistema intelligente in grado di risolvere un
>problema a scelta in un dominio a scelta (anche “giocattolo”), ad eccezione del
>labirinto con una sola uscita. Sono esempi (ma la scelta NON è da considerarsi
>limitata ad essi) il mondo dei blocchi, il gioco del 15 (sliding block puzzle), il
>labirinto con più uscite.
>Si richiede di implementare in Prolog una strategia di ricerca nello spazio degli
>stati. In linea con quanto visto a lezione, è richiesto che il sistema sia composto da
>almeno tre file:

- un file regole.pl contenente le definizioni dei predicati trasforma/3 e applicabile/2;
- un file dominio.pl contenete i fatti che descrivono il dominio, lo stato iniziale e i goal;
- un file ricerca.pl contenente l’implementazione della strategia di ricerca con un
predicato prova/1 il cui argomento corrisponda ad un termine di output con il
risultato, ossia abbia il formato prova(+ListaAzioni). 

# Idea Progetto

 >Utilizzare come dominio di gioco una mappa chiusa e limitata da `num_righe`, `num_col` nella quale sono posizionati diversi checkpoint che devono essere raggiunti dal giocatore con un ordine non rilevante.

 All'interno del labirinto troviamo le seguenti tipologie di elementi : 
  - **Stato iniziale**: Il punto in cui il "giocatore" inizierà la sua partita, è indicato con `iniziale(pos(R,C))`
  - **Caselle vuote**: tutte le caselle in cui è possibile effettuare una mossa
  - **Muri**: le zone delimitate della mappa, il giocatore non ci può passare attraverso, è indicato con `occupata(pos(R,C))`
  - **Checkpoint**: le zone che definiamo i goal nella mappa, cioè quelli da raggiungere, è indicato con `checkpoints([pos(R,C)+])`.
 
 I movimenti possibili del giocatore sono:
  - Nord
  - Sud
  - Est
  - Ovest
  - Nord Est
  - Nord Ovest
  - Sud Est
  - Sud Ovest

## Strategie implementate

  - BLIND: il giocatore si muove in modo casuale per la mappa finchè non ha raggiunto tutti i checkpoint raggiungendo lo stato finale Checkpoints=[]
  - Informata numero 1: il giocatore calcola ad ogni mossa qual è il checkpoint più vicino ed esegue le mosse a lui disponibili in modo che sia eseguita prima quella che lo avvicina di più : PROBLEMA se la mossa migliore non è disponibile a causa di muri, la maggior parte delle altre mosse risultano equidistanti dal checkpoint e si rischia di andare fuori strada, ricordando anche che non può ripassare su una casella già attraversata.
  - Informata numero 2: il giocatore calcola ad ogni mossa qual è il checkpoint più vicino. Sulla base di questo calcola quale sarebbe la mossa migliore da eseguire indipendentemente dai muri. Il giocatore esegue la mossa che lo avvicina di più alla direzione migliore in cui dovrebbe andare, se non è disponibile usa ordinatamente le mosse più vicine a quella scelta, continua così finchè non riesce a spostarsi nella direzione migliore. Una volta spostato nella direzione migliore ricomincia la sua ricerca in modalità informata. Inoltre una volta raggiunto un checkpoint cancella la lista dei nodi visitati permettendogli di ripassare sulle stesse caselle.


# Progetto d’esame per la parte programmazione logica

>Si richiede di implementare un sistema intelligente in grado di risolvere un
>problema a scelta in un dominio a scelta (anche “giocattolo”), ad eccezione del
>labirinto con una sola uscita. Sono esempi (ma la scelta NON è da considerarsi
>limitata ad essi) il mondo dei blocchi, il gioco del 15 (sliding block puzzle), il
>labirinto con più uscite.
>Si richiede di implementare in Prolog una strategia di ricerca nello spazio degli
>stati. In linea con quanto visto a lezione, è richiesto che il sistema sia composto da
>almeno tre file:

- un file regole.pl contenente le definizioni dei predicati trasforma/3 e applicabile/
2;
- un file dominio.pl contenete i fatti che descrivono il dominio, lo stato iniziale e i
goal;
- un file ricerca.pl contenente l’implementazione della strategia di ricerca con un
predicato prova/1 il cui argomento corrisponda ad un termine di output con il
risultato, ossia abbia il formato prova(+ListaAzioni). 

# Idea Progetto

 >Creare un labirinto chiuso con diversi checkpoint che devono essere raggiunti in ordine
 >All'interno del labirinto troviamo 3 tipologie di elementi : Caselle vuote, Muri, Goal.
 >I movimenti possibili sono N,S,E,O,NE,NO,SE,SO
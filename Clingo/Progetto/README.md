# Progetto d’esame per la parte ASP

> Si richiede l’utilizzo del paradigma ASP (Answer Set Programming) per la
> generazione con clingo del calendario di una competizione sportiva, in particolare
> di un campionato avente le seguenti caratteristiche:
- sono iscritte 20 squadre ✅;
- il campionato prevede 38 giornate, 19 di andata e 19 di ritorno NON
simmetriche, ossia la giornata 1 di ritorno non coincide necessariamente con la
giornata 1 di andata a campi invertiti 🟨;
- ogni squadra fa riferimento ad una città, che offre la struttura in cui la squadra
gioca gli incontri in casa ✅;
- ogni squadra affronta due volte tutte le altre squadre, una volta in casa e una
volta fuori casa, ossia una volta nella propria città di riferimento e una volta in
quella dell’altra squadra ✅;
- due squadre della stessa città condividono la stessa struttura di gioco, quindi
non possono giocare entrambe in casa nella stessa giornata ✅;
- ci sono 3 derby, ossia 3 coppie di squadre che fanno riferimento alla medesima
città ✅.

FACOLTATIVO: in aggiunta alle caratteristiche sopra indicate, da considerarsi
obbligatorie, si richiede di considerare i seguenti vincoli ulteriori, che si potranno
aggiungere (tutti o alcuni) a discrezione del gruppo nel caso non rendano privo di
soluzione il problema:
- ciascuna squadra non deve giocare mai più di due partite consecutive in casa o
fuori casa 🟨;
- ci sono 4 derby (invece di 3) 🟨;
- la distanza tra una coppia di gare di andata e ritorno è di almeno 10 giornate,
ossia se SquadraA vs SquadraB è programmata per la giornata 12, il ritorno
SquadraB vs SquadraA verrà schedulato non prima dalla giornata 22 🟨.
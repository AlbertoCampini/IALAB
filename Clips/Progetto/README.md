# Progetto di Intelligenza Artificiale e Laboratorio
Modulo: CLIPS
a.a. 2021-2022

### Dreaming New Houses
> L’obiettivo del progetto è quello di sviluppare un sistema esperto che supporti un agente
immobiliare nel suo lavoro: suggerire a un potenziale cliente un numero ristretto di alloggi in
vendita da visitare. A tal fine dovete modellare la conoscenza di dominio considerando che un
appartamento è in genere caratterizzato dalle seguenti proprietà:

- metri quadri
- numero di vani (esclusi i servizi)
- numero di servizi
- numero di piano
- città
- zona: centro, prima cintura, periferia
- quartiere
- ascensore: sì, no
- box auto (ed eventuali mq)
- terrazzino: sì, no
- prezzo richiesto.

Ma questo è un elenco parziale, potete aggiungere tutte le proprietà che ritenete utili (ad esempio
qual è il contesto? È una casa indipendente? Teleriscaldamento? Classe energetica?)
A queste proprietà dovete anche aggiungere una rappresentazione del potenziale acquirente data in
termini di desiderata. Ad esempio, quanto vuole spendere al massimo? In che zona vorrebbe
acquistare casa etc.
Attenzione! Il cliente non sempre sa cosa vuole con precisione. Immaginate che il cliente si rivolge
a voi e vi comincia a parlare di come dovrebbe essere fatto l’alloggio che cerca. Questi desiderata
devono essere considerati come requisiti (vincoli) che dovrebbero essere considerati durante la
ricerca.
Per ogni proprietà il cliente potrebbe essere più o meno accomodante. Ad esempio, la presenza di un
box auto è un requisito non negoziabile: vicolo hard. Il numero di metri quadri invece potrebbe
essere un vincolo soft: se il cliente cerca un alloggio da 100 mq è legittimo proporne uno da 90 o
uno da 110. Con vincoli soft, quindi, avete un certo margine di scelta.
Tenete anche presente che non sempre il cliente sa tutto quel di cui ha bisogno fin dall’inizio. Ad
esempio, dopo avergli proposto un paio di soluzioni, vi chiede se le soluzioni trovate sono vicine
alla metro oppure no, oppure se vicino ci sono scuole per l’infanzia, etc. Questo vuol dire che deve
essere possibile interagire con il vostro sistema esperto in più passaggi di raffinamento.

### Cosa dovete fare
- Modellare il dominio: alloggi, ma anche città e loro quartieri e zone che aiutino a stabilire i
servizi disponibili, il costo per mq, etc.
- Organizzare il codice in moduli stabilendo un ciclo di esecuzione tra di essi.
- Scrivere le regole per il calcolo delle soluzioni. Queste regole devono:
    - dimostrare che viene fatto un po’ di reasoning (nel senso che vengono vagliate più soluzioni, 
e alcune sono scartate)
    - devono utilizzare della conoscenza empirica (di vostra fantasia, non entrerò nel merito
delle vostre scelte), ad esempio: meglio proporre un alloggio più piccolo di quello
richiesto se l’alloggio è ricercato in una zona costosa della città. L’uso dei CF 
(ma se proprio volete anche delle probabilità) deve essere alla base della 
modellazione dei softconstraints. 
   - Dovete dimostrare le inferenze del vostro sistema esperto predisponendo uno o più scenari 
 (e.g., fatti iniziali e richieste) in modo opportuno. Preparate quindi un database di 
alloggi in vendita, considerando che magari non avete tutte le informazioni su tutti gli alloggi. 
 Alcune cose semplicemente non le sapete. Potreste comunque proporre un alloggio anche se non 
ne conoscente tutti i dettagli, l’incertezza deve essere misurata dal CF che gli attribuite. 
   - Vi può tornare utile avere un profilo dell’utente in cui tracciate le sue preferenze 
rispetto al tipo di alloggio cercato; ma potreste anche chiedere al cliente dati sulla sua vita
privata che potrebbero tornarvi utili (es. ha figli piccoli? È uno sportivo? etc). I CF
possono servire per rappresentare dei gradi di credenza sulle preferenze del cliente.
Notate che il sistema deve essere interativo: dopo una prima scelta di alloggi, il cliente
potrebbe decidere di darvi qualche informazione in più. Le proposte al passo precedente
potrebbero essere confermate oppure rigettate dal vostro sistema esperto.
- Dimostrate di avere fatto prove con scenari alternativi: richieste di tipo diverso, ma anche
conoscenza più o meno completa delle preferenze del cliente (es., con i CF nell’intervallo [-1, 1] 
potete dire di non sapere se il cliente cerca un box associando un CF pari a 0).
Relazione

Nella breve relazione descrivete le scelte di progetto fondamentali. Come avete organizzato il
codice in moduli; come avete usati i CF nella modellazione del problema. La relazione deve anche
descrivere gli scenari che avete investigato e trarre delle conclusioni sulla bontà e limiti della
soluzione che proponente.
NB. La relazione deve essere accompagnata dal codice.
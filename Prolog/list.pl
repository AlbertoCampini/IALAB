/* Terza Lezione 08-03-2022 gestione delle liste in prolog

    Le liste sono formate tutte [Head|Tail] -> [1,'ciao',[x,y,z],'pippo',-1]

    memeber(x,[Head|Tail]) -> restituisce true se x appartiene alla lista [Head|Tail]
    memeber(25,[-4,3,25,6,7]) -> la risposta è true
    memeber(25,[-4,3,[1,2,25],6,7]) -> la risposta è false, infatti la memeber non va in profondità quindi non analizza la lista in posizione 3 vedi deepMemeber in riga 49

    select(x,[Head|Tail],Y) -> è simile a memeber ma rimuove l'elemento x dalla lista [Head|Tail] e in questo caso lo salva nel terzo argomento che è una variabile 
    select(25,[-4,3,25,6,7],Listarisultato) -> in lista risultato andra ad inserire la lista dopo aver torlto il 25 quindi [-4,3,6,7]
    select(25,[-4,3,25,6,7],[-4,3,6,7]) -> in questa situazione invece chiedo a prolog se la lista risultato ottenuta rimuovendo 25 è quella inserita come terzo argomento in questo caso la rispota è true, notiamo che select rimuove solo il primo elemento della lista, quindi inserendo più 25 la select rimuove solo il primo 25

    append([Head|Tail],[Head|Tail],Y) -> appende la lista [Head|Tail] alla lista [Head|Tail] e in questo caso salva il risultato nel terzo argomento che è una variabile 
    append([1,ciao],[23,45,[],], Res) -> Res conterra la concatenazione delle liste [1,ciao,23,45,[]]
    append([1,2],[3,4,[],], [1,2,3,4,[]]) -> come sempre il terzo risultato puo essere usato per verificare cvhe l'output sia quello

    lenght([Head|Tail],Int) -> restituisce in Int la dimensione della lista [Head|Tail]

    is_list(element) -> intuitivamente restituisce true se element è una lista [Head|Tail]

    is_var(X) -> intuitivamente restituisce true se X è una lista variabile quindi se e' 'maiuscola'
*/

somma([],0).                        % Caso base
somma([Head|Tail],Res) :- 
    somma(Tail,SommaTail),          % Fosse una funzione sarebbe somma([Head|Tail],Head + somma(Tail))
    Res is Head + SommaTail.        % Non posso fare quello che avevo in mente sopra, devo fare così


/*
    somma([1,2,3,4,5], Tot).
    Tot = 15

    somma([1,2,3,4,5], 15).
    true.



    Quarta Lezione 09-03-2022 esempio del prodotto al posto della somma
*/

prodotto([],0).                       % Caso base -> in questo caso il caso base non è 0 ma 1 perché è l'lemento neutro della moltiplicazione pero non è sufficente infatti il prodotto di un asola lista vuota è 0 non 1 quindi dobbiamo manipolare un po la questione
prodotto([Head],Head):-!.             % Quando abbiamo un solo elemento deve ritornre quell'elemento cosi da evitare di dare 0, il problema pero sorge ancora per il meccanismo di backtraking cioè prodotto([1,2,3],0). true. per risolvere vorremmo che quando applichiamo la regola di riga 37 non vogliamo piu usare il backtraking con questo ':-!'
prodotto([Head|Tail],Res) :- 
    prodotto(Tail,ProdTail),          % Fosse una funzione sarebbe prodotto([Head|Tail],Head * prodotto(Tail))
    Res is Head * ProdTail.           % Non posso fare quello che avevo in mente sopra, devo fare così


deepMember(X,List) :- 
    member(X,List).
deepMember(X,List) :- 
    member(SubList,List),
    deepMember(X,SubList).            


reverseList([],[]).
reverseList([Head|Tail],Res):-
 reverseList(Tail,ReverseTail),
 append(ReverseTail,[Head],Res).        % inserisco [Head] perche' append richiede due liste come argomenti

reverseListOpt(Lista,ListaInversa):-    % mi costruisco la lista inversa mentre sto effettuando la discesa ricorsiva senza fare un doppio passaggo
    inv(Lista,[],ListaInversa).

inv([],Tmp,Tmp).
inv([Head|Tail],Tmp,Res):-
    inv(Tail,[Head|Tmp],Res).






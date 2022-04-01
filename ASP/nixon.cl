%Nixon diamon 
pacifist(X):-quacker(X),not -pacifist(X).           %quacker -> gruppo di cattoloci sono normalemente pacifisti se nessuno specifica che uno non è pacifista:  -pacifist(X) -> a meno di eccezioni sono pacifisti
-pacifist(X):-republican(X),not pacifist(X).
quacker(nixon).
republican(nixon).

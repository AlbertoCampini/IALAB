%In ASP posso dire che pinguini sono uccelli che non volno, esiste la negazione come la conosciamo

bird(X):-penguin(X).
-fly(X):-penguin(X).
fly(X):-bird(X),not -fly(X).
bird(tweety).
penguin(tweety).
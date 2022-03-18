/*  Voglio dire che i Pinguini sono Uccelli ma non volano */

uccello(X) :- pinguino(X)                   % Se X e' un pinguino e' anche un'uccello
vola(X) :- uccello(X), \+pinguino(X)        % X vola se e' un uccello ma non vola se e' un pinguino questo \+ introduce un piccolo discostamento dalla monotonità della logica delprimo ordine. questo perche nella logica classica se aggiungo info non cambia nulla se prima dimostravo P(X) continuero' a farlo, adesso invece con la negazione non è detto perche' se aggiungo una cosa che mi nega un goal non lo dimostro piu
pinguino(Tweety).
tipo(integer).
tipo(float).
tipo(char).
variable(x).
variable(temp).

1 {ha_tipo(V,T):tipo(T)} 1:-variable(V).

#show ha_tipo/2.
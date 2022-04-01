% 2 tipi di persone:
% - onesti, che dicono sempre la verità
% - bugiardi, che mentono sempre
% a ci dice che sia b che c sono onesti
% b dice che a è bugiardo ma c è onesto

persona(a; b; c).
tipo(onesto; bugiardo).

1 {ha_tipo(P,T):tipo(T)} 1:-persona(P).

dice_il_vero(a):-ha_tipo(b,onesto),ha_tipo(c,onesto).
dice_il_vero(b):-ha_tipo(a,bugiardo),ha_tipo(c,onesto).

:-ha_tipo(P,onesto),not dice_il_vero(P).
:-ha_tipo(P,bugiardo),dice_il_vero(P).

#show ha_tipo/2.





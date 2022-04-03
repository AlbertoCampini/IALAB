team(qatar;olanda;brasile;argentina;inghilterra;germania;corea;arabia;ghana;camerun;giappone;canada;uruguay;australia;francia;spagna).
in(qatar,asia).
in(olanda,europa).
in(brasile,sudamerica).
in(argentina,sudamerica).
in(inghilterra,europa).
in(germania,europa).
in(corea,asia).
in(arabia,asia).
in(ghana,africa).
in(camerun,africa).
in(giappone,asia).
in(canada,america).
in(uruguay,sudamerica).
in(australia,oceania).
in(francia,europa).
in(spagna,europa).
girone(1..4).
testaDiSerie(francia;argentina;spagna).

1 {assegna(Squadra,N):girone(N)} 1:-team(Squadra).
4 {assegna(Squadra,N):team(Squadra)} 4:-girone(N).

quantiCont(N,DiversiContinenti):-girone(N),DiversiContinenti = #count{Continente:assegna(S,N),in(S,Continente)}.

:-girone(N),team(S1),team(S2),assegna(S1,N),assegna(S2,N),S1<>S2,testaDiSerie(S1),testaDiSerie(S2).
:-girone(N),quantiCont(N,DivCont),DivCont<3.



% con questo è unsatisfiable
%:-girone(N),team(S1),team(S2),assegna(S1,N),assegna(S2,N),S1<>S2,in(S1,C),in(S2,C).

#show assegna/2.




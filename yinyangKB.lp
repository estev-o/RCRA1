dominio(1..n).
color(white;black).

gridsize(n).

1{circle(X,Y,C):color(C)}1:-dominio(X), dominio(Y).

start(X1, Y1, C) :- color(C), #min{(X,Y): circle(X,Y,C)} = P, P=(X1,Y1).

%No puede haber cuadrados 2x2 del mismo color
:- circle(X,Y,C),circle(X,Y+1,C),circle(X+1,Y,C),circle(X+1,Y+1,C), X+1 <= n, Y+1 <= n.
%No puede haber diagonales (video)
:- circle(X,Y,C),circle(X,Y+1,C'),circle(X+1,Y,C'),circle(X+1,Y+1,C), X+1 <= n, Y+1 <= n.

%Definimos un predicado auxiliar (cierre transitivo)
vecino(X,Y,X-1,Y):- dominio(X),dominio(Y),X>=1.
vecino(X,Y,X+1,Y):- dominio(X),dominio(Y),X<n.
vecino(X,Y,X,Y-1):- dominio(X),dominio(Y),Y>=1.
vecino(X,Y,X,Y+1):- dominio(X),dominio(Y),Y<n.

%eligimos una celda inicial (única por color)
% 1{start(X,Y,C):circle(X,Y,C)}1:-color(C).

%propagamos desde la celda inicial a vecinos del mismo color
reach(X,Y,C):-start(X,Y,C).
reach(X2,Y2,C):-reach(X1,Y1,C), vecino(X1,Y1,X2,Y2), circle(X2,Y2,C).

%restricción de conectividad
:- circle(X,Y,C), not reach(X,Y,C).


extremo(1,Y,C) :- circle(1,Y,C).
extremo(n,Y,C) :- circle(n,Y,C).
extremo(X,n,C) :- circle(X,n,C).
extremo(X,n,C) :- circle(X,n,C).

% restricción extremo
:- extremo(1, Y1, C1), extremo(n, Y2, C2), extremo(X3, 1, C3), extremo(X4, n, C4), C1=C2, C3!=C1, C4=C3.
:- extremo(X1, 1, C1), extremo(X1, n, C2), extremo(1, X3, C3), extremo(n, X4, C4), C1=C2, C3!=C1, C4=C3.

_drawcircle(X-1,Y-1,C) :- circle(X,Y,C).

#show circle/3.

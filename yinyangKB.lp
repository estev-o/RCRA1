dominio(1..n).
color(white;black).

gridsize(n).

1{circle(X,Y,C):color(C)}1:-dominio(X), dominio(Y).

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

_drawcircle(X-1,Y-1,C) :- circle(X,Y,C).

#show circle/3.

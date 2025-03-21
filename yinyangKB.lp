dominio(1..n).
color(white;black).

gridsize(n).

1{circle(X,Y,C):color(C)}1:-dominio(X), dominio(Y).

%No puede haber cuadrados 2x2 del mismo color
:- circle(X,Y,C),circle(X,Y+1,C),circle(X+1,Y,C),circle(X+1,Y+1,C), X+1 <= n, Y+1 <= n.
%No puede haber diagonales (video)
:- circle(X,Y,C),circle(X,Y+1,C'),circle(X+1,Y,C'),circle(X+1,Y+1,C), X+1 <= n, Y+1 <= n.

%Definimos el principio
start(X1, Y1, C) :- color(C), #min{(X,Y): circle(X,Y,C)} = P, P=(X1,Y1).

%Definimos un predicado auxiliar (cierre transitivo)
vecino(X,Y,X-1,Y):- dominio(X),dominio(Y),X>=1.
vecino(X,Y,X+1,Y):- dominio(X),dominio(Y),X<n.
vecino(X,Y,X,Y-1):- dominio(X),dominio(Y),Y>=1.
vecino(X,Y,X,Y+1):- dominio(X),dominio(Y),Y<n.

%propagamos desde la celda inicial a vecinos del mismo color
reach(X,Y,C):-start(X,Y,C).
reach(X2,Y2,C):-reach(X1,Y1,C), vecino(X1,Y1,X2,Y2), circle(X2,Y2,C).

%restricción de conectividad
:- circle(X,Y,C), not reach(X,Y,C).

%representamos el borde como un array I=índice
%fila superior I=0...n-1
border(I,1,Y) :- gridsize(n), Y = 1..n, I = Y - 1.
%columna derecha I=n...2n-3 (hay que tener en cuenta esquinas, no repetirlas)
border(I,X,n) :- gridsize(n), X = 2..n-1, I = n + X - 2.
%fila inferior I=2n-2...3n-3
border(I,n,Y) :- gridsize(n), Y = 1..n, I = n + (n-2) + (n - Y).
%columna izquierda I=3n-2...4n-5
border(I,X,1) :- gridsize(n), X = 2..n-1, I = 2*n + (n-2) + (n - X) -1.

%restricción de aparición de dos cambios de color p.e. (blanco negro negro negro)
:- border(I1,X1,Y1), border(I2,X2,Y2), border(I3,X3,Y3), border(I4,X4,Y4), I1 < I2, I2 < I3, I3 < I4, circle(X1,Y1,C), circle(X2,Y2,C2), circle(X3,Y3,C), circle(X4,Y4,C2),C != C2.

_drawcircle(X-1,Y-1,C) :- circle(X,Y,C).

#show circle/3.

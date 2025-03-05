dominio(1..n).
color(white;black).

gridsize(n).

% Vecinos de anclas
reachable(X+1, Y, X, Y, C) :- start(X,Y,C), color(C), color(C'), not circle(X+1,Y,C'), C!=C',X+1<=n.
reachable(X-1, Y, X, Y, C) :- start(X,Y,C), color(C), color(C'), not circle(X-1,Y,C'), C!=C',X-1>0.
reachable(X, Y+1, X, Y, C) :- start(X,Y,C), color(C), color(C'), not circle(X,Y+1,C'), C!=C',Y+1<=n.
reachable(X, Y-1, X, Y, C) :- start(X,Y,C), color(C), color(C'), not circle(X,Y-1,C'), C!=C',Y-1>0.

% Generar vecinos de vecinos
reachable(X+1, Y, X, Y, C) :- reachable(X,Y, _, _, C), color(C), color(C'), not circle(X+1,Y,C'), C!=C',X+1<=n.
reachable(X-1, Y, X, Y, C) :- reachable(X,Y, _, _, C), color(C), color(C'), not circle(X-1,Y,C'), C!=C',X-1>0.
reachable(X, Y+1, X, Y, C) :- reachable(X,Y, _, _, C), color(C), color(C'), not circle(X,Y+1,C'), C!=C',Y+1<=n.
reachable(X, Y-1, X, Y, C) :- reachable(X,Y, _, _, C), color(C), color(C'), not circle(X,Y-1,C'), C!=C',Y-1>0.

circle(X,Y,C) :- reachable(X,Y, _, _, C).

% Prohibidos cuadrados 2x2 del mismo color
:- circle(X,Y,C), circle(X+1,Y,C), circle(X,Y+1,C), circle(X+1,Y+1,C).

% Que estén todos conectados
:- circle(X,Y,C), not reachable(_,_,X,Y,C), not start(X,Y,C).

% No puede haber diagonales
:- circle(X,Y,C), circle(X+1,Y,C'), circle(X,Y+1,C'), circle(X+1, Y+1, C), color(C), color(C'), C!=C'.

_drawcircle(X-1,Y-1,C) :- circle(X,Y,C).

#show reachable/5.
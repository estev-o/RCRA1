dominio(1..n).
color(white;black).

gridsize(n).

% Vecinos de anclas
reachable(X+1, Y, X, Y, C) :- anchor(X,Y,C), color(C), color(C'), not at(X+1,Y,C'), C!=C',X+1<=n.
reachable(X-1, Y, X, Y, C) :- anchor(X,Y,C), color(C), color(C'), not at(X-1,Y,C'), C!=C',X-1>0.
reachable(X, Y+1, X, Y, C) :- anchor(X,Y,C), color(C), color(C'), not at(X,Y+1,C'), C!=C',Y+1<=n.
reachable(X, Y-1, X, Y, C) :- anchor(X,Y,C), color(C), color(C'), not at(X,Y-1,C'), C!=C',Y-1>0.

% Generar vecinos de vecinos
reachable(X+1, Y, X, Y, C) :- reachable(X,Y, _, _, C), color(C), color(C'), not at(X+1,Y,C'), C!=C',X+1<=n.
reachable(X-1, Y, X, Y, C) :- reachable(X,Y, _, _, C), color(C), color(C'), not at(X-1,Y,C'), C!=C',X-1>0.
reachable(X, Y+1, X, Y, C) :- reachable(X,Y, _, _, C), color(C), color(C'), not at(X,Y+1,C'), C!=C',Y+1<=n.
reachable(X, Y-1, X, Y, C) :- reachable(X,Y, _, _, C), color(C), color(C'), not at(X,Y-1,C'), C!=C',Y-1>0.

at(X,Y,C) :- reachable(X,Y, _, _, C).

% Prohibidos cuadrados 2x2 del mismo color
:- at(X,Y,C), at(X+1,Y,C), at(X,Y+1,C), at(X+1,Y+1,C).

% Que estén todos conectados
:- at(X,Y,C), not reachable(_,_,X,Y,C), not anchor(X,Y,C).

% No puede haber diagonales
:- at(X,Y,C), at(X+1,Y,C'), at(X,Y+1,C'), at(X+1, Y+1, C), color(C), color(C'), C!=C'.

_drawcircle(X-1,Y-1,C) :- at(X,Y,C).

#show at/3.
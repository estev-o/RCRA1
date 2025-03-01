#const n=4.

white(1, 4).
black(2, 4).
black(3, 2).
white(3, 3).
white(4, 4).

% Reglas de propagación (se pueden evaluar tras grounding mediante operaciones en el cuerpo)
white(X-1,Y) :- white(X,Y), X-1 > 0, not black(X-1,Y).
black(X-1,Y) :- black(X,Y), X-1 > 0, not white(X-1,Y).

white(X+1,Y) :- white(X,Y), X+1 <= n, not black(X+1,Y).
black(X+1,Y) :- black(X,Y), X+1 <= n, not white(X+1,Y).

white(X,Y-1) :- white(X,Y), Y-1 > 0, not black(X,Y-1).
black(X,Y-1) :- black(X,Y), Y-1 > 0, not white(X,Y-1).

white(X,Y+1) :- white(X,Y), Y+1 <= n, not black(X,Y+1).
black(X,Y+1) :- black(X,Y), Y+1 <= n, not white(X,Y+1).

% Restricciones para evitar cuadrados 2x2 del mismo color
:- white(X,Y), white(X,Y+1), white(X+1,Y), white(X+1,Y+1), X+1 <= n, Y+1 <= n.
:- black(X,Y), black(X,Y+1), black(X+1,Y), black(X+1,Y+1), X+1 <= n, Y+1 <= n.

% Restricciones para evitar diagonales (video)
:- white(X,Y), white(X+1,Y+1), black(X,Y+1), black(X+1,Y), X+1 <= n, Y+1 <= n.
:- black(X,Y), black(X+1,Y+1), white(X,Y+1), white(X+1,Y), X+1 <= n, Y+1 <= n.

% Dominio de posiciones
pos(1..n).

%MAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAL
% Borde superior (fila 1) → borde inferior (fila n):
black(D,1),black(D,n),black(n,D) :- black(1,A), white(1,B), black(1,C), A < B, B < C, pos(D), D >= A, D <= C.
white(n,D),white(D,n),white(n,D) :- white(1,A), black(1,B), white(1,C), A < B, B < C, pos(D), D >= A, D <= C.

% Borde inferior (fila n) → borde superior (fila 1):
black(1,D),black(D,1),black(D,n) :- black(n,A), white(n,B), black(n,C), A < B, B < C, pos(D), D >= A, D <= C.
white(1,D),white(D,1),black(D,n) :- white(n,A), black(n,B), white(n,C), A < B, B < C, pos(D), D >= A, D <= C.

% Borde izquierdo (columna 1) → borde derecho (columna n):
black(D,n) :- black(A,1), white(B,1), black(C,1), A < B, B < C, pos(D), D >= A, D <= C.
white(D,n) :- white(A,1), black(B,1), white(C,1), A < B, B < C, pos(D), D >= A, D <= C.

% Borde derecho (columna n) → borde izquierdo (columna 1):
black(D,1) :- black(A,n), white(B,n), black(C,n), A < B, B < C, pos(D), D >= A, D <= C.
white(D,1) :- white(A,n), black(B,n), white(C,n), A < B, B < C, pos(D), D >= A, D <= C.


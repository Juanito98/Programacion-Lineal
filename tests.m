% Script que corre ejercicios que hicimos en clase.
% Sirven como unit tests para probar que los cambios que hagamos
% no rompan el comportamiento del algoritmo.

epsilon = 1e-9;

% Ejemplo 2.3
A = [1, 0; 0, 2; 3, 2];
b = [4; 12; 18];
c = [-3; -5];
[xo, zo, ban, ~] = mSimplex_leq(A, b, c);
assert(norm(xo-[2; 6]) == 0);
assert(zo == -36);
assert(ban == 0);

% Ejemplo 2.4
A = [1, 1, 2; 1, 1, -1; -1, 1, 1];
b = [9; 2; 4];
c = [1; 1; -4];
[xo, zo, ban, iter] = mSimplex_leq(A, b, c);
assert(norm(xo-[1/3; 0; 13/3]) < epsilon);
assert(zo == -17);
assert(ban == 0);
assert(iter == 2);

% Ejemplo 2.5 (Degenerado)
A = [-1, 1; 1, 0];
b = [0; 2];
c = [0; -1];
[xo, zo, ban, iter] = mSimplex_leq(A, b, c);
assert(norm(xo-[2; 2]) == 0);
assert(zo == -2);
assert(ban == 0);
assert(iter == 2);

% Ejemplo 2.6 (No acotado)
A = [1, -1; -1, 1];
b = [1; 2];
c = [-1; 0];
[xo, ~, ban, iter] = mSimplex_leq(A, b, c);
assert(norm(xo-[1; 0]) == 0);
assert(ban == 1);
assert(iter == 1);

% Ejercicio 2.5
A = [1, 0; 0, 1; -1, 1];
b = [3; 6; 5];
c = [-3; -5];
[xo, zo, ban, iter] = mSimplex_leq(A, b, c);
assert(norm(xo-[3; 6]) == 0);
assert(zo == -39);
assert(ban == 0);
assert(iter == 2);

% Ejemplo 2.7 (Ciclo infinito usando regla de mayor descenso)
A = [1, 1/2, -2, -1/2, 1, 0; -6, -2, 6, 1, 0, 1];
b = [0; 0];
c = [-1; -7/8; -13/4; -3/8; 0; 0];
[~, ~, ban, ~] = mSimplex_leq(A, b, c);
assert(ban == 1);

% Ejemplo 2.8
A = [-1, 1; -1, -2];
b = [-2; -3];
c = [8; 10];
[xo, zo, ban, iter] = mSimplex_leq(A, b, c);
assert(norm(xo-[7/3; 1/3]) < epsilon);
assert(zo == 22);
assert(ban == 0);
assert(iter == 2);

% Ejemplo 2.9
A = [-1, -1; 1, -1; 0, 1];
b = [-2; -1; 3];
c = [1; -2];
[xo, zo, ban, ~] = mSimplex_leq(A, b, c);
assert(norm(xo-[0; 3]) < epsilon);
assert(zo == -6);
assert(ban == 0);

fprintf("Tests succeded.\n");
function [xo, zo, ban, iter] = mSimplex_leq(A, b, c)
% purpose: Versión del Simplex (Fase I, wrap)
%   minimizar   c^T x
%   sujeto a    Ax <= b ,   x >= 0
%
% In :  A   ... mxn matrix
%       b   ... vector columna con  m  renglones
%       c   ... vector columna con  n  renglones
%
% Out : xo  ... SFB  ́optima del problema
%       zo  ... valor  ́optimo del problema
%       ban ... indica casos:
%           -1 ... si el conjunto factible es vacío.
%           0  ... si se encontro una solución óptima.
%           1  ... si la función objetivo no es acotada.
%       iter... es el número de iteraciones (cambios de variables básicas)
%               que hizo el método
%       B   ... vector de indices de la SBF optima

n = length(c);
m = length(b);

AFaseI = [A, eye(m), -ones(m, 1)];
cFaseI = [zeros(n+m, 1); 1];

jB = (n+1:1:n+m)';
[menor, s] = min(b);
if menor < 0
    jB(s) = n+m+1;

[~, zoFaseI, ~, iterFaseI, B] = mSimplexFaseII_eq(AFaseI, b, cFaseI, jB);

if zoFaseI > 0
    ban = -1;
    return;
end

AFaseII = AFaseI(:, 1:n+m);
cFaseII = [c; zeros(m, 1)];

[xoFaseII, zo, ban, iterFaseII, ~] = mSimplexFaseII_eq(AFaseII, b, cFaseII, B);

xo = xoFaseII(1:n);
iter = iterFaseI + iterFaseII;

end
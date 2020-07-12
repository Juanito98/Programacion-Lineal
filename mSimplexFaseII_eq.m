function [xo, zo, ban, iter, B] = mSimplexFaseII_eq(A, b, c, jB)
%   minimizar   c^T x
%   sujeto a    Ax = b, x>=0
%
% In :  A   ... mxn matrix
%       b   ... vector columna con  m  renglones
%       c   ... vector columna con  n  renglones
%       jB  ... vector de indices de la SBF inicial.
%
% Out : xo  ... SFB  ́optima del problema
%       zo  ... valor  ́optimo del problema
%       ban ... indica casos:
%           0 ... si se encontro una solución óptima.
%           1 ... si la función objetivo no es acotada.
%       iter... es el número de iteraciones (cambios de variables básicas)
%               que hizo el método
%       B   ... vector de indices de la SBF optima
    
n = length(c);
B = jB;
N = setdiff((1:1:n)', B);
ban = -1;
iter = 0;

while ban == -1
    % tableau(A, b, c, B);   % Descomentar para imprimir el tableau en cada paso
    A_B = A(:, B);
    A_N = A(:, N);
    c_B = c(B);
    c_N = c(N);

    lambda = (A_B')\c_B;
    r_N = (A_N')*lambda - c_N;
    h = A_B\b;

    e = find(r_N > 0, 1);
    if isempty(e)
        ban = 0;
        break;
    end
    
    He = A_B\A(:,N(e));

    aux = h ./ He;
    aux(He<=0) = NaN;
    [~, s] = min(aux);
    
    if He(s) <= 0
        ban = 1;
        break;
    end
    
    [N(e), B(s)] = deal(B(s), N(e));
    iter = iter + 1;
end

xo = zeros(n, 1);
xo(B) = h;

zo = dot(lambda, b);

end
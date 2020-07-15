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
N = setdiff((1:n)', B);
ban = -1;
iter = 0;

% Mientras no hayamos encontrado solución óptima
% o una dirección de descenso no acotada ban = -1
while ban == -1
    %tableau(A, b, c, B);   % Descomentar para imprimir el tableau en cada paso
    A_B = A(:, B);
    A_N = A(:, N);
    c_B = c(B);
    c_N = c(N);

    lambda = (A_B')\c_B;
    r_N = (A_N')*lambda - c_N;
    h = A_B\b;

    % Utilizamos la regla de Bland y tomamos el primer índice
    % con entrada positiva
    e = find(r_N > 0, 1);
    if isempty(e)
        % En caso de que no exista ese índice entonces
        % hemos llegado a una solución óptima
        ban = 0;
        break;
    end
    
    He = A_B\A(:,N(e));

    % Necesitamos calcular el min hs/Hse tal que Hse > 0
    aux = h ./ He;
    % Ignoramos aquellos índices cuyo Hse <= 0
    aux(He<=0) = NaN;
    [~, s] = min(aux);
    
    if He(s) <= 0
        % En caso de que He <= 0 entonces el problema
        % no está acotado.
        ban = 1;
        break;
    end
    
    % Intercambiamos la variable de entrada con la de salida
    % actualizando los conjuntos B y N
    [N(e), B(s)] = deal(B(s), N(e));

    % Aumentamos en 1 el número de iteraciones
    iter = iter + 1;
end

% Calculamos la x óptima
xo = zeros(n, 1);
xo(B) = h;

% Calculamos la z óptima
zo = dot(lambda, b);

end
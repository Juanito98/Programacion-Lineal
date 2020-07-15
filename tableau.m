function [] = tableau(A, b, c, jB)
%   Purpose: Esta función imprime el tableau en el formato visto
%           en clase.
%
% In :  A   ... mxn matrix
%       b   ... vector columna con  m  renglones
%       c   ... vector columna con  n  renglones
%       jB  ... vector de indices de la SBF inicial.

n = length(c);
m = length(b);
B = jB;
N = setdiff((1:n)', B);

A_B = A(:, B);
A_N = A(:, N);
c_B = c(B);
c_N = c(N);

H = A_B\A_N;
h = A_B\b;

r_N = (H')*c_B - c_N;
alfa = dot(c_B, h);

AA = zeros(m, n);
AA(:, B) = eye(m);
AA(:, N) = H;
rr = zeros(n, 1);
rr(N) = r_N;

% Imprimimos el header de la tabla
fprintf("\n");
fprintf("#Ec| Base |");
for i = 1:n
    fprintf("\tx%d", i);
end
fprintf("\t| LD\n");
fprintf("%s", repmat('-', 1, 23 + 8*n));
fprintf("\n");

% Imprimimos la parte de x_B + Hx_N = h
for i = 1:m
    fprintf(" %d |  x%d  |", i, B(i));
    for j = 1:n
        fprintf("\t%.2f", AA(i, j));
    end
    fprintf("\t| %.2f", h(i));
    fprintf("\n");
end
fprintf("%s", repmat('-', 1, 23 + 8*n));
fprintf("\n");

% Imprimimos la fila de z
fprintf(" - |   z  |");
for i = 1:n
    fprintf("\t%.2f", rr(i));
end
fprintf("\t| %.2f\n", alfa);

fprintf("\n");

end
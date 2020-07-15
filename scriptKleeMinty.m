% 2.2 Complejidad exponencial
clear; close all; clc;

m = (3:10)';
n = length(m);
Iteraciones = zeros(n, 1);
CPU_Time = zeros(n, 1);

for i = 1:n
    [c, A, b] = generaKleeMinty(m(i));
    tStart = tic;
    [~, ~, ~, Iteraciones(i)] = mSimplex_leq(A, b, c);
    CPU_Time(i) = toc(tStart);
end

T = table(m, Iteraciones, CPU_Time)

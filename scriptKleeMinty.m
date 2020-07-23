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

figure(1)
title("Iteraciones")
hold on
plot(m,Iteraciones)
xlabel('m', 'fontsize', 14);
ylabel('#it', 'fontsize', 14);
hold off

figure(2)
title("CPU Time")
hold on 
xlabel('m', 'fontsize', 14);
ylabel('Segundos', 'fontsize', 14);
plot(m,CPU_Time)
hold off

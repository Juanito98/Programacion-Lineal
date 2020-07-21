% 2.3 Estudio empírico de complejidad con problemas aleatorios
clear; close all; clc;

% Creamos el número de casos
casos = 50;

% Inicializamos las variables que vamos a ocupar
n = zeros(casos, 1);
m = zeros(casos, 1);
is_bounded = zeros(casos, 1);
min_mn = zeros(casos, 1);
iter = zeros(casos, 1);
J_bounded = [];

for i = 1:casos
    % Generamos un problema de PL aleatorio
    [n(i), m(i), A, b, c] = generaProblemaAleatorio();
    min_mn(i) = min(n(i), m(i));
    % Corremos el problema con nuestro método
    [~, ~, ban, iter(i)] = mSimplex_leq(A, b, c);

    % Guardamos el caso en el que se encontró solución óptima
    if ban == 0
        J_bounded(end+1) = i;
    end
end

is_bounded(J_bounded) = 1;
J_notbounded = setdiff(1:casos, J_bounded);

T = table(n, m, iter, is_bounded)

scatter( min_mn(J_bounded), iter(J_bounded), 'b', 'filled')
hold on
scatter( min_mn(J_notbounded), iter(J_notbounded), 'r', 's', 'filled')
hold off

xlabel('min(m,n)', 'fontsize', 14);
ylabel('#it', 'fontsize', 14);
set(gca,'xscale','log')
set(gca,'yscale','log')
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
grid on
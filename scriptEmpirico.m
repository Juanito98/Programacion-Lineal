% 2.3 Estudio empírico de complejidad con problemas aleatorios
clear; close all; clc;

casos = 50;

min_mn = zeros(casos, 1);
iter = zeros(casos, 1);
J_bounded = [];

for i = 1:1:casos
    [n, m, A, b, c] = generaProblemaAleatorio();
    min_mn(i) = min(n, m);
    [~, ~, ban, iter(i)] = mSimplex_leq(A, b, c);
    if ban == 0
        J_bounded(end+1) = i;
    end
end

J_notbounded = setdiff(1:casos, J_bounded);

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
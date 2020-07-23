% 2.3 Estudio empírico de complejidad con problemas aleatorios
clear; close all; clc;

% Creamos el número de casos
casos = 50;

% Inicializamos las variables que vamos a ocupar
min_mn = zeros(casos, 1);
iter = zeros(casos, 1);
J_bounded = [];

for i = 1:casos
    % Generamos un problema de PL aleatorio
    [n, m, A, b, c] = generaProblemaAleatorio();
    nplusm(i)=n+m;
    min_mn(i) = min(n, m);
    % Corremos el problema con nuestro método
    [~, ~, ban, iter(i)] = mSimplex_leq(A, b, c);

    % Guardamos el caso en el que se encontró solución óptima
    
    if ban == 0
        J_bounded(end+1) = i;
    end
end

J_notbounded = setdiff(1:casos, J_bounded);

%scatter( (J_bounded), iter(J_bounded), 'b', 'filled')
scatter( nplusm(J_bounded), iter(J_bounded), 'b', 'filled')
hold on
%scatter( min_mn(J_notbounded), iter(J_notbounded), 'r', 's', 'filled')
scatter( nplusm(J_notbounded), iter(J_notbounded), 'r', 's', 'filled')
hold off

%Inciso c), aplicamos una regresion lineal a los datos log(#it) y log(n+m)
%de todos los casos, utilizando como motivo la expresion de las
%instrucciones log(#it)=p*log(n+m)+ C y guardamos los valores estadisticos
%de p y C en Beta

logiter=log(iter)
size(nplusm)
lognplusm=[ones(casos,1),log(nplusm)']
%Ejecuta la regresion lineal
Betas=lognplusm\logiter



%Correcciones al estilo de la grafica
xlabel('min(m,n)', 'fontsize', 14);
ylabel('#it', 'fontsize', 14);
set(gca,'xscale','log')
set(gca,'yscale','log')
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
grid on
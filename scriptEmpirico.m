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

figure(1)

scatter( min_mn(J_bounded), iter(J_bounded), 'b', 'filled')

hold on
scatter( min_mn(J_notbounded), iter(J_notbounded), 'r', 's', 'filled')

 p = polyfit(log(min_mn),log(iter),1);
 z = polyval(p,log(min_mn));
 loglog(min_mn,exp(z))
 
hold off

%Inciso c), aplicamos una regresion lineal a los datos log(#it) y log(min(n,m))
%de todos los casos, utilizando como motivo la expresion de las
%instrucciones log(#it)=p*log(min(n,m))+ C y guardamos los valores estadisticos
%de p y C en Beta


logiter=log(iter);
logmin_mn=[ones(casos,1),log(min_mn)];
%Ejecuta la regresion lineal
Betas1=logmin_mn\logiter




%Correcciones al estilo de la grafica
title('Iteraciones vs min(m,n) , Pruebas Aleatorias')
legend('Bounded','Not Bounded')
xlabel('min(m,n)', 'fontsize', 14);
ylabel('#it', 'fontsize', 14);
set(gca,'xscale','log')
set(gca,'yscale','log')
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
grid on

%Inciso c), aplicamos una regresion lineal a los datos log(#it) y log(n+m)
%de todos los casos, utilizando como motivo la expresion de las
%instrucciones log(#it)=p*log(n+m)+ C y guardamos los valores estadisticos
%de p y C en Beta

figure(2)

logiter=log(iter);
lognplusm=[ones(casos,1),log(nplusm)'];
%Ejecuta la regresion lineal
Betas2=lognplusm\logiter

scatter( nplusm(J_bounded), iter(J_bounded), 'b', 'filled')
hold on
scatter( nplusm(J_notbounded), iter(J_notbounded), 'r', 's', 'filled')
p = polyfit(log(nplusm)',log(iter),1);
 z = polyval(p,log(nplusm));
 loglog(nplusm,exp(z))
hold off

title('Iteraciones vs m+n , Pruebas Aleatorias')
legend('Bounded','Not Bounded')
xlabel('m+n', 'fontsize', 14);
ylabel('#it', 'fontsize', 14);
set(gca,'xscale','log')
set(gca,'yscale','log')
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
grid on
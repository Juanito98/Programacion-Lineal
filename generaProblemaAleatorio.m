function [n, m, A, b, c] = generaProblemaAleatorio()
% Purpose - Esta función genera un problema aleatorio de PL
%
% Output :  m ... número de restricciones
%           n ... número de variables
%           A ... mxn matrix
%           b   ... vector columna con  m  renglones
%           c   ... vector columna con  n  renglones

% generar dimensiones del problema
m = round(10*exp(log(20)*rand()));
n = round(10*exp(log(20)*rand()));

% generar A, b, c
sigma = 100;
A = round(sigma*randn(m,n));
b = round(sigma*abs(randn(m,1)));
c = round(sigma*randn(n,1));
    
end
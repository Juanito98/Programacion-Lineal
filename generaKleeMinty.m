function [c, A, b] = generaKleeMinty(m)
% Purpose - Esta función define c, A, b del problema
%       min     - sum_i{1}{m} x_i
%   sujeto a        x_1 <= 1
%               2* sum_j{1}{i-1} x_j + x_i <= 2^i - 1 para toda i = 2,...,m
%               x_1, ..., x_m >= 0
%
% Input :   m ... dimensión del problema
%
% Output :  
%           A ... mxn matrix
%           b   ... vector columna con  m  renglones
%           c   ... vector columna con  n  renglones

c = -ones(m, 1);
A = tril(ones(m)) + tril(ones(m), -1);
b = 2.^(1:1:m)' - 1;

end
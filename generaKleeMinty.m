function [c, A, b] = generaKleeMinty(m)

c = -ones(m, 1);
A = tril(ones(m)) + tril(ones(m), -1);
b = 2.^(1:1:m)' - 1;

end
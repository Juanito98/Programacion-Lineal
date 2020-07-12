A = [1, 0; 0, 2; 3, 2];
b = [4; 12; 18];
c = [-3; -5];
[xo, zo, ban, iter] = mSimplex_leq(A, b, c)
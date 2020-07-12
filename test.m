A = [1, 1, 2, 1, 0, 0;
    1, 1, -1, 0, 1, 0;
    -1, 1, 1, 0, 0, 1];
b = [9; 2; 4];
c = [1; 1; -4; 0; 0; 0];
jB = [4; 5; 6];

[xo, zo, ban, iter, B] = mSimplexFaseII_eq(A, b, c, jB);

A = [-1, 1; -1, -2];
b = [-2; -3];
c = [8; 10];
[xo, zo, ban, iter] = mSimplex_leq(A, b, c)
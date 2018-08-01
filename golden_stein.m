function value = golden_stein ( x , y )

value = (1 + (((x + y + 1) ^ 2) * (19 - 14 * x + 3 * (x ^2) - 14 * y + 3 * (y ^ 2) - 6 * x * y))) ...
    * (30 + (((2 * x - 3 * y) ^ 2) * (18 - 32 * x + 12 * (x ^ 2) + 48 * y - 36 * x * y + 27 * (y ^ 2)))) ;

end
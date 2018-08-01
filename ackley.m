function value = ackley( x,number )

value = -20 * exp (-0.2 * sqrt (sum(x .* x)/number)) - exp (sum(cos(2 * pi * x))/number) + 20 + exp (1) ;

end
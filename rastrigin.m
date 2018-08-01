function gene_function_value = rastrigin (x)

gene_function_value = sum (x .* x - 10 * cos (2 * pi * x) + 10) ;

end
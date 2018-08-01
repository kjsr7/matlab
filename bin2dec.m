function value = bin2dec( x,length )

value = 0;
k = (2 ^ (length - 1)) - 1 ;
for i = 1 : length
    value = value + x(1,i) * k;
    k = k / 2 ;
    k = floor (k) ;

end
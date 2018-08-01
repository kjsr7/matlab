function value=bina2dec(x,length_of_genes)

value=0;
k=(2^(length_of_genes-1))-1;
for i=1:length_of_genes
    value=value+x(1,i)*k;
    k=k/2;
    k=floor(k);
end;
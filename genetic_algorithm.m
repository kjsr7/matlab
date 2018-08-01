gene = ceil ( rand (10,10) - 0.5 );
length = 10;
pc = 0.5;
number_of_genes = 10;
min = -5.12;
max = 5.12;
number_of_crosses = pc * number_of_genes;
function_max = [];
for p = 01 : 100
    new_generation = [];
    new_generation = [];
    mutated_generation = [];
    for i = 1 : number_of_crosses
        j = ceil  (10 * rand (1)); %Gene Number of first cross
        k = ceil  (10 * rand (1)); %Gene Number of second cross
        point_selected = ceil (10 * rand(1)); %Single Point to cross
        for l = point_selected : 10
            gene1 = gene (j,:);
            gene2 = gene (k,:);
            x = gene1 (1,l); % Swapping
            gene1 (1,l) = gene2 (1,l);
            gene2 (1,l) = x;
        end
        new_generation = cat (1 , new_generation , gene1 , gene2);
    end
    mutated_generation = new_generation;
    number_of_genes = 2* number_of_crosses;
    for i = 1 : number_of_genes
        a = ceil (10 * rand (1)); %Number of points to be mutated
        for j = 1 : a
            b = ceil (10 * rand(1)); %Points to be mutated
            if mutated_generation (i , b) == 1
                mutated_generation (i , b) = 0;
            else mutated_generation (i , b) = 1;
            end
        end
    end
    gene = cat (1 , gene , new_generation , mutated_generation);
    gene_value = [];
    for i = 01 : 30
        k = 2 ^ (length - 1);
        sum = 0;
        for j = 01 : 10
            sum = sum + k * gene (i , j);
            k = k / 2;
        end
        gene_value (i , 1) = sum; %#ok<*SAGROW>
    end
    gene_actual_value = (min + ((max - min) * gene_value))/(2 ^ length - 1);
    gene_function_value = rastrigin (gene_actual_value);
    gene_function_value_sorted = sort (gene_function_value , 'ascend');
    gene_function_value = cat (2 , gene_function_value , gene);
    gene = [];
    for i = 01 : 10
        for j = 01 : 30
            if gene_function_value_sorted (i , 1) == gene_function_value (j , 1);
                gene (i , 01 : 10) = gene_function_value (j , 02 : end);
            end
        end
    end
    function_max (p , 1) = gene_function_value_sorted (1 , 1);
end
plot(function_max);
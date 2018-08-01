%Using GA to find minimum value of n-dimensional functions
for fg = 1 : 3
    clear all;
    close all;
    % clc;
    tic ;
    
    %% Constants
    
    length_of_genes = 20 ;          %Length of each gene
    number_of_genes = 20 ;          %Number of genes in original generation
    number_of_dimensions = 30 ;     %Number of dimensions in function to be optimized
    number_of_generations = 3000 ;  %Number of generations
    pc = 0.8 ;                      %Probability of crossover among genes
    min = -500 ;                    %Lower bound of function to be optimized
    max =  500 ;                    %Upper bound of function to be optimized
    fitnessFunction = @(x) sphere (x) ;
    decValue = @(x) bin2dec (x,length_of_genes) ;
    actValue = @(x) (min + ((max - min) .* x)/(2.^(length_of_genes)-1)) ;
    generation.binary = [] ;
    generation.decValue = [] ;
    generation.actValue = [] ;
    generation.fitness = [] ;
    
    %% Initializations
    
    number_of_crosses = number_of_genes * pc ;
    generation.binary = ceil (rand(number_of_genes,length_of_genes,number_of_dimensions) - 0.5) ;
    for i = 1 : number_of_genes
        for j = 1: number_of_dimensions
            generation.decValue (i,1,j) = decValue (generation.binary(i,:,j)) ;
            generation.actValue (i,1,j) = actValue (generation.decValue(i,1,j)) ;
        end
        generation.fitness (i,1) = fitnessFunction (generation.actValue(i,1,:)) ;
    end
    
    %% Main Generations Loop
    
    for i = 1 : number_of_generations
        
        %% Crossover
        
        new_generation = generation ;
        for j = 1 : number_of_crosses
            gene_1 = ceil (number_of_genes * rand) ; %First Parent Gene in Crossover
            gene_2 = ceil (number_of_genes * rand) ; %Second Parent Gene in Crossover
            point = ceil ((length_of_genes - 1) * rand) ; %The point for Single Point Crossover
            for k=point:length_of_genes
                [new_generation.binary(gene_2,k,:),new_generation.binary(gene_1,k,:)] =  ...
                    swap (new_generation.binary(gene_2,k,:),new_generation.binary(gene_1,k,:)) ;
            end
        end
        for j = 1 : number_of_genes
            for k = 1 : number_of_dimensions
                new_generation.decValue (j,1,k) = decValue (new_generation.binary(j,:,k)) ;
                new_generation.actValue (j,1,k) = actValue (new_generation.decValue(j,1,k)) ;
                new_generation.fitness (j,1) = fitnessFunction (new_generation.actValue(j,1,:)) ;
            end
        end
        
        %% Mutations
        
        mutated_generation = new_generation ;
        for j = 1 : number_of_genes
            number_of_mutation_points = ceil ((length_of_genes/2) * rand) ;
            for k = 1 : number_of_mutation_points
                point = ceil (length_of_genes * rand) ;
                if mutated_generation.binary(j,point,ceil(rand*number_of_dimensions)) == 1
                    mutated_generation.binary (j,point,:) = 0;
                else
                    mutated_generation.binary (j,point,:) = 1;
                end
            end
            for k = 1 : number_of_dimensions
                mutated_generation.decValue (j,1,k) = decValue (mutated_generation.binary(j,:,k)) ;
                mutated_generation.actValue (j,1,k) = actValue (mutated_generation.decValue(j,1,k)) ;
                mutated_generation.fitness (j,1) = fitnessFunction (mutated_generation.actValue(j,1,:)) ;
            end
        end
        
        %% Sorting
        
        total_generation.binary = cat (1, generation.binary,new_generation.binary, mutated_generation.binary);
        total_generation.decValue = cat (1, generation.decValue,new_generation.decValue, mutated_generation.decValue);
        total_generation.actValue = cat (1, generation.actValue,new_generation.actValue, mutated_generation.actValue);
        total_generation.fitness = cat (1, generation.fitness,new_generation.fitness, mutated_generation.fitness);
        total_generation.sorted = sort (total_generation.fitness, 'ascend') ;
        for j = 1 : number_of_genes
            for k = 1 : size (total_generation.fitness)
                if total_generation.sorted (j, 1) == total_generation.fitness (k, 1);
                    for l = 1 : number_of_dimensions
                        generation.binary (j, :, l) = total_generation.binary (k, :, l);
                        generation.decValue (j, 1, l) = total_generation.decValue (k, 1, l);
                        generation.actValue (j, 1 ,l) = total_generation.actValue (k, 1, l);
                    end
                    generation.fitness (j, 1) = total_generation.fitness (k,1);
                end
            end
        end
        bestValue (i) = total_generation.sorted (1,1) ; %#ok<*SAGROW>
    end
    
    %% Results
    
    plot (bestValue) ;
    display (['Best Value acheived (GA) = ',num2str(bestValue (end, end))]) ;
    toc;
end

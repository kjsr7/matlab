%Using A GA PSO Hybrid to find the minimum value of the Rastrigin Function

for fg = 1 : 4
clear all;
close all;
% clc;
tic ;

%% GA Constants

length_of_genes = 20 ;          %Length of each gene
number_of_genes = 20 ;          %Number of genes in original generation
number_of_dimensions = 30 ;     %Number of dimensions in function to be optimized
number_of_iterations = 3000 ;  %Number of generations
number_of_generations = number_of_iterations / 2 ;
pc = 0.8 ;                      %Probability of crossover among genes
min = -100 ;                   %Lower bound of function to be optimized
max =  100 ;                   %Upper bound of function to be optimized
v_max = 500 ;
v_min = 0 ;
fitnessFunction = @(x) ackley (x,number_of_dimensions) ;
decValue = @(x) bin2dec (x,length_of_genes) ;
actValue = @(x) (min + ((max - min) .* x)/(2.^(length_of_genes)-1)) ;
generation.binary = [] ;
generation.decValue = [] ;
generation.actValue = [] ;
generation.fitness = [] ;

%% PSO Constants

w = 1 ;                               %Inertial Weight
number_of_particles = number_of_genes ;%Number of particles in swarm
c1i = 2 ;                               %Personal initial acceleration coefficient
c2i = 2 ;                               %Social initial acceleration coefficient
c1f = 0.1 ;                               %Personal initial acceleration coefficient
c2f = 15 ;                               %Social initial acceleration coefficient
c1  = c1i ;
c2  = c2i ;
particle.position = [] ;                %Declaring Particle position array
particle.velocity = [] ;                %Declaring Particle velocity array
particle.fitness = [] ;                 %Declaring Particle fitness array
particle.bestPosition = [] ;            %Declaring Particle best position array
particle.bestFitness = [] ;             %Declaring Particle best fitness array
bestValues = [];

%% GA Initializations

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
            if mutated_generation.binary(j,point,point) == 1
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
    total_generation.decValue = cat(1, generation.decValue,new_generation.decValue, mutated_generation.decValue);
    total_generation.actValue = cat(1, generation.actValue,new_generation.actValue, mutated_generation.actValue);
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

%% PSO Initializations

w = 8 ;
c1 = c1i ;
c2 = c2i ;
g_best.fitness = inf ;                               %Global Best initialization
g_best.position = [] ;
for i = 1 : number_of_particles
    for j = 1 : number_of_dimensions
        swarm(i).position (1, j) = generation.actValue (i, 1, j) ; %Initialising the postion of the swarm
    end
    swarm(i).velocity = rand (1,number_of_dimensions);                %Initialising the velocity of the swarm
    swarm(i).fitness = fitnessFunction (swarm(i).position);            %Initialising the fitness of the swarm
    swarm(i).bestPosition = swarm(i).position;                     %At t=0, all the particles are at the best
    swarm(i).bestFitness = swarm(i).fitness;                       %At t=0, all the particles are at the best
    if swarm(i).fitness < g_best.fitness
        g_best.fitness = swarm(i).fitness;
        g_best.position = swarm(i).position;
    end
end

%% PSO Main Loop

for i = i : number_of_iterations
    for j = 1 : number_of_particles
        swarm(j).position = swarm(j).position + swarm(j).velocity ; %Position Update
        swarm(j).fitness = fitnessFunction(swarm(j).position) ;     %Fitness Update
        for k = 1 : number_of_dimensions
            if swarm(j).position(1,k) > max
                swarm(j).position(1,k) = max;
            elseif swarm(j).position(1,k) < min
                swarm(j).position(1,k) = min ;
            end
            if swarm(j).velocity(1,k) > v_max
                swarm(j).velocity(1,k) = v_max ;
            elseif swarm(j).velocity(1,k) < v_min
                swarm(j).velocity(1,k) = v_min ;
            end
        end
        if swarm(j).fitness < swarm(j).bestFitness
            swarm(j).bestFitness = swarm(j).fitness;
            swarm(j).bestPosition = swarm(j).position;
        end
        if swarm(j).fitness < g_best.fitness
            g_best.fitness = swarm(j).fitness ;
            g_best.position = swarm(j).position ;
        end
        w = w - (w * (i / number_of_iterations)) ;
%         c1 = (c1f - c1i) * (i / number_of_iterations) + c1i ;
%         c2 = (c2f - c2i) * (i / number_of_iterations) + c2i ;
        swarm(j).velocity = w*swarm(j).velocity + c1*rand*(swarm(j).bestPosition - swarm(j).position) ...
            + c2*rand*(g_best.position - swarm(j).position) ;       %Velocity Update
    end
    bestValues (i) = g_best.fitness;  %#ok<*SAGROW>
end

%% Result

disp (['Best Value (Hybrid) = ',num2str(g_best.fitness)]) ;
%  plot (bestValues) ;
toc;
end

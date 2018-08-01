%Using PSO to find minimum value of n-dimenional function

clear all;
close all;
clc;
tic ;

%% Constants

w = 1.0 ;                               %Inertial Weight
w_damp = 0.6 ;                         %Damping coefficient of Inertial weight
number_of_dimensions = 30 ;             %Number of dimensions the function has
c1 = 2.25 ;                             %Personal acceleration coefficient
c2 = 2.25 ;                             %Social acceleration coefficient
number_of_particles = 50 ;              %Number of particles in swarm
number_of_iterations = 2000 ;            %Number of iterations of PSO loop
min = -5.12 ;                           %Minimum vlaue of any dimension
max =  5.12 ;                           %Maximum value of any dimension
fitnessFunction = @(x) rastrigin (x) ;  %Fitness function to be optimized
particle.position = [] ;                %Declaring Particle position array
particle.velocity = [] ;                %Declaring Particle velocity array
particle.fitness = [] ;                 %Declaring Particle fitness array
particle.bestPosition = [] ;            %Declaring Particle best position array
particle.bestFitness = [] ;             %Declaring Particle best fitness array
bestValues = [];

%% Initializations

swarm = repmat (particle , number_of_particles ,1) ; %Initializing the swarm
g_best.fitness = inf ;                               %Global Best initialization
g_best.position = [] ;
for i = 1 : number_of_particles
    swarm(i).position = rand (1,number_of_dimensions)*(max - min)+min; %Initialising the postion of the swarm
    swarm(i).velocity = zeros (1,number_of_dimensions);                %Initialising the velocity of the swarm
    swarm(i).fitness = fitnessFunction (swarm(i).position);            %Initialising the fitness of the swarm
    swarm(i).bestPosition = swarm(i).position;                         %At t=0, all the particles are at the best
    swarm(i).bestFitness = swarm(i).fitness;                           %At t=0, all the particles are at the best
    if swarm(i).fitness < g_best.fitness
        g_best.fitness = swarm(i).fitness;
        g_best.position = swarm(i).position;
    end
end

%% PSO Main Loop

for i = 1 : number_of_iterations
    for j = 1:number_of_particles
        swarm(j).velocity = w*swarm(j).velocity + c1*rand*(swarm(j).bestPosition - swarm(j).position) ...
            + c2*rand*(g_best.position - swarm(j).position) ;       %Velocity Update
        swarm(j).position = swarm(j).position + swarm(j).velocity ; %Position Update
        swarm(j).fitness = fitnessFunction(swarm(j).position) ;     %Fitness Update
        for k = 1 : number_of_dimensions
            if swarm(j).position(1,k) > max
                swarm(j).position(1,k) = max;
            elseif swarm(j).position(1,k) < min
                swarm(j).position(1,k) = min ;
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
    bestValues (i) = g_best.fitness;
    w = w * w_damp ;
    end
end

%% Result

disp (['Best Position = ',num2str(g_best.position),' \n ','Best Value = ',num2str(g_best.fitness)]) ;
plot (bestValues) ;
toc;